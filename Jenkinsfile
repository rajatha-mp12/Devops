pipeline {
    agent any

    environment {
        ACR_NAME = "jenkinspractice"
        IMAGE_NAME = "backend-app"
        RESOURCE_GROUP = "my-rg"
        CONTAINER_APP = "backend-app"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Maven') {
            steps {
                dir('experiment-02-maven') {
                    sh 'mvn clean package -DskipTests'
                }
            }
        }

        stage('Docker Build') {
            steps {
                dir('experiment-02-maven') {
                    sh '''
                    docker build -t $ACR_NAME.azurecr.io/$IMAGE_NAME:$BUILD_NUMBER .
                    '''
                }
            }
        }

stage('Push Image') {
    steps {
        withCredentials([
            string(credentialsId: 'AZURE_CLIENT_ID', variable: 'AZURE_CLIENT_ID'),
            string(credentialsId: 'AZURE_CLIENT_SECRET', variable: 'AZURE_CLIENT_SECRET'),
            string(credentialsId: 'AZURE_TENANT_ID', variable: 'AZURE_TENANT_ID')
        ]) {
            sh '''
            az login --service-principal \
              -u $AZURE_CLIENT_ID \
              -p $AZURE_CLIENT_SECRET \
              --tenant $AZURE_TENANT_ID

            az acr login --name $ACR_NAME

            docker push $ACR_NAME.azurecr.io/$IMAGE_NAME:$BUILD_NUMBER
            '''
        }
    }
}
stage('Deploy to Azure') {
    steps {
        withCredentials([
            string(credentialsId: 'AZURE_CLIENT_ID', variable: 'AZURE_CLIENT_ID'),
            string(credentialsId: 'AZURE_CLIENT_SECRET', variable: 'AZURE_CLIENT_SECRET'),
            string(credentialsId: 'AZURE_TENANT_ID', variable: 'AZURE_TENANT_ID')
        ]) {
            sh '''
            az login --service-principal \
              -u $AZURE_CLIENT_ID \
              -p $AZURE_CLIENT_SECRET \
              --tenant $AZURE_TENANT_ID

            az containerapp update \
              --name $CONTAINER_APP \
              --resource-group $RESOURCE_GROUP \
              --image $ACR_NAME.azurecr.io/$IMAGE_NAME:$BUILD_NUMBER
            '''
        }
    }
}
    }
}
