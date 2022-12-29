# EKS-ZAP
eks zap CICD pipeline





#code to launch cluster

export PATH=$PATH:/usr/local/bin

   eksctl create cluster --name dev-cluster  \
   --region us-east-1 \
   --node-type t2.medium \
   --nodes-min 1 \
   --version 1.24
 

#ansible playbook to install git and node exporter into the eks cluster worker nodes...




#make sure kubectl and cluster are same version...
eksctl delete cluster --name test-cluster --region us-east-1 --version=1.24

#add tag to the eks cluster... Application: webapp



#ZAP server setup
ubuntu 10.04
-sgs open ports 1-10000 to public
1-10000 open to /0::

install docker


#Prometheus integrate...

to add targets, go into the config file at 
/etc/prometheus/prometheus.yml

sudo systemctl restart prometheus.service 


edit to add the node...


global:
  scrape_interval: 15s
  external_labels:
    monitor: 'prometheus'

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']
  - job_name: 'webapp'
    ec2_sd_configs:
      - region: us-east-1        
        port: 9100
        filters:
          - name: tag:Application
            values:
              - webapp     
  - job_name: 'jenkins'
    metrics_path: /prometheus/
    ec2_sd_configs:     
      - region: us-east-1        
        port: 8080
        filters:
          - name: tag:Application
            values:
              - jenkins        
  # - job_name: 'jenkins'
  #   metrics_path: /prometheus/
  #   static_configs:
  #   - targets: ['172.31.86.134:8080'] # should replace with the jenkins IP
    