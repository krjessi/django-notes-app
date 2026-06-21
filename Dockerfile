# Base images
FROM python:3.11-slim

# Working Directory
WORKDIR /app/backend

# Copy requirements
COPY requirements.txt /app/backend

# Update & Install app dependencies
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*
RUN pip install mysqlclient
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application 
COPY . /app/backend

# Expose port
EXPOSE 8000

# Command to run application
CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]
