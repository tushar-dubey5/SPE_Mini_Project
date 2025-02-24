# Use an official Python runtime as a base image
FROM python:3.8-slim

# Set the working directory
WORKDIR /app

# Copy all project files into the container
COPY . /app

# Install required dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Set execute permissions for Python scripts
RUN chmod +x calculator.py test_calculator.py

# Run the calculator script
CMD ["python3", "calculator.py"]
