#!/usr/bin/env ruby

$LOAD_PATH.unshift('./lib')

require 'net/http'
require 'json'
require 'myMethods'

# Variables
home = Dir.pwd
keyFile = home+'/json/robot-key.json'
outFile = home+'/json/prom-datasource.json'
#url = 'http://localhost:3000/api/datasources' # array with all datasources
url = 'http://localhost:3000/api/datasources/1'

# Get APIKey
apiKey = MyMethods.JsonToHash(keyFile)

res = MyMethods.http(url, 'GET', nil, apiKey['key'])
puts human = JSON.pretty_generate(res)

# JSON to File
#File.write(outFile, human)
