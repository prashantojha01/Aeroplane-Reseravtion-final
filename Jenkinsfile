pipeline {
    agent any
    // agent is where my pipeline will be eexecuted
    tools {
        //install the maven version configured as m2 and add it to the path
        maven "m3"
    }
    stages {
        stage('pull from scm') {
            steps {
            git credentialsId: 'ojha-github-token', url: 'https://github.com/prashantojha01/aeroplane-reservation-private.git'
            }
        }
        
        stage('mvn build') {
            steps {
            sh "mvn -Dmaven.test.failure.ignore=true clean package"
            }
            post {
                //if maven build was able to run the test we will create a test report and archive the jar in local machine
                success {
                    junit '**/target/surefire-reports/*.xml'
                    archiveArtifacts 'target/*.jar'
                }
            }
        }
        stage('ansible tomcat'){
            steps{
                ansiblePlaybook credentialsId: 'ansible-jenkins', disableHostKeyChecking: true, inventory: 'ojha.inv', playbook: 'tomcat.yml'
            }
        }
    }
}
