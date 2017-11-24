#!/usr/bin/env ruby

$LOAD_PATH.unshift('./lib')

require 'net/http'
require 'json'
require 'myMethods'

# Variables
home = Dir.pwd
keyFile = home+'/json/robot-key.json'
inFile = home+'/json/http-monitoring.json'
url = 'http://localhost:3000/api/dashboards/db'

# Get APIKey
apiKey = MyMethods.JsonToHash(keyFile)

data = MyMethods.JsonToHash(inFile)
json = JSON.generate(data)
res = MyMethods.http(url, 'POST', json, apiKey['key'])

puts human = JSON.pretty_generate(res)
