# BIG DATA ON K8S 
# big-data-on-k8s

secret argocd = 6Sja9NhKS-bXKZ0R
ARGOMINIKUBE="Sw2yf3RC5xaUSCZ3"
HOSTARGO="localhost:34367"
argocd login $HOSTARGO --username admin --password $ARGOMINIKUBE --insecure

# register cluster
CLUSTER="microk8s"
CLUSTER="minikube"
argocd cluster add $CLUSTER --in-cluster

REPOSITORY="https://github.com/GersonRS/big-data-on-k8s.git"
argocd repo add $REPOSITORY --username GersonRS --password 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 --port-forward

argocd repo add git@github.com:GersonRS/big-data-on-k8s.git --ssh-private-key-path ~/.ssh/id_ed25519
argocd repo add git@github.com:GersonRS/big-data-on-k8s.git --ssh-private-key-path ~/.ssh/id_ed25519 --insecure-skip-server-verification