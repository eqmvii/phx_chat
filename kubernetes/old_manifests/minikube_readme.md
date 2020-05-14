# Mostly minikube notes:

# Dash

minikube dashboard

# Setting minikube to hit local containers

This allows images to be built within kubernetes vm and used locally rather than pulled from an external repository:

```
minikube start

eval $(minikube docker-env)

docker build -t secret/local_prod_phx_chat:1 -f secret/LocalProdDockerfile .
```

using docker image ls from within the terminal will show images that are local

Then ensure the following field is set in your kubernetes yamls:

`imagePullPolicy: IfNotPresent`

Ex:

```
apiVersion: v1
kind: Pod
metadata:
  name: phx-chat-webapp
  labels:
    app: phx-chat-webapp
spec:
  containers:
    - image: secret/local_prod_phx_chat:1
      name: phx-chat-webapp
      imagePullPolicy: IfNotPresent
      ports:
        - containerPort: 4000
```

## Create the pod and connect:


```
kubectl create -f kubernetes/local-phx-chat-prod-pod.yaml
kubectl port-forward phx-chat-webapp 8008:4000
```

(only 8008 is configred in the phoenix endpoint so exposing elsewhere will cause issues)

# Create a Service / LB for the web app

```
kubectl create -f kubernetes/service-phx-chat.yaml
```

# Create/apply a deployment

```
kubectl apply -f kubernetes/deployment-phx-chat-v1.yaml --record
kubectl rollout status deployment phx-chat-webapp

minikube service list

minikube service phx-chat-lb
```

# Issue is that Plug.SSL is redirecting based on the route:

03:36:25.034 [info] Plug.SSL is redirecting GET / to https://eqmvii-phx-chat.herokuapp.com with status 301

hackily fixed by reworking configurations in prod.exs

# Rollbacks

```
kubectl rollout history deployment phx-chat-webapp
kubectl rollout undo deployment phx-chat-webapp

```
