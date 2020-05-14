# Config

To configure access:

```
export KUBECONFIG=~/repos/test-k8s-cluster-linode/testcluster-kubeconfig.yaml
```

Persistent: https://kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/#set-the-kubeconfig-environment-variable

# Deploy

```
kubectl apply -f kubernetes/deployment-phx-chat-alpine.yaml --record && kubectl rollout status deployment phx-chat && kubectl get pods
```

# History

```
kubectl rollout history deployment phx-chat
```

# Rollback

```
kubectl rollout undo deployment phx-chat && kubectl rollout status deployment phx-cha && kubectl get pods
```


## Configuration

```
kubectl config get-contexts
```
