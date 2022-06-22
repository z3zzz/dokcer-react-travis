# everything below this line is builder phase
FROM node:16-alpine as builder

WORKDIR '/app'
COPY package.json . 
RUN npm install
RUN mkdir node_modules/.cache && chmod -R 777 node_modules/.cache
COPY . .

RUN npm run build

# dispose all files created in above builder phase, except build directory.
FROM nginx 
COPY --from=builder /app/build /usr/share/nginx/html

