# KOKO CI/CD

A python (flask) rest-api deployment to showcase CI/CD 

## Tech stack

- Docker
- Jenkins 
- Ansible 
- Terraform

HOW TO RUN
----------------------

1. Create a _Working dir_ or _Virtual Environment_ on your local machine or cloud server
2. Clone the repository
3. Ensure you have _python_ or _python3_ installed
4. Run python **app.py** to run the app directly then access it from http://localhost:5000
5. Run `docker build -t <name of choice>` .
6. To run the app, use `docker run -d <name of choice>` 

TERRAFORM
---------------------------------
1. Install Terraform on your machine.
2. Run `terraform init`, to initialize a working directory and support for your provider
3. Run `terraform plan`, to view all resources that shall be created.
4. Run `terraform apply`, to create your resources

AWS-S3
---------------------------------------
1. An S3 bucket requires a unique name, make sure you change the bucket name. 
2. A good way of labelling a bucket is using your name or organisations name, followed by bucket purpose.
3. Ensure you have configured **aws-cli** on your machine and authorized it.

DOCKER + ANSIBLE
-----------------------------------------
1. Install Ansible and all its dependencies.
2. Edit your hosts file for servers to be configured.
3. Ensure you have allowed ssh access on your servers.
4. Run `ansible-playbook dockerstart.yaml`
5. This will install Docker on your remote server, pull the image and run it on your server.

JENKINS
--------------------
1. Create a Jenkins instance.
2. Install Jenkins and access it.
3. Install docker on your Jenkins instance and make sure its running.
4. On your Jenkins UI install Docker plugins.
5. To push the image to your preferred registry, configure credentials on the Jenkins management UI.
6. Create a Jenkins job and choose pipeline
7. Use a _Webhook_ for push, and provide relevant details in case a change is done for CI
8. Alternatively poll scm for when a push is done can be used for CI, but it creates more server load than _Webhooks_ 
7. Provide all relevant details on the pipeline code.
8. Save, apply and run the job for CD
