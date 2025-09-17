FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-dev \
    build-essential \
    libpq-dev \
    && apt-get clean
WORKDIR /app
COPY requirements.txt /app/
RUN pip3 install --no-cache-dir -r requirements.txt
COPY . /app/
EXPOSE 8002
RUN python3 manage.py collectstatic 
CMD ["bash", "-c", "python3 manage.py migrate && python3 manage.py runserver 0.0.0.0:8002"]



