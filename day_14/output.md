**Project 01**

#### **Problem Statement:**

You are tasked with setting up a CI/CD pipeline using Jenkins to
streamline the deployment process of a simple Java application. The
pipeline should accomplish the following tasks:

1.  **Fetch the Dockerfile**: The pipeline should clone a GitHub
     repository containing the source code of the Java application and
    a Dockerfile.

2.  **Create a Docker Image**: The pipeline should build a Docker image
     from the fetched Dockerfile.

3.  **Push the Docker Image**: The pipeline should push the created
    Docker image to a specified DockerHub repository.

4.  **Deploy the Container**: The pipeline should deploy a container
     using the pushed Docker image.

#### **Deliverables:**

1.  **GitHub Repository**: A GitHub repository containing:

    -   The source code of a simple Java application.

![](.//media/image1.png)

-   A Dockerfile for building the Docker image.

 ![](.//media/image2.png)

2.  **Jenkins Pipeline Script**: A Jenkinsfile (pipeline script) that:

    -   Clones the GitHub repository.

    -   Builds the Docker image.

    -   Pushes the Docker image to DockerHub.

    -   Deploys a container using the pushed image.

 ![](.//media/image3.png)

3.  **DockerHub Repository**: A DockerHub repository where the Docker
     images will be stored.

![](.//media/image4.png)

4.  **Jenkins Setup**:

    -   Jenkins installed and configured on a local Ubuntu machine.

    -   Required plugins installed (e.g., Git, Docker, Pipeline).

![](.//media/image5.png)

![](.//media/image6.png)

5.  **Documentation**: Detailed documentation explaining:

    -   How to set up the local Jenkins environment.

    -   Configuration steps for the pipeline.

    -   Instructions for verifying the deployment.

![](.//media/image7.png)
