#### **Project Overview**

Participants are required to deploy a simple static web application on a
Kubernetes cluster using Minikube, set up advanced ingress networking
with URL rewriting and sticky sessions, and configure horizontal pod
autoscaling to manage traffic efficiently. The project will be divided
into stages, with each stage focusing on specific aspects of Kubernetes
ingress, URL rewriting, sticky sessions, and autoscaling.

#### **Requirements and Deliverables**

### **Stage 1: Setting Up the Kubernetes Cluster and Static Web App**

1.  **Set Up Minikube:**

    -   ![](.//media/image1.png)

2.  **Deploy Static Web App:**

    ![](.//media/image2.png)

3.  **Kubernetes Deployment:**

    -   Write a Kubernetes deployment manifest to deploy the static web application.

    -   Write a Kubernetes service manifest to expose the static web application within the cluster.

    -   Apply the deployment and service manifests to the Kubernetes cluster.

        ![](.//media/image3.png)

### **Stage 2: Configuring Ingress Networking**

4.  **Install and Configure Ingress Controller:**



5.  **Create Ingress Resource:**


> ![](.//media/image4.png)

![](.//media/image5.png)


![](.//media/image6.png)

### **Stage 3: Implementing Horizontal Pod Autoscaling**

6.  **Configure Horizontal Pod Autoscaler:**

    -   ![](.//media/image7.png)

7.  **Stress Testing:**

    -   Perform stress testing to simulate traffic and validate the HPA configuration.

    -   Monitor the scaling behavior and ensure the application scales
    up and down based on the load.

> ![](.//media/image8.png)

![](.//media/image9.png)

> ![](.//media/image10.png)

### 

![](.//media/image11.png)

### **Stage 4: Final Validation and Cleanup**

8.  **Final Validation:**

9.  **Cleanup:**

**Deliverables:**

-   Final validation report documenting the testing process and results

-   Cleanup commands/scripts

![](.//media/image12.png)