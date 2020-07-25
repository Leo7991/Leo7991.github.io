# 角色创建

除了我们提供的默认角色之外，我们还允许developer创建他们的[自定义角色](https://github.com/ruilisi/Rails-pangu/wiki/create-a-role)。

## Denylist

#### 默认redis黑名单

由于redis的访问内存的性能极高，redis是用来实现`denylist`的一个好的选择。在`jwt_denylist`中，我们用redis实现了黑名单。通过将`redis`的过期时间设置为与`jwt token`的过期时间相同，可以在令牌过期时自动从redis中删除此令牌。

```
  def self.jwt_revoked?(payload, user)
    # Check if in the denylist
    $redis.get("user_denylist:#{user.id}:#{payload['jti']}").present?
  end

  def self.revoke_jwt(payload, user)
    # REVOKE JWT
    expiration = payload['exp'] - payload['iat']
    $redis.setex("user_denylist:#{user.id}:#{payload['jti']}", expiration, payload['jti'])
  end
```

#### 自定义黑名单

你也可以通过自己的策略实现黑名单。你只需要重写两个方法：`jwt-revoked？`以及`jwt-denylist.rb`中的`revoke-jwt`，这两个方法都接受jwt负载和`user`记录作为参数。

```
  def self.jwt_revoked?(payload, user)
    # Does something to check whether the JWT token is revoked for given user
  end

  def self.revoke_jwt(payload, user)
    # Does something to revoke the JWT token for given user
  end
```

#### 请求调用

您可以在`device.rb`中配置`dispatch`请求。当配置它时，您需要说明哪些请求将为以前经过身份验证的用户分派令牌（通常通过其他一些Warden策略，例如需要用户名和电子邮件参数的策略）。配置它时，需要将请求路径添加到`dispath_requests`。

```
  jwt.dispatch_requests = [['POST', %r{^users/sign_in$}]]
```

#### 取消请求

您可以在`device.rb`中配置`dispatch`请求。配置时，先将请求路径添加到撤销请求中，并说明哪些请求需要取消传入JWT令牌。

```
  jwt.revocation_requests = [['DELETE', %r{^users/sign_out$}]]
```

#### Jwt payload

`user`记录还可以实现`jwt_payload`方法，这使它有机会向JWT负载添加一些内容。

```
  def jwt_payloads
    # { 'foo' => 'bar' }
  end
```

#### Jwt dispatch

在`user`记录上添加一个hook方法`on_jwt_dispatch`。它在用户调用令牌时执行，并将令牌和有效负载作为参数。这个方法也会在你调用`dispatch_requests`访问路由时被调用。

```
  def on_jwt_dispatch(token, payload)
    # do_something(token, payload)
  end
```