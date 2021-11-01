#!/bin/bash
#install node exporter in fedora distribution

#create user node exporter
sudo useradd --no-create-home node_exporter

#download file nodexporter and untar
cd /tmp
wget https://github.com/prometheus/node_exporter/releases/download/v1.0.1/node_exporter-1.0.1.linux-amd64.tar.gz
tar xzf node_exporter-1.0.1.linux-amd64.tar.gz
sudo cp node_exporter-1.0.1.linux-amd64/node_exporter /usr/local/bin/node_exporter
rm -rf node_exporter-1.0.1.linux-amd64.tar.gz node_exporter-1.0.1.linux-amd64


#create file systemd if it doesn't exist
FILE_SYSTEMD=/etc/systemd/system/node-exporter.service

if [ -f ${FILE_SYSTEMD} ]
then 
   echo "This file already exist $FILE_SYSTEMD" 
else 

cat <<EOF > /etc/systemd/system/node-exporter.service
[Unit]
Description=Prometheus Node Exporter Service
After=network.target
[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter
[Install]
WantedBy=multi-user.target
EOF

#start services
sudo systemctl daemon-reload
sudo systemctl enable node-exporter
sudo systemctl start node-exporter

fi

