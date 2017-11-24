#!/usr/bin/env ruby

$LOAD_PATH.unshift('./lib')

require 'net/http'
require 'json'
require 'myMethods'

# Variables
home = Dir.pwd
keyFile = home+'/json/robot-key.json'
serviceFile = home+'/json/service.json'
#service = res['dashboard']['rows'].first['panels'].last
url = 'http://localhost:3000/api/dashboards/db/http-monitoring'
targetFile = home+'/json/targets.json'

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

elements = Array.new
elements = MyMethods.JsonToHash(targetFile)['targets']

elements.each { |x|
  # Configure new element to panel
  newExpr = 'probe_duration_seconds{instance="'+x+'"}'
  newTitle = x+' - Monitoring (ms)'
  lastId += 1

  data = MyMethods.JsonToHash(serviceFile)
  data['targets'].first['expr'] = newExpr
  data['title'] = newTitle
  data['id'] = lastId

  # Add new element to panel
  res['dashboard']['rows'].first['panels'].push(data)
}

robot = JSON.generate(res)

# POST New Dashboard
url = 'http://localhost:3000/api/dashboards/db'
p MyMethods.http(url, 'POST', robot, apiKey['key'])
