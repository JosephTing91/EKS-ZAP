# EKS-ZAP
eks zap CICD pipeline

#code to launch cluster

export PATH=$PATH:/usr/local/bin

   eksctl create cluster --name dev-cluster\
   --region us-east-1 \
   --node-type t2.medium \
   --nodes-min 1 \
   --version 1.24
 
   eksctl delete cluster --name dev-cluster  \
   --region us-east-1





#set up prometheus metrics collection...

#first associate IAM OIDC provider with cluster

eksctl utils associate-iam-oidc-provider --region=us-east-1 --cluster=dev-cluster --approve

eksctl create iamserviceaccount \
 --name cwagent-prometheus \
--namespace amazon-cloudwatch \
 --cluster dev-cluster \
 --region us-east-1 \
--attach-policy-arn arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy \
--approve \
--override-existing-serviceaccounts



kubectl delete deployment cwagent-prometheus -n amazon-cloudwatch

kubectl create namespace amazon-cloudwatch

kubectl apply -f prometheus-eks.yaml

curl https://raw.githubusercontent.com/aws-samples/amazon-cloudwatch-container-insights/latest/k8s-deployment-manifest-templates/deployment-mode/service/cwagent-prometheus/prometheus-k8s.yaml | 
sed "s/{{cluster_name}}/dev-cluster/;s/{{region_name}}/us-east-1/" | 
kubectl apply -f -


kubectl get pod -l "app=cwagent-prometheus" -n amazon-cloudwatch








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
    



    #Sonar Server instructions

    create project in sonarqube.
    -use token and create token key... 
input the values generated from sonarqube into the pipeline to run the job 

craete webhook