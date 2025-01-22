# dev-platform-mongodb

Use `skaffold dev` to deploy mongodb

This prints:

```
No tags generated
Starting deploy...
Helm release mongodb not installed. Installing...
Pulled: registry-1.docker.io/bitnamicharts/mongodb:16.4.2
Digest: sha256:68106e1085d5824931edc88bdea99655d19578887f4e7a91c2173e8ba319b697
NAME: mongodb
LAST DEPLOYED: Wed Jan 22 11:59:37 2025
NAMESPACE: mongodb
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
CHART NAME: mongodb
CHART VERSION: 16.4.2
APP VERSION: 8.0.4

Did you know there are enterprise versions of the Bitnami catalog? For enhanced secure software supply chain features, unlimited pulls from Docker, LTS support, or application customization, see Bitnami Premium or Tanzu Application Catalog. See https://www.arrow.com/globalecs/na/vendors/bitnami for more information.

** Please be patient while the chart is being deployed **

MongoDB&reg; can be accessed on the following DNS name(s) and ports from within your cluster:

    mongodb.mongodb.svc.cluster.local

To get the root password run:

    export MONGODB_ROOT_PASSWORD=$(kubectl get secret --namespace mongodb mongodb -o jsonpath="{.data.mongodb-root-password}" | base64 -d)

To connect to your database, create a MongoDB&reg; client container:

    kubectl run --namespace mongodb mongodb-client --rm --tty -i --restart='Never' --env="MONGODB_ROOT_PASSWORD=$MONGODB_ROOT_PASSWORD" --image docker.io/bitnami/mongodb:8.0.4-debian-12-r2 --command -- bash

Then, run the following command:
    mongosh admin --host "mongodb" --authenticationDatabase admin -u $MONGODB_ROOT_USER -p $MONGODB_ROOT_PASSWORD

To connect to your database from outside the cluster execute the following commands:

    kubectl port-forward --namespace mongodb svc/mongodb 27017:27017 &
    mongosh --host 127.0.0.1 --authenticationDatabase admin -p $MONGODB_ROOT_PASSWORD

WARNING: There are "resources" sections in the chart not set. Using "resourcesPreset" is not recommended for production. For production installations, please set the following values according to your workload needs:
  - arbiter.resources
  - resources
+info https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
Waiting for deployments to stabilize...
 - mongodb:deployment/mongodb is ready.
Deployments stabilized in 1.065 second
Starting post-deploy hooks...
Below the secret data for mongodb
mongodb-root-password: ******
Completed post-deploy hooks
Port forwarding service/mongodb in namespace mongodb, remote port 27017 -> http://127.0.0.1:27017
No artifacts found to watch
Press Ctrl+C to exit
Watching for changes...
```

## Client - Compass

Install compass: https://www.mongodb.com/try/download/compass

* Create a connection leaving the default connection string `mongodb://root:U4GtueGK1J@localhost:27017/`
* In the **Advanced Connection Options**, **Authentication** tab, set the **Authentication Method** to **Username/Password**
* Use the user `root` and the password printed by `skaffold dev` in the line starting with `mongodb-root-password`