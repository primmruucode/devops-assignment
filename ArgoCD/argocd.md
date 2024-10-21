6. Use ArgoCD to deploy this application. To follow GitOps practices, we prefer to have an ArgoCD application defined declaratively in a YAML file if possible.

**Expected output:** Yaml files and instruction how to deploy the application or command line

**Explanation**

ArgoCD can be installed using either Helm or a pre-generated install.yaml file. For simplicity I use the install.yaml for this purpose

To install ArgoCD for this assessment I have created a pipeline that will apply the install manifest.

As you can see I use a image hosted on Google Container Registry rather than an its official for reducing latency 

this is actually a good practices for every image using bu GKE

The application and repository are defined declaratively in this repo located in the ArgoCD/resource folder

For Kustomize applications there are settings can be configured within the Application resource to further customize the deployment.

to deploy this application you simply use one of my pipeline/workflow docker-build which can change the image of the deployment 

and the argo will do the rest

