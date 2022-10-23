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
GRUB_CMDLINE_LINUX="consoleblank=300"
```
sudo update-grub

sudo dpkg-reconfigure console-setup

sudo apt install wicd wicd-curses
wicd-curses

sudo apt install network-manager
sudo apt install cockpit
nmtui
```
cockpit port:9090

kubectl patch storageclass mayastor -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'

# BIG DATA ON K8S 
# big-data-on-k8s

## tenant minio:
Access Key: ZvZVosCiiL5Giti5
Secret Key: KnLStjh0WHD3TBjb


PASSWORD="cVkyRNbkuU4dXxa6"
HOSTARGO="192.168.0.200"
argocd login $HOSTARGO --username admin --password $PASSWORD --insecure

# register cluster
CLUSTER="minikube"
CLUSTER="microk8s"
argocd cluster add $CLUSTER --in-cluster
argocd repo add git@github.com:GersonRS/big-data-on-k8s.git --ssh-private-key-path ~/.ssh/id_ed25519 --insecure-skip-server-verification

<!-- REPOSITORY="https://github.com/GersonRS/big-data-on-k8s.git"
argocd repo add $REPOSITORY --username GersonRS --password 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 --port-forward -->