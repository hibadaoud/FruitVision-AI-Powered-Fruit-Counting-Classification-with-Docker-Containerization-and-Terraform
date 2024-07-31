import json
import random


def shuffle_coco_images_annotations(json_file_path, output_file_path):
    """
    Load a COCO JSON file, shuffle the images, and update the annotations 
    to correspond with the shuffled images, then save to a new file.
    
    Args:
    - json_file_path: Path to the input COCO JSON file.
    - output_file_path: Path where the shuffled JSON file will be saved.
    """
    # Load the JSON data
    with open(json_file_path, 'r') as file:
        data = json.load(file)
    
    # Shuffle images
    random.shuffle(data['images'])
    
    # Generate a mapping from the original image IDs to the new shuffled order
    new_order_image_ids = {image['id']: i + 1 for i, image in enumerate(data['images'])}
    
    # Update image IDs in the shuffled images list
    for image in data['images']:
        image['id'] = new_order_image_ids[image['id']]
    
    # Update image IDs in annotations to reflect the new image order
    for annotation in data['annotations']:
        annotation['image_id'] = new_order_image_ids[annotation['image_id']]
    
    # Save the updated data with shuffled images and annotations to a new file
    with open(output_file_path, 'w') as file:
        json.dump(data, file, indent=4)

# Example usage:
json_file_path = r"C:\Users\Hiba Daoud\Desktop\P2M\dataset\unknown\uknown1.json"
  # Adjust the file name as necessary
output_file_path = r"C:\Users\Hiba Daoud\Desktop\P2M\dataset\unknown\uknown1.json"  # Desired output path
shuffle_coco_images_annotations(json_file_path, output_file_path)
