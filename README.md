# BIG DATA ON K8S 
## gerador de senhas
```bash
python3 -c 'import secrets; print(secrets.token_hex(16))'
```
# Poś formatação
## Configurações essenciais dos nodes
```bash
sudo nano /etc/systemd/logind.conf
```
```
HandleLidSwitch=ignore
HandleLidSwitchExternalPower=ignore
HandleLidSwitchDocked=ignore
```
```bash
sudo systemctl restart systemd-logind.service

sudo nano /etc/default/grub
```
>> GRUB_CMDLINE_LINUX="consoleblank=300"
```bash
sudo update-grub
sudo apt install network-manager
nmtui
sudo apt install cockpit
cockpit port:9090
```

```sh
# connect into k8s cluster
kubectx microk8s

# create namespaces
k create namespace orchestrator
k create namespace database
k create namespace ingestion
k create namespace processing
k create namespace datastore
k create namespace deepstorage
k create namespace tracing
k create namespace logging
k create namespace monitoring
k create namespace viz
k create namespace cicd
k create namespace app
k create namespace cost
k create namespace misc
k create namespace dataops
k create namespace gateway

# add & update helm list repos
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update

# install crd's [custom resources]
# argo-cd
# https://artifacthub.io/packages/helm/argo/argo-cd
# https://github.com/argoproj/argo-helm
helm install argocd argo/argo-cd --namespace cicd --version 5.8.5

# install argo-cd [gitops]
# create a load balancer
k patch svc argocd-server -n cicd -p '{"spec": {"type": "LoadBalancer"}}'

# retrieve load balancer ip
# load balancer = 192.168.0.200
kubens cicd
ARGOCD_LB=$(kubectl get services -l app.kubernetes.io/name=argocd-server,app.kubernetes.io/instance=argocd -o jsonpath="{.items[0].status.loadBalancer.ingress[0].ip}")

# get password to log into argocd portal
# argocd login 192.168.0.200 --username admin --password oSpeCNSXFv-lr9Sr --insecure
k get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d | xargs -t -I {} argocd login $ARGOCD_LB --username admin --password {} --insecure

# register cluster
CLUSTER="microk8s"
argocd cluster add $CLUSTER --in-cluster

# add repo into argo-cd repositories
# via http
REPOSITORY="https://bitbucket.org/owshq/trn-mst-bg-k8s.git"
argocd repo add $REPOSITORY --username luanmoreno --password azTgTxX9AbZpr2nxspKQ --port-forward
# via ssh
argocd repo add git@github.com:GersonRS/big-data-on-k8s.git --ssh-private-key-path ~/.ssh/id_ed25519 --insecure-skip-server-verification
```

```sh
# helm
helm repo add strimzi https://strimzi.io/charts/
helm repo add spark-operator https://googlecloudplatform.github.io/spark-on-k8s-operator
helm repo add apache-airflow https://airflow.apache.org/
helm repo update

# monitoring
k apply -f repository/app-manifests/monitoring/kube-prometheus-stack-crds.yaml
k apply -f repository/app-manifests/monitoring/kube-prometheus-stack.yaml

# config maps
k apply -f repository/yamls/ingestion/metrics/kafka-metrics-config.yaml
k apply -f repository/yamls/ingestion/metrics/zookeeper-metrics-config.yaml
k apply -f repository/yamls/ingestion/metrics/connect-metrics-config.yaml
k apply -f repository/yamls/ingestion/metrics/cruise-control-metrics-config.yaml

# ingestion
k apply -f repository/app-manifests/ingestion/strimzi-kafka-operator.yaml
k apply -f repository/app-manifests/ingestion/kafka-broker.yaml
k apply -f repository/app-manifests/ingestion/kafka-broker-ephemeral.yaml
k apply -f repository/app-manifests/ingestion/schema-registry.yaml
k apply -f repository/app-manifests/ingestion/cruise-control.yaml
k apply -f repository/app-manifests/ingestion/kafka-connect.yaml
k apply -f repository/app-manifests/ingestion/kafka-connectors.yaml


# databases
k apply -f repository/app-manifests/database/mssql.yaml
k apply -f repository/app-manifests/database/mysql.yaml
k apply -f repository/app-manifests/database/postgres.yaml
k apply -f repository/app-manifests/database/mongodb.yaml
k apply -f repository/app-manifests/database/yugabytedb.yaml

# deep storage
k apply -f repository/app-manifests/deepstorage/minio-operator.yaml

# datastore
k apply -f repository/app-manifests/datastore/pinot.yaml

# processing
k apply -f repository/app-manifests/processing/spark.yaml
k apply -f repository/app-manifests/processing/ksqldb.yaml
k apply -f repository/app-manifests/processing/trino.yaml

# orchestrator
k apply -f repository/app-manifests/orchestrator/airflow.yaml

# data ops
k apply -f repository/app-manifests/lenses/lenses.yaml

# logging
k apply -f repository/app-manifests/logging/elasticsearch.yaml
k apply -f repository/app-manifests/logging/filebeat.yaml
k apply -f repository/app-manifests/logging/kibana.yaml

# cost
k apply -f repository/app-manifests/cost/kubecost.yaml

# load balancer
k apply -f repository/app-manifests/misc/load-balancers-svc.yaml

# deployed apps
k get applications -n cicd

# housekeeping
helm delete argocd -n cicd
helm delete kafka -n ingestion
helm delete spark -n processing
```

microk8s disable mayastor --remove-storage

<!-- REPOSITORY="https://github.com/GersonRS/big-data-on-k8s.git"
argocd repo add $REPOSITORY --username GersonRS --password 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 --port-forward -->

<!-- kubectl create secret generic airflow-ssh-secret --from-file=gitSshKey=$HOME/.ssh/id_ed25519 -->

<!-- sudo snap run --shell microk8s -c '$SNAP_COMMON/addons/core/addons/mayastor/pools.py add --node pc0 --size 50GB' -->
<!-- sudo snap run --shell microk8s -c '$SNAP_COMMON/addons/core/addons/mayastor/pools.py remove microk8s-pc1-pool --force --purge' -->