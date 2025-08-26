
FROM python:3.9-slim

WORKDIR /app

# 3. Copy only the necessary files for the serving application.
COPY requirements.txt .
COPY model_serving.py .

# 4. Install the Python dependencies.
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copy the trained model into the image.
COPY model.pkl .

# 6. Expose the port that the application will run on.
EXPOSE 8000

# 7. Define the command to run the application.
CMD ["uvicorn", "model_serving:app", "--host", "0.0.0.0", "--port", "8000"]
