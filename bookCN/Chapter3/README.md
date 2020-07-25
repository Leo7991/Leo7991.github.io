# 开始运行

#### Build

运行`bin/build.sh`来构建docker镜像`rails-devise-jw`。

#### Run

创建镜像后，运行：`docker-compose up -d` 然后，用`docker compose exec server rails db:create`初始化数据库。

## Test

```
rails db:reset db:seed RAILS_ENV="test"
rspec
```

## CORS

在默认情况下，`Rails-pangs`允许CORS并公开Authorization的Header。如果你想要禁用它，可以注释掉`config/cors.rb`文件的内容。