apiVersion: apps/v1
kind: Deployment
metadata:
  name: cetibcoauto1-deployment
  labels:
    app: tibcoceapp
spec:
  replicas: 1
  selector:
    matchLabels:
      app: cetibcoauto1
  template:
    metadata:
      labels:
        app: cetibcoauto1
    spec:
      containers:
      - name: cetibcoauto1
        image: us-central1-docker.pkg.dev/silicon-cocoa-405809/northrepo/cetibcoauto1:COMMIT_SHA
        ports:
        - containerPort: 80
---
kind: Service
apiVersion: v1
metadata:
  name: cetibcoauto1-lb-service
spec:
  type: LoadBalancer
  selector:
    app: cetibcoauto1
  ports:
  - protocol: TCP
    port: 80
    targetPort: 8083