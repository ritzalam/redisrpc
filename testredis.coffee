redis = require "redis"
rpc = require './redisrpc'
  
rpc.sendMessage("echo", (err, response) ->
  console.log("Callback #{response}")
  rpc.sendMessage("echo", (err, response) ->
    console.log("Callback #{response}")
  )
)
