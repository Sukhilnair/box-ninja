# Box Ninja

A simple game. The goal is to distroy all the boxes and create a highscore. 

## Files

- **index.html:** This file to show the frontend.
- **style.css:** This file is for supporting our frontend with some graphics.
- **main.js:** This is our backend. 
- **nginx.conf:** An Nginx configuration file to serve the index.html page on port 80 and 443 (HTTPS).
- **Dockerfile:** A file used to create a Docker image with the Nginx server, the HTML page,  statics file and SSL certificates.
- **docker-compose.yml:** A file used to create a Docker container with the Nginx server

## Steps to Build and Run the Docker Container

1. **Generate SSL Certificates (if not already generated):**
    ```bash
    mkdir ssl
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ssl/nginx.key -out ssl/nginx.crt -subj "/CN=localhost"
    ```

2. **Build the Docker Image:**
    ```bash
    docker build -t my-nginx-ssl-image .
    ```

3. **Run the Docker Container:**
    ```bash
    docker-compose up -d
    ```

4. **Access the Web Page:**
   - HTTP: Open a browser and go to `http://localhost`
   - HTTPS: Open a browser and go to `https://localhost` (you may need to accept the self-signed certificate)

## Pushing the Image to AWS ECR

1. **Retrieve an authentication token and authenticate your Docker client to your registry. Use the AWS CLI:**
    ```bash
    aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin <YOUR ECR URI>
    ```
    **Note:** If you receive an error using the AWS CLI, make sure that you have the latest version of the AWS CLI and Docker installed.

2. **Build your Docker image using the following command (if not already built):**
    ```bash
    docker build -t <TAG FOR DOCKER> .
    ```

3. **Tag your image so you can push the image to this repository:**
    ```bash
    docker tag <TAG FOR DOCKER> <YOUR ECR URI:TAG>
    ```

4. **Push this image to your newly created AWS repository:**
    ```bash
    docker push <TAG FOR DOCKER> <YOUR ECR URI:TAG>
    ```

## Docker Image Repository

The Docker image is hosted on Amazon ECR. You can pull it using:
```bash
docker pull public.ecr.aws/f8g8h5d4/sukhil-nginx:latest