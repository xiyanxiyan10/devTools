docker run -d -p 3000:3000 -e INFLUXDB_HOST=127.0.0.1  -e INFLUXDB_PORT=8086 -e INFLUXDB_NAME=quant -e INFLUXDB_USER=admin -e INFLUXDB_PASS=admin --name grafana  grafana/grafana

