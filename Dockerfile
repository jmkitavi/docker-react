FROM node:alpine
# everything here goes to build phase
# removed "as builder" cause of AWS

WORKDIR '/app'

COPY package.json ./
COPY yarn.lock ./
RUN yarn
COPY . .

RUN yarn build

# second FROM indicates new phase
FROM nginx

# manually expose 80 for AWS
EXPOSE 80

# copy what we want from build phase to nginx
# use build phase numbering 0
COPY --from=O /app/build /usr/share/nginx/html

# nginx started automatically
