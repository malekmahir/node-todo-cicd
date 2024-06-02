# Use a specific version of node to ensure consistent builds
FROM node:12.2.0-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and package-lock.json to install dependencies first
# This helps leverage Docker's caching mechanism
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Run tests
RUN npm run test

# Expose the application port
EXPOSE 8000

# Define the command to run the application
CMD ["node", "app.js"]
