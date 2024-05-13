from fastapi import FastAPI, File, UploadFile, HTTPException
from fastapi.responses import FileResponse
import numpy as np
from PIL import Image
import cv2
from P2M import ModelPredictor, ImageAnalyzer, scale_image
from io import BytesIO
import uuid
import os  # Import the os module

app = FastAPI()

model_path = os.getenv("MODEL_PATH", "C:\\Users\\Hiba Daoud\\Desktop\\P2M\\dataset\\dataset\\faster_rcnn_R_50_FPN_3x\\model_final.pth")
base_url = os.getenv("BASE_URL", "http://192.168.192.95:8000")
predictor_obj = ModelPredictor(model_path)
predictor = predictor_obj.get_predictor()

@app.post("/analyze/")
async def analyze_image(file: UploadFile = File(...)):
    try:    
        contents = await file.read()  # Read file content
        if not contents:
            raise HTTPException(status_code=400, detail="No file uploaded")
        image = np.array(Image.open(BytesIO(contents)))  # Convert to numpy array
        image = cv2.cvtColor(image, cv2.COLOR_RGB2BGR)

        # Environment variable for model path and base URL
        # model_path="C:\\Users\\Hiba Daoud\\Desktop\\P2M\\dataset\\dataset\\faster_rcnn_R_50_FPN_3x\\model_final.pth"
        
        types = ['Apple', 'Unknown', 'Strawberry', 'Kiwi', 'Lemon', 'Orange']
        analyzer = ImageAnalyzer(predictor, image, types)
        analysis_results = analyzer.analyze_image()

        output_directory = "analyzed_images"
        output_filename = f"analyzed_image_{uuid.uuid4()}.png"
        output_path = os.path.join(output_directory, output_filename)

        cv2.imwrite(output_path, analyzer.image)
        full_url = f"{base_url}/get_analyzed_image/{output_filename}" 
        return {
            "image_url": full_url,
            "analysis": analysis_results,
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.get("/get_analyzed_image/{filename}")
async def get_analyzed_image(filename: str):
    return FileResponse(f"analyzed_images/{filename}")
