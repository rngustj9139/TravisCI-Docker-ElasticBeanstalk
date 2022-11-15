# 운영환경에서는 npm run build를 통해 나온 빌드파일을 만든다음에 사용자의 요청이 들어오면 nginx라는 웹서버가 빌드파일을 통해 요청을 처리한다.
FROM node:alpine as builder 

WORKDIR /usr/src/app

COPY package.json .

RUN npm install

COPY ./ ./

# start가 아닌 build이다.
RUN npm run build

FROM nginx
# 빌드된 파일들을 nginx가 접근할수 있는 디렉터리로 매핑을 해준다.
COPY --from=builder /usr/src/app/build /usr/share/nginx/html


# 운영환경을 위한 Dockerfile이다.
# docker build . 를 통해 이미지를 빌드한다.
# nginx에서는 80번이 기본 포트이다.
# 컨테이너를 실행할때는 docker run -p 8080:80 mnb9139/part6:latest