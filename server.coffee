#super simple redis server example
redis = require 'redis'

client = redis.createClient()
subClient = redis.createClient()
 
client.on("message", (channel, message) ->
  console.log("Received [channel] = #{channel} [message] = #{message}")
  
  handleMessage(JSON.parse(message))
)

handleMessage = (message) ->
  if message.header.name?
    switch  message.header.name
      when 'authenticateMessage'
        handleAuthenticateMessage message

handleAuthenticateMessage = (message) ->
  console.log("Handling [authenticateMessage]")
  header = {name: 'authenticateReplyMessage', correlationId: message.header.correlationId}
  user = {name: 'Juan Tamad', userId: "juanId"}
  payload = {token: message.payload.authToken, data: user}
  response = {header: header, payload: payload}
  console.log("Sending [channel] = responseChannel [message] = #{JSON.stringify(response)}")
  subClient.publish("responseChannel", JSON.stringify(response))

client.subscribe("bigbluebuttonAppChannel");