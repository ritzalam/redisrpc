redis = require "redis"
  
subClient = redis.createClient()


subClient.on("subscribe", (channel, count) ->
  console.log("Subscribed to #{channel}")
)

subClient.on("message", (channel, message) ->
  console.log("[channel] = #{channel} [message] = #{message}")
)

subClient.subscribe("responseChannel")


client = redis.createClient()

client.on("error", (err) -> 
  console.log("Error " + err)
);

client.set("string key", "string val", redis.print)
client.hset("hash key", "hashtest 1", "some value", redis.print)
client.hset(["hash key", "hashtest 2", "some other value"], redis.print)
client.hkeys("hash key", (err, replies) ->
  console.log(replies.length + " replies:")
  replies.forEach( (reply, i) ->
    console.log("    " + i + ": " + reply)
  )
  client.quit()
)

