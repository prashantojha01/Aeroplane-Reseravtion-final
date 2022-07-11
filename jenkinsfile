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
        stage('checkstyle') {
            steps {
                sh 'mvn checkstyle:checkstyle'
            }
        }
        stage('checkstyle Report') {
            steps {
                recordIssues(tools: [checkStyle(pattern: 'target/checkstyle-result.xml')])
            }
        }
        stage('code coverage') {
            steps {
                jacoco()
            }
        }
        stage('sonar scanner') {
            steps {
                    sh 'mvn clean verify sonar:sonar  -Dsonar.projectKey=chatappojha  -Dsonar.host.url=http://20.127.116.158:9000  -Dsonar.login=sqp_52b730d5bd175a42658c314bf225bb8d6fef6d84'
            }
        }
        stage ('Nexus upload')  {
          steps {
          nexusArtifactUploader(
          nexusVersion: 'nexus3',
          protocol: 'http',
          nexusUrl: '20.115.61.29:8081',
          groupId: 'AeroplaneReservation',
          version: '0.0.1-SNAPSHOT',
          repository: 'maven-snapshots',
          credentialsId: 'nexus-credential',
          artifacts: [
            [artifactId: 'AeroplaneReservation',
             classifier: '',
             file: 'target/AeroplaneReservation-0.0.1-SNAPSHOT.jar',
             type: 'jar']
        ]
        )
          }
     }
    }
}
