# Introduction

# Rails-pangu

[英文文档 English document](https://github.com/ruilisi/rails-pangu/blob/master/README.md)

`Rails-pangu` 是一个基于**Rails 6(API Only)**框架搭建的一站式服务开发的技术解决方案，它整合了 [Devise](https://github.com/plataformatec/devise), [JWT(JSON Web Tokens)](https://jwt.io/), Postgres, Redis, Docker, Rspec, RuboCop, [CircleCI](https://circleci.com/) 等多项业界尖端技术，它是后端项目开发的起点，可作为开发者强有力的生产工具。

**整合这些前沿技术并让他们完全兼容运行并非易事，案例如下**： [Devise](https://github.com/plataformatec/devise)作为一个标准第三方权限认证组件，提供了标准的Rails身份验证解决方案，而 [JWT](https://jwt.io/)（JOSN Web Tokens）是一个基于（RFC 7519）开放标准，直接用JSON创建访问令牌的高效分布式解决方案，而不是通过用数据库进行身份验证。在实际的开发需求中，我们迫切希望通过融合以上这两种技术来解决用户身份验证的问题。但是，当我们研究以上两种解决方案时，我们发现了一些共同问题：

- 文档解释不清晰
- 存在多处bug
- 代码冗余、存在版本兼容性问题

与此同时，我们看到其他一些开发者也在研究这个问题，但是他们都面临着**Rails <= 5.0**与**Rails 6**版本兼容性的问题 。两者之间有很大区别，因此，通过梳理 `rails 6`, `devise`, `jwt` 这三项技术，我们顺利解决了这个难题，实现了三者在Rails中的完美融合。与此同时，非常感谢为此项目提供很多参考建议的朋友们，比如这篇文章： [Rails 5 API + JWT setup in minutes (using Devise)](https://medium.com/@mazik.wyry/rails-5-api-jwt-setup-in-minutes-using-devise-71670fd4ed03) 。

[![img](https://camo.githubusercontent.com/bb330de8bf9e6c7ee9247c517e6b1e844099ced0/68747470733a2f2f7265732e706169796f752e636f2f70616e67752e6a7067)](https://camo.githubusercontent.com/bb330de8bf9e6c7ee9247c517e6b1e844099ced0/68747470733a2f2f7265732e706169796f752e636f2f70616e67752e6a7067)

> 盘古是中国神话中万物的创造者。在神话故事中，盘古挥舞着巨大的斧头开辟了天地，矗立在天地之间使其分隔开来。 正如盘古一样, `Rails-pangu`志在成为你起用Rails新项目时的基础性代码库，从而减轻你在做新项目时繁琐的调研和实验工作。