# Build step
FROM node:alpine as builder

WORKDIR "/app"
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# /app/build    <--- This is the directory which must be copied.

# Run step
# Specify the base nginx image (defaults to nginx:latest).
FROM nginx
# Copy the built files from the build step into the default server directory.
COPY --from=builder /app/build /usr/share/nginx/html
# The default primary command for the nginx image starts the server, 
# so no specific command specification is needed.