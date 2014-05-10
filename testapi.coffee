hoek = require 'hoek'
request = require 'request'
sha1 = require 'js-sha1'
parser = require 'xml2json'

bbbapi = require './lib/bbbapi'

bbbServer = "http://192.168.153.146/bigbluebutton/api/"
sharedSecret = "856a5d0d0bb3fe37b1e2e6ba3f4d8287"

cs = "ff206f1975c6ad70459434834b3fa6bcabe0397c"

str = "name=Demo+Meeting&meetingID=Demo+Meeting&voiceBridge=70827&attendeePW=ap&moderatorPW=mp&record=false"

message = "Hola mundo!"



console.log(sha1("create" + str + sharedSecret))

console.log(cs)


createParams = {}
createParams.attendeePW = "ap"
createParams.moderatorPW = "mp"
createParams.record = false
createParams.voiceBridge = 70827
createParams.name = "Demo Meeting"
createParams.meetingID = "Demo Meeting"

joinParams = {}
joinParams.password = "mp"
joinParams.fullName = "Richard"
joinParams.meetingID = "Demo Meeting"
joinParams.redirect = false

serverAndSecret = {server: bbbServer, secret: sharedSecret}

bbbapi.create(createParams, serverAndSecret, {}, (error, response, body) ->
#   console.log(response)
   console.log(parser.toJson(body, {}))
   bbbapi.join(joinParams, serverAndSecret, {}, (error, response, body) ->
#     console.log(response)
     console.log(parser.toJson(body, {}))
   )
  )

