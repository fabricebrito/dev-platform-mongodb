# dev-platform-mongodb

Use `skaffold dev` to deploy mongodb.

This deploys mongodb from oci://registry-1.docker.io/bitnamicharts/mongodb and exposes with a port-forward the mongodb on `mongodb://root:U4GtueGK1J@localhost:27017/`

For coding experiments, access the code server pod on 

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
* Click **connect**

## Short tutorial

### Step 1: Open a shell on MongoDB

Click **>_ Open MongoDB shell**

### Step 2: Create a Database and Collection

Use or create a new database:

```javascript
use tutorial_db
```

Create a collection (optional, as MongoDB auto-creates it on the first insert):

```javascript
db.createCollection("tutorial_collection")
```

### Step 3: Insert JSON Documents

Insert one document:

```javascript
db.tutorial_collection.insertOne({
  name: "Alice",
  age: 30,
  skills: ["Python", "MongoDB"],
  isActive: true
})
```

Insert multiple documents:

```javascript
db.tutorial_collection.insertMany([
  { name: "Bob", age: 25, skills: ["Java", "Docker"], isActive: true },
  { name: "Charlie", age: 35, skills: ["C++", "Linux"], isActive: false }
])
```

### Step 4: Query the Data

Retrieve all documents:

```javascript
db.tutorial_collection.find()
```

Filter documents by criteria (e.g., age > 30):

```javascript
db.tutorial_collection.find({ age: { $gt: 30 } })
```

Retrieve specific fields:

```javascript
db.tutorial_collection.find({}, { name: 1, skills: 1, _id: 0 })
```

### Python

```python
from pymongo import MongoClient

# Replace the following with your MongoDB credentials and details
username = "root"
password = "***"
host = "mongodb"  # or your MongoDB server's hostname/IP
port = 27017        # default MongoDB port
database_name = "tutorial_db"

# Build the connection string
connection_string = f"mongodb://{username}:{password}@{host}:{port}"
```

```python
# Connect to MongoDB
client = MongoClient(connection_string)

# Access the database and collection
db = client[database_name]
collection = db["tutorial_collection"]

# Insert a document
collection.insert_one({"name": "Fabrice", "age": 30, "skills": ["Python", "MongoDB"]})

# Query documents
for doc in collection.find({"age": {"$gte": 30}}):
    print(doc)

# Close the connection
client.close()
```