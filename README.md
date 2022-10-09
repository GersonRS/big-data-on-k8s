# BIG DATA ON K8S 
# big-data-on-k8s

secret argocd = 6Sja9NhKS-bXKZ0R
minikube argocd = LP8bp9qgme9URyR5

argocd cluster add minikube --in-cluster

REPOSITORY="https://github.com/GersonRS/big-data-on-k8s.git"
argocd repo add $REPOSITORY --username GersonRS --password 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 --port-forward

argocd repo add git@github.com:GersonRS/big-data-on-k8s.git --ssh-private-key-path ~/.ssh/id_ed25519 --insecure-skip-server-verification