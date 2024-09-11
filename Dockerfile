# Use the official Node.js 16 image as the base image
FROM node:20

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json (or yarn.lock) to the container
COPY package*.json ./

# Install project dependencies
RUN npm install --legacy-peer-deps

RUN npm install --force

RUN npm install react@18.2.0 react-dom@18.2.0


ENV NODE_OPTIONS=--max_old_space_size=4096
RUN npm install sharp
RUN npx browserslist@latest --update-db


# Copy the rest of the application code to the container
COPY . .

# Build the React app
RUN npm run build

# Expose the port that the app will run on (usually 3000 by default)
EXPOSE 3000

# Start the React app when the container starts
CMD [ "npm", "start" ]
