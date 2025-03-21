#!/bin/bash
set -eu

wget https://github.com/prometheus/prometheus/releases/download/v3.2.1/prometheus-2.26.0.linux-amd64.tar.gz
tar xvfz prometheus-*.*-amd64.tar.gz
cd prometheus-*.*-amd64

sudo cp prometheus /usr/bin

cat <<EOF | sudo tee -a /etc/systemd/system/prometheus.service
[Unit]
Description=Prometheus
After=network.target
 
[Service]
Type=simple
ExecStart=/usr/bin/prometheus --config.file=/data/data_grafana/prom_config/config.yml
 
[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl start prometheus
sudo systemctl enable prometheus
