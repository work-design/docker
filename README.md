# 通用 docker 配置

配合 [Github Actions](https://github.com/work-design/.github) 使用

[Docker 指南](https://github.com/work-design/home/blob/main/developer/docker.md)


## 如何运行
1. 在项目下运行：
`docker-compose -f docker/docker-compose.yml -f docker/docker-compose.web.yml`


## 其他
## debug

`docker exec -it container_id_or_name /usr/bin/fish`


## build 

在项目目录下，运行 `docker-compose --env-file .env.docker -f docker/docker-compose.yml build`


## 运行项目

1. docker pull
2. docker run ${WEB_IMAGE}
