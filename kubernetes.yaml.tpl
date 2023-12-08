apiVersion: apps/v1
kind: Deployment
metadata:
  name: cetibcoauto1-deployment
  labels:
    app: cetibcoauto1
spec:
  replicas: 2
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
          envFrom:
            - configMapRef:
                name: configdev
		  volumeMounts:
		    - name: secrets
			  mountPath: /mnt/secrets
			  readOnly: true
	  volumes:
	    - name: secrets
		  secret:
			secretName: "dev-secret"
			items:
			  - key: mydev.jks
				path: mydev.jks
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
    targetPort: 8585
