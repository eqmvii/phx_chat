# (Re) Build a Cluster

1. Spin up a new cluster on linode

2. Download cluster config, store secretly and safely. Set terminal to use that config.

```
export KUBECONFIG=~/repos/phx_chat/secret/phx-chat-kubeconfig.yaml
```

Verify the cluster is up with `kubectl get pods -A`

3. Build your services:

```
kubectl apply -f kubernetes/service-redis.yaml
kubectl apply -f kubernetes/service-phx-chat-nodeport.yaml
```

4. Create the 3 manual secrets:

secret-key-base-secret, gcloud-db-url-secret and cproxy-db-url-secret

Then the cloud proxy secret:

kubectl apply -f secret/gcp

5. Deploy!

```
kubectl apply -f kubernetes/deployment-redis-pubsub.yaml --record
kubectl apply -f kubernetes/deployment-phx-chat.yaml --record && kubectl rollout status deployment phx-chat && kubectl get pods
```

Results: 172.104.25.149:31745/chat
