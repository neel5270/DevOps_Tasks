#### **Project details are available from page 13**

#### 

**Project 01**

In this project, you will develop a simple Node.js application, deploy
it on a local Kubernetes cluster using Minikube, and configure various
Kubernetes features. The project includes Git version control practices,
creating and managing branches, and performing rebases. Additionally,
you will work with ConfigMaps, Secrets, environment variables, and set
up vertical and horizontal pod autoscaling.

**Project 01**
--------------

**Project Steps**
-----------------

### **1. Setup Minikube and Git Repository**

#### **Set Up Git Repository**

 **Create a new directory for your project**:\
 **Initialize Git repository**:\
 **Create a .gitignore file**:

 **Add and commit initial changes**:

### **2 Develop a Node.js Application**

#### **Create the Node.js App**

 **Initialize the Node.js project**:

 **Install necessary packages**:

 **Create app.js**:

 **Update package.json** to include a start script:

 **Commit the Node.js Application**

**Add and commit changes**:

### **3. Create Dockerfile and Docker Compose**

#### **Create a Dockerfile**

 **Add Dockerfile**:

 **Create a .dockerignore file**:

**Create docker-compose.yml (optional for local testing)**

 **Add docker-compose.yml**:

 **Add and commit changes**:

![](.//media/image1.png)

### **4. Build and Push Docker Image**

#### **Build Docker Image**

 **Build the Docker image**:\
 \
 docker build -t nodejs-app:latest .

![](.//media/image2.png)

####  **Push Docker Image to Docker Hub**

**Tag and push the image**:\
\
docker tag nodejs-app:latest your-dockerhub-username/nodejs-app:latest

docker push your-dockerhub-username/nodejs-app:latest

![](.//media/image3.png)

 **Add and commit changes**:\
 \
 git add .

 git commit -m \"Build and push Docker image\"

![](.//media/image4.png)
### **5. Create Kubernetes Configurations**

####  **Create Kubernetes Deployment**

####  **Create ConfigMap and Secret**

**Create kubernetes/secret.yaml**:

![](.//media/image5.png)

**Add and commit Kubernetes configurations**:\
\
git add kubernetes/

git commit -m \"Add Kubernetes deployment, configmap, and secret\"

![](.//media/image6.png)

#### **5.3 Apply Kubernetes Configurations**

**Apply the ConfigMap and Secret**:\
\
kubectl apply -f kubernetes/configmap.yaml

kubectl apply -f kubernetes/secret.yaml

![](.//media/image7.png)

**Apply the Deployment**:\
\
kubectl apply -f kubernetes/deployment.yaml

![](.//media/image8.png)
### 
