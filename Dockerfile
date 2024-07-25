# Use the official Nginx base image
FROM nginx:alpine

# Copy the custom Nginx configuration file
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy the HTML file to the Nginx directory
COPY index.html /usr/share/nginx/html/index.html
COPY main.js /usr/share/nginx/html/
COPY style.css /usr/share/nginx/html/

# Copy the SSL certificates
COPY ssl/nginx.crt /etc/nginx/ssl/nginx.crt
COPY ssl/nginx.key /etc/nginx/ssl/nginx.key

# Expose ports 80 and 443
EXPOSE 80 443

# Start Nginx when the container starts
CMD ["nginx", "-g", "daemon off;"]