ARG NODE=node:18-alpine

# Stage 1: Build the Next.js app
FROM ${NODE} AS deps

RUN apk add --no-cache libc6-compat

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json (or yarn.lock)
COPY package*.json ./

# Install dependencies
RUN npm install

# Stage 2: Build the app
FROM ${NODE} AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules

# Copy the rest of the app source code
COPY . .

RUN npm run build

# Stage 3: Serve the built app using a lightweight image
FROM ${NODE} AS production

# Use a lightweight web server for the static files
FROM nginx:alpine

# Copy built React app to NGINX's web root
COPY --from=builder /app/dist /usr/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
