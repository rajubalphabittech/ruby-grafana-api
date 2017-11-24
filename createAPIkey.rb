#!/usr/bin/env ruby

$LOAD_PATH.unshift('./lib')

require 'net/http'
require 'json'
# require "openssl" 
require 'myMethods'

# Variables
home = Dir.pwd
outFile = home+'/json/robot-key.json'
url = 'http://localhost:3000/api/auth/keys'
json ='{
  "name": "robot",
  "role": "Admin"
}'

uri = URI.parse(url)
req = Net::HTTP::Post.new(uri)
req.basic_auth 'admin', 'admin'
req['Content-Type'] = 'application/json'
req.body = json

res = Net::HTTP.start(
  uri.host,
  uri.port,
  #:use_ssl => uri.scheme == 'https',
  #:verify_mode => OpenSSL::SSL::VERIFY_NONE
) { |http| http.request(req) }

#p res.body
#p res.code
res = JSON.parse(res.body)
human = JSON.pretty_generate(res)

# JSON to File
File.write(outFile, human)
