# EKS-ZAP
eks zap CICD pipeline







#code to launch cluster

   eksctl create cluster --name dev-cluster  \
   --region us-east-1 \
   --node-type t2.medium \
   --nodes-min 1 \
   --version 1.24
 

#make sure kubectl and cluster are same version...
eksctl delete cluster --name test-cluster --region us-east-1 --version=1.24