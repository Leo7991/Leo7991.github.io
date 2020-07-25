# 产品特性

#### 🚀 基于Rails 6

与`rails 5`不同，`rails 6`是未来发展的必然趋势。

#### 🚀 Rails API

使用流行前端的js库如`react`，`vuejs`，替换原来的`rails view`

#### 🚀 ActionCable

该项目演示了聊天的后端是如何使用JWT认证身份的actioncable，其功能如下：

- 用户可以
  - 创建/删除房间
  - 设置他/她的头像
- 其他用户可以加入房间
- 在房间内的用户可以
  - 互相发送消息
  - 更新消息
  - 删除消息
  - 发起其他人可以参加的投票
  - 随机选取房间内特定数量的用户

相关的fronend演示是用[react-pangu](https://github.com/ruilisi/react-pangu)编写，桥接前端和后端的js库是用的是[actioncable-jwt](https://github.com/ruilisi/actioncable-jwt)。

#### 🚀 [Devise](https://github.com/plataformatec/devise)

来自Devise官方文档：

> Devise是基于Warden的Rails身份验证解决方案。它具有以下特点：
>
> - 基于Rack;
> - 是一个基于Rails引擎的完整MVC解决方案;
> - 允许您同时运行多个模型;
> - 功能模块化，只需要调用所需要的模块。

由此可见，`devise`提供了一套完整的符合行业标准且方便使用的身份验证方式。

#### 🚀 JWT

JSON Web Tokens，是目前最流行的跨域认证解决方案。

#### 🚀 [devise-jwt](https://github.com/waiting-for-dev/devise-jwt)

实现了将`devise`和`jwt`技术融合，虽然也有其他开发者通过其它方式实现了两者的融合运用，但都效果欠佳。

我们在 [app/models/jwt_denylist.rb](https://github.com/ruilisi/Rails-pangu/blob/master/app/models/jwt_denylist.rb) 里面通过使用redis实现了 devise-jwt的 `denylist strategy`。

#### 🚀 Postgres

使用postgres作为默认数据库。当一个Web服务器的流量变得很大时，sqlite3显然无法满足我们的需求。

#### 🚀 Rspec

Ruby行为驱动测试框架，让TDD高效有趣。

#### 🚀 [RuboCop](https://docs.rubocop.org/)

Ruby代码静态分析和格式工具，基于社区Ruby样式准侧

#### 🚀 [CircleCI](https://circleci.com/)

CircleCI是一个行业流行的持续集成和持续部署的开发工具，方便与团队成员之间代码交流，密切协作。 在本项目中，我们通过CircleCI用`rspec`和`RuboCop`来测试`Rails-pangu`的代码库。

#### 🚀 [Factory Bot](https://github.com/thoughtbot/factory_bothttps://github.com/thoughtbot/factory_bot)

将Ruby对象设置为测试用例。

#### 🚀 Docker

Docker是标准的轻量级操作系统虚拟化解决方案，在全球得到了广泛应用。所以，我们也一并提供了Dockerfile文件和脚本来帮助生成docker镜像。

本项目提供的Docker构建方案包含了两大优化:

- Docker镜像构建加速

  当一个项目迭代增长时，上百甚至上千个Gem会被尝试或者使用。即使是对`Gemfile`的一个微小变动都会触发一次所有Gem的重新bundle，故而绝大部分bundle时间都浪费在去bundle绝大多数稳定的Gem，例如：`rails`, `pg`。为了解决这个问题，我们通过一个小技巧来加速docker构建过程。这个技巧就是分两次来bundle `Gemfile`，然后产生两层镜像文件：

  - 第一次为`Gemfile.core`构建镜像层，该文件服务于稳定或者核心的`Gem`，例如`rails`, `pg`。
  - 第二次为`Gemfile`构建镜像层，该文件服务于易于变化的或者非核心的`Gem`， 例如你自己写的或者forked项目。

  尽管这个过程会生成额外的Docker镜像层，使镜像变大（预计几百KB），但这样做是有意义的，因为程序运行时间比磁盘空间要有限得多。

  下面的`Dockerfile`代码片段演示了该镜像构建过程：

```
COPY Gemfile.core .
RUN echo 'gem: --no-document' >> ~/.gemrc && \
    cp ~/.gemrc /etc/gemrc && \
    chmod +r /etc/gemrc && \
    bundle install --gemfile Gemfile.core -j16 --binstubs=$BUNDLE_PATH/bin

COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install --gemfile Gemfile -j16 --binstubs=$BUNDLE_PATH/bin
```

- Gem构建加速 (仅为中国开发者提供)

  我们会将Gem源 `https://rubygems.org` 镜像到 `https://gems.ruby-china.com`, 这会帮助中国开发者加速Gem构建速度。

#### 🚀 [Puma](https://github.com/puma/puma)

Puma是一个简单、快速、线程化、高度并发的HTTP1.1服务器，用于Ruby/Rack应用的开发。

#### 🚀 Redis

几乎所有的Web项目都使用`redis`作为存储系统，因为它快速、高效、简洁。