# koko-project
A flask rest-api with a Dockerfile to create a docker image of app.
----------------------
HOW TO RUN
______________________
1. Create a working dir on your local machine or cloud server
2. Clone the repository
3. Ensure you have python or python3 installed
4. Run python app.py to run the app directly then access it from http://localhost:5000
5. Run docker build -t 'name of choice' .
6. To run the app, use 'docker run -d 'name of choice' 

CREATE INSTANCE WITH TERRAFFORM.
---------------------------------
1. Install terraform on your machine.
2. Run 'terraform init', to initialize a working directory and support for your provider
3. Run 'terraform plan', to view all resources that shall be created.
4. Run 'terraform apply', to create your resources

N/B
---------------------------------------
- An s3 backend has already been initialized for this. Create your own.
- Ensure you have configured aws-cli on your machine and authorized it.

PULL AND PUSH DOCKER IMAGE WITH ANSIBLE
________________________________________
1. Install ansible and all its dependencies.
2. Edit your hosts file for servers to be configured.
3. Ensure you have allowed ssh access on your servers.
4. Run 'ansible-playbook dockerstart.yaml'
5. This will install docker on your remote server, pull the image and run it on your server.

CI/CD WITH JENKINS
--------------------
1. Create a jenkins instance.
2. Install jenkins and access it.
3. Install docker on your jenkins instance and make sure its running.
4. On your jenkins UI install docker plugins.
5. To push the image to your preferred registry, configure credentials on the jenkins management UI.
6. Create a jenkins job and choose pipeline
7. Use poll scm, and provide relevant details in case a change is done for CI
8. Alternatively a webhook for when a push is done can be used for CI 
7. Provide all relevant details on the pipeline code.
8. Save, apply and run the job for CD
