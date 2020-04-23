FROM node:alpine as builder 
# everyhting here goes to build phase

WORKDIR '/app'

COPY package.json .
RUN yarn
COPY . .

RUN yarn build

# second from indicates new phase
FROM nginx

EXPOSE 80

# copy what we want from builder phase to nginx
COPY --from=builder /app/build /usr/share/nginx/html

# nginx started automatically
