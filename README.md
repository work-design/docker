# 通用 docker 配置

配合 [Github Actions](https://github.com/work-design/.github) 使用

[Docker 指南](https://github.com/work-design/home/blob/main/developer/docker.md)


## docker-compose

`docker-compose -f docker-compose.yml -f docker-compose.web.yml`

## debug

`docker exec -it container_id_or_name /usr/bin/fish`


## build 

在项目目录下，运行 `docker-compose --env-file .env.docker -f docker/docker-compose.yml build`


## 运行项目

1. docker pull
2. docker run ${WEB_IMAGE}
