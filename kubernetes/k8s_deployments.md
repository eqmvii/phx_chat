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

# Scale

```
kubectl scale deployment phx-chat --replicas=1
```

# Turn Off

This is silly - better way is just deleting the deployment, `kubectl delete deployment phx-chat`
```
kubectl apply -f kubernetes/deployment-off.yaml
```

# History

```
kubectl rollout history deployment phx-chat
```

# Rollback

Note: if a deployment changes metadata but not images (like just changing the number of pods), it doesn't get a history entry
and can't be "rolled back"

```
kubectl rollout undo deployment phx-chat && kubectl rollout status deployment phx-cha && kubectl get pods
```


## Configuration

```
kubectl config get-contexts
```

# Dashboard

Install and run proxy:

```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml

kubectl proxy
```

should be here:

http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/


Troubleshooting: tried manually applying metrics goodness:

kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.3.6/components.yaml

that installed the metrics server and got me a new error message:

Error from server (ServiceUnavailable): the server is currently unable to handle the request (get nodes.metrics.k8s.io)

logs from the metrics server:

```
$ kubectl logs metrics-server-58c885686f-zf7jb -n kube-system
I0516 19:52:53.301685       1 serving.go:312] Generated self-signed cert (/tmp/apiserver.crt, /tmp/apiserver.key)
I0516 19:52:54.667251       1 secure_serving.go:116] Serving securely on [::]:4443
E0516 19:53:54.694525       1 manager.go:111] unable to fully collect metrics: unable to fully scrape metrics from source kubelet_summary:[redacted]: unable to fetch metrics from Kubelet [redacted] ([redacted]): Get [redacted]/stats/summary?only_cpu_and_memory=true: dial tcp: lookup [redacted] on 10.128.0.10:53: no such host
E0516 19:54:54.737906       1 manager.go:111] unable to fully collect metrics: unable to fully scrape metrics from source kubelet_summary:[redacted]: unable to fetch metrics from Kubelet [redacted] ([redacted]): Get [redacted]/stats/summary?only_cpu_and_memory=true: dial tcp: lookup [redacted] on 10.128.0.10:53: no such host
E0516 19:55:54.703898       1 manager.go:111] unable to fully collect metrics: unable to fully scrape metrics from source kubelet_summary:[redacted]: unable to fetch metrics from Kubelet [redacted] ([redacted]): Get [redacted]/stats/summary?only_cpu_and_memory=true: dial tcp: lookup [redacted] on 10.128.0.10:53: no such host
E0516 19:56:54.664683       1 manager.go:111] unable to fully collect metrics: unable to fully scrape metrics from source kubelet_summary:[redacted]: unable to fetch metrics from Kubelet [redacted] ([redacted]): Get [redacted]/stats/summary?only_cpu_and_memory=true: dial tcp: lookup [redacted] on 10.128.0.10:53: no such host
E0516 19:57:54.668103       1 manager.go:111] unable to fully collect metrics: unable to fully scrape metrics from source kubelet_summary:[redacted]: unable to fetch metrics from Kubelet [redacted] ([redacted]): Get [redacted]/stats/summary?only_cpu_and_memory=true: dial tcp: lookup [redacted] on 10.128.0.10:53: no such host
```

## original error:

$ kubectl top node --heapster-namespace=kube-system
Error from server (NotFound): the server could not find the requested resource (get services http:heapster:)

^ the check for heapster was happening because it couldn't find the metrics server

