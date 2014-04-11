#super simple redis server example
redis = require 'redis'

client = redis.createClient()
subClient = redis.createClient()
 
client.on("message", (channel, message) ->
  console.log("Received [channel] = #{channel} [message] = #{message}")
  console.log("Echoing [channel] = responseChannel [message] = #{message}")
  subClient.publish("responseChannel", message)
)
  
client.subscribe("bigbluebuttonAppChannel");