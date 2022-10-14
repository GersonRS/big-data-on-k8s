# BIG DATA ON K8S 
# big-data-on-k8s

secret longhorn = 6Sja9NhKSAbXKZ0R
secret argocd microk8s = pXkyT7YN2A5ifCHu
secret argocd minikube = Sw2yf3RC5xaUSCZ3
PASSWORD="pXkyT7YN2A5ifCHu"
HOSTARGO="192.168.0.200"
argocd login $HOSTARGO --username admin --password $PASSWORD --insecure

# register cluster
CLUSTER="minikube"
CLUSTER="microk8s"
argocd cluster add $CLUSTER --in-cluster

REPOSITORY="https://github.com/GersonRS/big-data-on-k8s.git"
argocd repo add $REPOSITORY --username GersonRS --password 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 --port-forward

argocd repo add git@github.com:GersonRS/big-data-on-k8s.git --ssh-private-key-path ~/.ssh/id_ed25519
argocd repo add git@github.com:GersonRS/big-data-on-k8s.git --ssh-private-key-path ~/.ssh/id_ed25519 --insecure-skip-server-verification