# Into the Gcloud

cloud console

```
gcloud sql connect phx-chat-db --user=postgres

postgres=> CREATE DATABASE phx_chat;
CREATE DATABASE
```

\l to see dbs

\c to pick one

Then whitelist my ip and connect -- that worked!

alternative, more productoin grade, would be using a cloud proxy container...

In case of emergency, whitelisting 0.0.0.0/0 would let everyone in.

Best plan is likely a sidecar proxy container in each pod: https://cloud.google.com/sql/docs/postgres/connect-kubernetes-engine

# Operation: Sidecar

https://www.magalix.com/blog/kubernetes-secrets-101

https://kubernetes.io/docs/concepts/configuration/secret/
