hoek = require 'hoek'
request = require 'request'
sha1 = require 'js-sha1'

bbbapi = require './lib/bbbapi'

bbbServer = "http://192.168.22.137/bigbluebutton/api/"
sharedSecret = "eb0a69fe5cb03ce81f81ed64b405ec2b"

cs = "ff206f1975c6ad70459434834b3fa6bcabe0397c"

str = "name=Demo+Meeting&meetingID=Demo+Meeting&voiceBridge=70827&attendeePW=ap&moderatorPW=mp&record=false"

message = "Hola mundo!"



console.log(sha1("create" + str + sharedSecret))

console.log(cs)


params = {}
params.attendeePW = "ap"
params.moderatorPW = "mp"
params.record = false
params.voiceBridge = 70827
params.name = "Demo Meeting"
params.meetingID = "Demo Meeting"

bstr = bbbapi.buildBaseString(params)

checkSum = bbbapi.calculateChecksum("create", bstr, sharedSecret)
queryStr = bstr + "&checksum=" + checkSum
console.log(queryStr)

reqStr = bbbServer + "create?" + queryStr
console.log(reqStr)

request(reqStr, (error, response, body) ->
  #if (!error and response.statusCode == 200) {
    console.log(body) 
  #}
)