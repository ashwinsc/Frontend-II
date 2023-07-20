# Stage 1: Build the frontend application
FROM node:latest as build

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and package-lock.json to install frontend dependencies
COPY package*.json ./

# Install frontend dependencies
RUN npm install

# Copy the rest of the frontend application code to the container
COPY . .

# Build the frontend application (modify the build command based on your project setup)
RUN npm run build

# Stage 2: Serve the frontend application using httpd
FROM httpd:latest

# Copy the built frontend files from the build stage to httpd's web root directory
COPY --from=build /app/dist /usr/local/apache2/htdocs

# Expose port 80 (default for HTTP)
EXPOSE 80

# Stage 3: Set up the Node.js backend server
WORKDIR /app/server

# Copy the package.json and package-lock.json to install backend dependencies
COPY server/package*.json ./

# Install backend dependencies
RUN npm install

# Copy the rest of the backend server code to the container
COPY server .

# Expose port 3000 for the backend server (adjust if your server runs on a different port)
EXPOSE 3000

# Start the Node.js backend server
CMD ["node", "index.js"]
