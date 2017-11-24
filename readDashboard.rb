#!/usr/bin/env ruby

$LOAD_PATH.unshift('./lib')

require 'net/http'
require 'json'
require 'myMethods'

# Variables
home = Dir.pwd
keyFile = home+'/json/robot-key.json'
outFile = home+'/json/http-monitoring.json'
url = 'http://localhost:3000/api/dashboards/db/http-monitoring'

# Get APIKey
apiKey = MyMethods.JsonToHash(keyFile)

res = MyMethods.http(url, 'GET', nil, apiKey['key'])
#p res.class
#p res.first
puts human = JSON.pretty_generate(res)

# JSON to File
#File.write(outFile, human)
