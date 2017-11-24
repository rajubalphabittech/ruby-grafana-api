#!/usr/bin/env ruby

$LOAD_PATH.unshift('./lib')

require 'net/http'
require 'json'
require 'myMethods'

# Get parameters
arg1 = ARGV.shift
raise "I need service URL - e.g. #{$0} www.youtube.com" unless arg1
raise "Too many arguments" unless ARGV.empty?

# Variables
home = Dir.pwd
keyFile = home+'/json/robot-key.json'
newService = arg1
serviceFile = home+'/json/service.json'
#service = res['dashboard']['rows'].first['panels'].last
url = 'http://localhost:3000/api/dashboards/db/http-monitoring'

# Get APIKey
apiKey = MyMethods.JsonToHash(keyFile)

# Get actual dashboard
res = MyMethods.http(url, 'GET', nil, apiKey['key'])

# Get last panel element ID
panels = res['dashboard']['rows'].first['panels']
if panels.empty?
  lastId = 0
else
  lastId = res['dashboard']['rows'].first['panels'].last['id']
end

# Configure new element to panel
data = MyMethods.JsonToHash(serviceFile)
newExpr = 'probe_duration_seconds{instance="'+newService+'"}'
newTitle = newService+' - Monitoring (ms)'
lastId += 1

data['targets'].first['expr'] = newExpr
data['title'] = newTitle
data['id'] = lastId

# Add new element to panel
res['dashboard']['rows'].first['panels'].push(data)

# POST New Dashboard
robot = JSON.generate(res)
url = 'http://localhost:3000/api/dashboards/db'
p MyMethods.http(url, 'POST', robot, apiKey['key'])
