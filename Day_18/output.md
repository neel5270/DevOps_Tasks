Project Overview
================

 You are tasked with setting up a CI/CD pipeline for a
 microservices-based application. The application will be containerized
using Docker and orchestrated using Kubernetes. Ansible will be used
 for configuration management and deployment. The entire setup should
 be managed using Git for version control, and Jenkins will be used to
 automate the CI/CD process.

Tasks and Deliverables
======================

Task 1: Git Repository Setup
--------------------------------

Task 2: Dockerize Microservices
-----------------------------------

Task 3: Kubernetes Deployment
---------------------------------

 

**File Structure**
------------------

```
Exam 
  frontend
     Dockerfile
     front-end.yaml
     index.html
  backend
     Dockerfile
     back-end.yaml
     index.html
  testing
     Dockerfile
     testing.yaml
    index.html
```

1)  **index.html**

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Neel Patel</title>
</head>
<body>
    <h1>Neel Patel</h1>
</body>
</html>


```

2)  **front-end.yaml**

```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: front-end
spec:
  replicas: 2
  selector:
    matchLabels:
      app: front-end
  template:
    metadata:
      labels:
        app: front-end
    spec:
      containers:
      - name: front-end
        image: neelpatel5270/front-end:latest
        ports:
        - containerPort: 80

---

apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  selector:
    app: front-end  # Make sure this matches the labels in the deployment
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: ClusterIP

```

3)  **Dockerfile.html**
```
# Use an official Nginx image as a parent image
FROM nginx:alpine

# Copy the HTML file to the Nginx server directory
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80
```
**Backend**

1)  **index.html**
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Neel Patel</title>
</head>
<body>
    <h1>Neel Patel Production</h1>
</body>
</html>

```
2)  **Dockerfile**
```
# Use an official Nginx image as a parent image
FROM nginx:alpine

# Copy the HTML file to the Nginx server directory
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80
```
3)  **back-end.yaml**
```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: back-end
spec:
  replicas: 2
  selector:
    matchLabels:
      app: back-end
  template:
    metadata:
      labels:
        app: back-end
    spec:
      containers:
      - name: back-end
        image: neelpatel5270/back-end:latest
        ports:
        - containerPort: 80

---

apiVersion: v1
kind: Service
metadata:
  name: nginx-service-back
spec:
  selector:
    app: back-end
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: ClusterIP
```
**Testing**

1)  **Dockerfile**

```
# Use an official Nginx image as a parent image
FROM nginx:alpine

# Copy the HTML file to the Nginx server directory
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80

```

2)  **testing.yaml**
```yml

apiVersion: apps/v1
kind: Deployment
metadata:
  name: testing
spec:
  replicas: 2
  selector:
    matchLabels:
      app: testing
  template:
    metadata:
      labels:
        app: testing
    spec:
      containers:
      - name: testing
        image: neelpatel5270/testing:latest
        ports:
        - containerPort: 80

---

apiVersion: v1
kind: Service
metadata:
  name: nginx-service-testing
spec:
  selector:
    app: testing
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: ClusterIP
```
3)  **index.html**
```
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Neel Patel</title>
</head>
<body>
    <h1>Neel Patel Testing</h1>
</body>
</html>


```
**OUTPUT**

**frontned/index.html**

![](.//media/image1.png)

**production/index.html**

![](.//media/image2.png)

**testing/index.html**

![](.//media/image3.png)
