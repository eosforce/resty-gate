# resty-gate

An API Gateway based on OpenResty.

## Features

- [x] HTTPS 到 HTTP 代理, 使用 let's encrypt 证书.
- [x] 每秒请求数限制.
- [x] JWT 鉴权.
- [x] upstream 负载均衡.

## Install Deps

* `opm --cwd get openresty/lua-resty-limit-traffic`
* `opm --cwd get SkyLothar/lua-resty-jwt`

## Run

* `openresty -p . -c conf/nginx.conf`

## Let's Enctrypt 生成证书

* 可以参考 <https://gist.github.com/chuyik/d4f5903bf18a45b2cff27666ac3ac243> 这个文章进行操作.

## TEST

### JWT Test

```bash
# apt-get install httpie || brew install httpie
$ http --print HBhb localhost/verify/ "Authorization:Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmb28iOiJiYXIifQ.dtxWM6MIcgoeMgH87tGvsNDY6cHWL6MGW4LeYvnm1JA"
# token as url argument
$ http --print HBhb localhost/verify/?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmb28iOiJiYXIifQ.dtxWM6MIcgoeMgH87tGvsNDY6cHWL6MGW4LeYvnm1JA
# token as cookie
$ http --print HBhb localhost/verify/ "Cookie:token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmb28iOiJiYXIifQ.dtxWM6MIcgoeMgH87tGvsNDY6cHWL6MGW4LeYvnm1JA"
```
