pipeline {
    agent any
    environment {
        // Define o caminho do Terraform e outras variáveis, se necessário
        TERRAFORM_DIR = 'terraform-code'
        TERRAFORM_VERSION = '1.8.0'
        GCP_CREDENTIALS_JSON = credentials('gcp-access')
    }
    stages {
        stage('Prepare Credentials') {
            steps {
                sh '''
                echo "$GCP_CREDENTIALS_JSON" > $WORKSPACE/terraform-code/key-cta-user.json
                export GOOGLE_APPLICATION_CREDENTIALS=$WORKSPACE/terraform-code/key-cta-user.json
                '''
            }
        }
        stage('Install Terraform') {
            steps {
                sh '''
                if ! [ -x "$(command -v terraform)" ]; then
                    curl -O https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
                    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d ./terraform
                fi
                ./terraform/terraform --version
                '''
            }
        }
        stage('Init') {
            steps {
               
                // do something with the file, for instance 
                script {
                    echo "Inicializando Terraform..."
                }
                dir("${env.TERRAFORM_DIR}") {
                    // Inicializar o Terraform
                    sh '../terraform/terraform  init -no-color'
                }
               
                
            }
        }
        stage('Plan') {
            steps {
                script {
                    echo "Gerando plano de execução Terraform..."
                }
                dir("${env.TERRAFORM_DIR}") {
                    // Gerar o plano do Terraform
                    sh '../terraform/terraform plan -var="GOOGLE_APPLICATION_CREDENTIALS=$WORKSPACE/terraform-code/key-cta-user.json" -out=tfplan -no-color'
                }
            }
        }
        stage('Apply') {
            steps {
                script {
                    echo "Aplicando mudanças com Terraform..."
                }
                dir("${env.TERRAFORM_DIR}") {
                    // Aplicar as mudanças
                    sh '../terraform/terraform apply -var="GOOGLE_APPLICATION_CREDENTIALS=$WORKSPACE/terraform-code/key-cta-user.json" -auto-approve tfplan -no-color'
                }
            }
        }
    }
    post {
        always {
            script {
                echo "Limpando arquivos temporários..."
                sh "rm -rf ./terraform"
            }
            dir("${env.TERRAFORM_DIR}") {
                // Remover arquivos gerados
                sh 'rm -f tfplan'
            }
        }
        success {
            script {
                echo "Pipeline concluído com sucesso!"
            }
        }
        failure {
            script {
                echo "Pipeline falhou. Verifique os logs."
            }
        }
    }
}
