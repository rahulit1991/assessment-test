# Guide to run assessment

## Prerequisites

Install k3d cluster with PodSecurityPolicy with following command :
- docker
- k3d cluster
- helm 

Create k3d cluster with following command

```sh
make cluster
```

## Install helm charts: ingress-nginx, Promethous

```sh
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
kubectl create ns monitoring
helm install prometheus-chart prometheus-community/prometheus -n monitoring

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install ingress-chart ingress-nginx/ingress-nginx
```

## Deploy application by running following manifest files

```sh
kubectl apply -f deployment.yaml
kubectl apply -f ingress.yaml
```    

## Check your application over browser with IP or domain

- In my case, you check application on http://api.opstudio.cloud/health and 
- check jenkins running on http://jenkins.opstudio.cloud/

## Setup Jenkins server on Kubernetes Cluster
-  Install Jenkins on kubernetes cluster using helm chart
    ```sh
    helm repo add jenkins https://charts.jenkins.io
    helm repo update
    helm install jenkins-ci jenkins/jenkins
    ```
- Create service account for jenkins with necessary permission to deploy application
- Configure github credentials in Jenkins
- Configure Dockerhub credentials in Jenkins
- Write Jenkinsfile for whole CI/CD and upload it github repo
