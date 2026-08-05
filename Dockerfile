# Use the official Nginx image
FROM nginx:alpine

# Remove the default website
RUN rm -rf /usr/share/nginx/html/*

# Copy website files into the Nginx web directory
COPY . /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]