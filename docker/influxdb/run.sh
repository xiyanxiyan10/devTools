docker run -d -p 8083:8083 -p 8086:8086 -e ADMIN_USER="admin" -e INFLUXDB_INIT_PWD="admin" -e PRE_CREATE_DB="quant" --name influxdb tutum/influxdb:latest
