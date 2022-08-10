pipeline {
  agent {
    kubernetes {
      yaml '''
        apiVersion: v1
        kind: Pod
        spec:
          serviceAccountName: jenkins
          containers:
          - name: kubectl
            image: bitnami/kubectl:latest
            command:
            - cat
            tty: true          
          - name: docker
            image: docker:latest
            command:
            - cat
            tty: true
            volumeMounts:
             - mountPath: /var/run/docker.sock
               name: docker-sock
          volumes:
          - name: docker-sock
            hostPath:
              path: /var/run/docker.sock    
        '''
    }
  }
  stages {
    stage('Clone') {
      steps {
        container('docker') {
          git branch: 'master', changelog: false, poll: false, url: 'https://github.com/rahulit1991/assessment-test.git'
        }
      }
    }  
    stage('Build-Docker-Image') {
      steps {
        container('docker') {
          sh 'docker build -t rahulit1991/sample-nodejs:latest ${WORKSPACE}/sample-application/'
        }
      }
    }
    stage('Login-Into-Docker') {
      steps {
        container('docker') {
          withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
          sh 'docker login -u $USERNAME -p $PASSWORD'
          }
      }
    }
    }
     stage('Push-Images-Docker-to-DockerHub') {
      steps {
        container('docker') {
          sh 'docker push rahulit1991/sample-nodejs:latest'
      }
    }
     }
    stage('Deploy kubernetes') {
      agent {
        label "k8-cluster-0"
      }
      steps {
        container('kubectl') {       
          sh 'kubectl apply -f deployment.yaml'
        }
      }     
   }
  }  
    post {
      always {
        container('docker') {
          sh 'docker logout'
      }
      }
    }
}