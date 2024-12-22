import subprocess
import sys
import os
import distutils.core
import torch, detectron2
from detectron2.utils.logger import setup_logger
import numpy as np
import json, cv2, random
from cv2 import imshow 
from detectron2 import model_zoo
from detectron2.engine import DefaultPredictor
from detectron2.config import get_cfg
from detectron2.utils.visualizer import Visualizer
from detectron2.data import MetadataCatalog, DatasetCatalog
from detectron2.data.datasets import register_coco_instances
from detectron2.engine import DefaultTrainer
import pandas as pd
from PIL import Image
from collections import Counter
import sys
from torchvision.ops import nms


data_directory = "/app"

if not os.path.exists(data_directory):
    data_directory = r"C:\Users\Hiba Daoud\Desktop\P2M\dataset\dataset"

class ImageProcessor:
    def __init__(self, directory=data_directory):
        self.directory = directory

    def load_images(self):
        images = []
        for filename in os.listdir(self.directory):
            if filename.endswith(".jpg") or filename.endswith(".png") or filename.endswith(".jpeg"):
                img_path = os.path.join(self.directory, filename)
                try:
                    img = Image.open(img_path)
                    images.append(img)
                except IOError:
                    print(f"Erreur lors du chargement de l'image {filename}")
        return images



class ModelPredictor:
    def __init__(self, model_path, num_classes=7, score_thresh=0.6):
        self.cfg = get_cfg()
        self.configure(model_path, num_classes, score_thresh)
    
    def configure(self, model_path, num_classes, score_thresh):
        """Configure le modèle Detectron2."""
        config_path = '/app/detectron2/detectron2/model_zoo/configs/COCO-Detection/faster_rcnn_R_50_FPN_3x.yaml'
        self.cfg.merge_from_file(config_path)

        # self.cfg.merge_from_file(model_zoo.get_config_file("COCO-Detection/faster_rcnn_R_50_FPN_3x.yaml"))
        self.cfg.MODEL.ROI_HEADS.NUM_CLASSES = num_classes
        self.cfg.MODEL.WEIGHTS = model_path
        self.cfg.MODEL.ROI_HEADS.SCORE_THRESH_TEST = score_thresh
        self.cfg.MODEL.DEVICE = 'cpu'
    
    def get_predictor(self):
        return DefaultPredictor(self.cfg)

def show_image(image_path):
    image = cv2.imread(image_path)
    if image is not None:
        cv2.imshow('Image', image)
        cv2.waitKey(0)  
        cv2.destroyAllWindows()
    else:
        print("Erreur : L'image n'a pas pu être chargée.")


class ImageAnalyzer:
    def __init__(self, predictor, image, types):
        self.predictor = predictor
        self.image = image
        self.types = types

    def pluralize(self, count, word):
        if count == 1:
            return f"There is 1 {word}"
        else:
            # Check if the word ends in 'y' and not preceded by a vowel
            if word.endswith('y'):
                plural_word = word[:-1] + 'ies'  # Replace 'y' with 'ies'
            else:
                plural_word = word + 's'  # Standard pluralization
            return f"There are {count} {plural_word}"

    def analyze_image(self):
        outputs = self.predictor(self.image)
        instances = outputs["instances"].to("cpu")

        if self.image.shape[2] == 3:
            image_rgb = cv2.cvtColor(self.image, cv2.COLOR_BGR2RGB)
        else:
            image_rgb = self.image

        boxes = instances.pred_boxes.tensor
        scores = instances.scores
        pred_classes = instances.pred_classes

        iou_threshold = 0.75  # Intersection Over Union threshold
        keep_indices = nms(boxes, scores, iou_threshold)

        boxes_after_nms = boxes[keep_indices].numpy()
        scores_after_nms = scores[keep_indices]
        classes_after_nms = pred_classes[keep_indices]

        for box in boxes_after_nms:
            box = box.astype(np.int32)
            cv2.rectangle(image_rgb, (box[0], box[1]), (box[2], box[3]), (0, 255, 0), 2)

        self.image = cv2.cvtColor(image_rgb, cv2.COLOR_RGB2BGR)
        counts = Counter(classes_after_nms.numpy())
        most_common_class, most_common_count = counts.most_common(1)[0]
        most_common_type = self.types[most_common_class]
        # result_text = f"Number of {most_common_type}s is : \n{most_common_count}" if most_common_class != 1 else most_common_type
        # result_text = f"There are {most_common_count} {most_common_type}s " if most_common_class != 1 else most_common_type
        result_text = self.pluralize(most_common_count, most_common_type)

        # Return the analysis details
        return {
            "most_common_type": most_common_type,
            "result_text": result_text
        }

    def show_analyzed_image(self):
        cv2.imshow("Analyzed Image", self.image)
        cv2.waitKey(0)
        cv2.destroyAllWindows()

    def save_image(self, file_path):
        cv2.imwrite(file_path, self.image)
        print(f"Image saved to {file_path}")
        


def scale_image(image, scale_percent):
    # Calculate the new dimensions
    width = int(image.shape[1] * scale_percent / 100)
    height = int(image.shape[0] * scale_percent / 100)

    # Resize the image
    scaled_image = cv2.resize(image, (width, height), interpolation=cv2.INTER_AREA)

    return scaled_image


def visualize_predictions(image, predictor, dataset_name):
    outputs = predictor(image)
    metadata = MetadataCatalog.get(dataset_name)
    v = Visualizer(image[:, :, ::-1], metadata=metadata)  # Convert BGR to RGB for visualization.
    out = v.draw_instance_predictions(outputs["instances"].to("cpu"))
    visualized_image = out.get_image()[:, :, ::-1]  # Convert back to BGR for displaying with OpenCV.

    # Display the image
    cv2.imshow("Predictions", visualized_image)
    cv2.waitKey(0)
    cv2.destroyAllWindows()


if __name__ == "__main__":
    # Setup the data directory based on environment
    if not os.path.exists("/app"):
        data_directory = r"C:\Users\Hiba Daoud\Desktop\P2M\dataset\dataset"
    else:
        data_directory = "/app"
    
    # Setup the model predictor using a pre-trained model
    model_path = os.path.join(data_directory, "faster_rcnn_R_50_FPN_3x", "model_final.pth")
    predictor_obj = ModelPredictor(model_path)
    predictor = predictor_obj.get_predictor()

    # Load and preprocess an image
    test_image_path = os.path.join(data_directory, "val","fraise9.jpg")
    loaded_image = cv2.imread(test_image_path)
    scaled_image = scale_image(loaded_image, 100)

    types = ['Apple', 'Unknown','Strawberry', 'Kiwi', 'Lemon', 'Orange']
    analyzer = ImageAnalyzer(predictor, scaled_image, types)
    analysis_results = analyzer.analyze_image()
    print(analysis_results)
    analyzer.show_analyzed_image()


    output_image_path = os.path.join(data_directory, "image predicted", "fraise9.jpg")
    analyzer.save_image(output_image_path)