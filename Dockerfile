# Dockerfile for the Model Serving FastAPI Application

# 1. Base Image: Use an official, slim Python image.
FROM python:3.9-slim

# 2. Set the working directory inside the container.
WORKDIR /app

# 3. Copy only the necessary files for the serving application.
# We copy requirements.txt first to leverage Docker's layer caching.
COPY requirements.txt .
COPY model_serving.py .

# 4. Install the Python dependencies.
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copy the trained model into the image.
# IMPORTANT: This line assumes the 'model.pkl' file is present in the build context.
# In a deployment pipeline, you would first download the artifact, then build the image.
COPY model.pkl .

# 6. Expose the port that the application will run on.
EXPOSE 8000

# 7. Define the command to run the application.
# This will start the Uvicorn server for FastAPI.
CMD ["uvicorn", "model_serving:app", "--host", "0.0.0.0", "--port", "8000"]
