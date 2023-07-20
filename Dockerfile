# Stage 1: Build the frontend application
FROM node:latest as build

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and package-lock.json to install dependencies
COPY package*.json ./

# Install frontend dependencies
RUN npm install

# Copy the rest of the frontend application code to the container
COPY . .

# Build the frontend application (modify the build command based on your project setup)
RUN npm run build

# Stage 2: Serve the frontend application using Nginx
FROM nginx:latest

# Copy the built frontend files from the build stage to Nginx's web root directory
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80 (default for HTTP)
EXPOSE 80

# Start Nginx web server
CMD ["nginx", "-g", "daemon off;"]
