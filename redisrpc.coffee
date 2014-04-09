redis = require 'redis'
crypto = require 'crypto'

TIMEOUT = 5000; #time to wait for response in ms

pubClient = redis.createClient()
subClient = redis.createClient()

requests = {}; #hash to store request in wait for response

exports.sendMessage = (content, callback) ->
  #generate a unique correlation id for this call
  correlationId = crypto.randomBytes(16).toString('hex');
  
  #create a timeout for what should happen if we don't get a response
  tId = setTimeout( (corr_id) ->
    #if this ever gets called we didn't get a response in a 
    #timely fashion
    callback("timeout " + corr_id, "foo");
    #delete the entry from hash
    delete requests[corr_id];
  , TIMEOUT, correlationId);

  #create a request entry to store in a hash
  entry = {
    callback:callback,
    timeout: tId #the id for the timeout so we can clear it
  };
  
  #put the entry in the hash so we can match the response later
  requests[correlationId] = entry;
  console.log("Publishing #{correlationId}")
  pubClient.publish("echo", correlationId)

subClient.on("subscribe", (channel, count) ->
  console.log("Subscribed to #{channel}")
)

subClient.on("message", (channel, message) ->
  console.log("Received message on [channel] = #{channel} [message] = #{message}")

  correlationId = message

  #retreive the request entry
  entry = requests[correlationId];
  #make sure we don't timeout by clearing it
  clearTimeout(entry.timeout);
  #delete the entry from hash
  delete requests[correlationId];
  #callback, no err
  entry.callback(null, message);
)

console.log("RPC: Subscribing message on channel [responseChannel]")
subClient.subscribe("responseChannel")
