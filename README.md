## Grafana API with Ruby

Grafana API Reference:

http://docs.grafana.org/http_api/dashboard/

## Prerequisites

- Grafana instance running on: http://localhost:3000
- Prometheus instance running on: http://localhost:9090

For my example I use Prometheus with Blackbox Exporter:

https://github.com/prometheus/blackbox_exporter

Prometheus Targets Endpoints are in the json/targets.json file

## How It Works

I think names are self explanatory

To quickly provide everything:

- createAPIkey.rb
- createDashboard.rb
- importPanelElements.rb

You should see something like this:

![Alt text](./http-monitor-dash.png?raw=true "Provisioned Dashboard")


If you need to add a new service to the dashboard:

- updateDashboard.rb www.mysite.com

If need to get *dashboard* or *datasource*:

- readDashboard.rb
- readDatasource.rb
