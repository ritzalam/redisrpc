hoek = require 'hoek'
request = require 'request'
sha1 = require 'js-sha1'

urlEncode = (value) ->
  encodeURIComponent(value).replace(/%20/g, '+').replace(/[!'()]/g, escape).replace(/\*/g, "%2A") 

sortKeys = (params) ->
  keys = [];
  for own propName of params
    keys.push(propName)

  keys.sort()

buildBaseString = (params) ->
  keysSorted = sortKeys params
  baseString = ""
  for key in keysSorted
    propVal = params[key]
    baseString += urlEncode(key) + "=" + urlEncode(propVal) + "&"

#    console.log(propName + "=" + query[propName])
    
  console.log("baseString=[" + baseString.slice(0, -1) + "]")
  
  baseString.slice(0, -1)

calculateChecksum = (api, baseString, sharedSecret) ->
  qStr = api + baseString + sharedSecret
  console.log("[" + qStr + "]")
  sha1(qStr)


exports.buildBaseString = buildBaseString
exports.calculateChecksum = calculateChecksum


