#!/bin/bash
set -eu

wget https://github.com/prometheus/node_exporter/releases/download/v1.9.0/node_exporter-v1.9.0.linux-amd64.tar.gz
tar xvfz node_exporter-*.*-amd64.tar.gz
cd node_exporter-*.*-amd64

sudo cp node_exporter /usr/bin

cat  <<EOF | sudo tee -a /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
After=network.target
 
[Service]
Type=simple
ExecStart=/usr/bin/node_exporter
 
[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl start node_exporter
sudo systemctl enable node_exporter
