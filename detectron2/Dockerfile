FROM python:3.12-slim

RUN apt-get update -qq && apt-get install -y \
    libgl1-mesa-glx \
    xvfb \
    wget \
    git \
    gcc \
    build-essential \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

   
WORKDIR /app


# Install any needed packages specified in requirements.txt
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

RUN git clone https://github.com/facebookresearch/detectron2.git
RUN pip install -e detectron2

# Copy the current directory contents into the container at /app
COPY . /app/

# Make port 8000 available to the world outside this container
EXPOSE 8000

# Command to run the FastAPI application using uvicorn
CMD ["uvicorn", "fastapi_code:app", "--host", "0.0.0.0"]
# CMD ["uvicorn", "fastapi_code:app", "--host", "0.0.0.0", "--port", "8000"]