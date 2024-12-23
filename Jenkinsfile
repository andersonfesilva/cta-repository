pipeline {
    agent any
    environment {
        // Define o caminho do Terraform e outras variáveis, se necessário
        TERRAFORM_DIR = 'terraform-code'
        TERRAFORM_VERSION = '1.8.0'
        GCP_CREDENTIALS_JSON = credentials('key-gcp')
    }
    stages {
        stage('Prepare Credentials') {
            steps {
                sh '''
                cd ./terraform-code
                export GOOGLE_APPLICATION_CREDENTIALS=$GOOGLE_APPLICATION_CREDENTIALS
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
                    sh '../terraform/terraform  init  -var="gcp_credentials_file=$GOOGLE_APPLICATION_CREDENTIALS"'
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
                    sh '../terraform/terraform plan -out=tfplan -no-color -var="gcp_credentials_file=$GOOGLE_APPLICATION_CREDENTIALS"'
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
                    sh '../terraform/terraform apply -auto-approve tfplan -no-color -var="gcp_credentials_file=$GOOGLE_APPLICATION_CREDENTIALS"'
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
