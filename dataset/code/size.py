from PIL import Image

# Replace 'your_image.jpg' with the path to your image file
image_path = r"C:\Users\Hiba Daoud\Desktop\P2M\dataset\apple\train\apple36.jpg"

# Open the image file
with Image.open(image_path) as img:
    # Get image size
    width, height = img.size

print(f"Width: {width} pixels")
print(f"Height: {height} pixels")
