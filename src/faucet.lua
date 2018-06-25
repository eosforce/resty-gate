local limit_req = require "resty.limit.req"

local lim, err = limit_req.new("faucet_limit_req_store", 200, 100)
if not lim then
  ngx.log(ngx.ERR, "failed to instantiate a resty.limit.req object: ", err)
  return ngx.exit(500)
end

local key = ngx.var.binary_remote_addr
local delay, err = lim:incoming(key, true)
if not delay then
  if err == "rejected" then
    return ngx.exit(503)
  end
  ngx.log(ngx.ERR, "failed to limit req: ", err)
  return ngx.exit(500)
end

if delay >= 0.001 then
  local excess = err
  ngx.sleep(delay)
end

return ngx.exec("@nodeos_faucet")