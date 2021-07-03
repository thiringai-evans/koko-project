pipeline {
    agent any 
    environment {
        registry = "thiringai/kokonetworksjenkins"
        registryCredential = 'dockerhub'
        dockerImage = ''
    }
    
    stages {
        stage('Cloning Git') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/thiringai-evans/koko-project']]])       
            }
        }
    
    // Building specified docker image
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry
        }
      }
    }
    
     // Pushing Docker image into specified registry
    stage('Upload Image') {
     steps{    
         script {
            docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
            }
        }
      }
    }
    
     // Stopping Docker containers for cleaner Docker run
     stage('docker stop container') {
         steps {
            sh 'docker ps -f name=kokonetworksjenkins -q | xargs --no-run-if-empty docker container stop'
            sh 'docker container ls -a -f name=kokonetworksjenkins -q | xargs -r docker container rm'
         }
       }
    
    
    // Running Docker container and open port 5000 
    stage('Docker Run') {
     steps{
         script {
            dockerImage.run("-p 5000:5000 --rm --name kokonetworksjenkins")
         }
      }
    }

    stage('provision TF ec2 instance') {
        environment {
            AWS_ACCESS_KEY_ID = credentials('aws_access_key_id')
            AWS_SECRET_ACCESS_KEY = credentials('aws_secret_access_key')
        }
        steps{
            script {
                dir('terraform') {
                    sh "terraform init"
                    sh "terraform apply --auto-approve"
                    EC2_PUBLIC_IP = sh(
                        script: "terraform output ec2_public_ip",
                        returnStdout: true
                    ).trim()
                }
            }
        }
    }

    //deploy container to ec2 instance
    stage("deploy to ec2 instance") {

        steps {

            script {
                echo "waiting for ec2 server to initialize"
                echo "${EC2_PUBLIC_IP}"
                sleep(time: 90, unit: "SECONDS")
                sshagent(['ec2-ssh']) {
                    def dockercmd = 'docker run -p 5000:5000 -d thiringai/koko-thiringai'
                    sh "ssh -o StrictHostKeyChecking=no ubuntu@${EC2_PUBLIC_IP} ${dockercmd}"
                }
                
            }

        }

    }
  }
}
