# Clone version node
FROM node:16.18-alpine

# Directory app run
WORKDIR /usr/local/app/nuxt

# Copy package to docker
COPY ["package*.json", "./"]

# Install package
RUN npm install

# Copy package to docker
COPY . .

# Server host local
ENV HOST 0.0.0.0

# Keep process container
CMD ["npm", "run", "dev"]
