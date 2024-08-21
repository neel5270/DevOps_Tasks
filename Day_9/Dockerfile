# Use the official Nginx image from the Docker Hub
FROM nginx:latest

# Copy the HTML file to the Nginx default static content directory
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80 to the outside world
EXPOSE 80

# Start Nginx when the container has provisioned
CMD ["nginx", "-g", "daemon off;"]

