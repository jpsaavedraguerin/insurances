FROM python:3.10-alpine

# Run command in host
RUN mkdir -p /home/app 
RUN mkdir -p /home/app/src

# Executes on the HOST machine
COPY ./src /home/app/src 
COPY requirements.txt /home/app
COPY .env /home/app

# Build environment
RUN pip install --upgrade pip
RUN pip3 install -r /home/app/requirements.txt

# Runs FastApi
CMD ["uvicorn", "home.app.src.main:app", "--host", "0.0.0.0", "--port", "80"]
