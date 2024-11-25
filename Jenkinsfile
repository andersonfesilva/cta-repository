pipeline {
    agent any
    environment {
        // Define o caminho do Terraform e outras variáveis, se necessário
        TERRAFORM_DIR = 'terraform-code'
        TERRAFORM_VERSION = '1.6.0'
    }
    stages {
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
                script {
                    echo "Inicializando Terraform..."
                }
                dir("${env.TERRAFORM_DIR}") {
                    // Inicializar o Terraform
                    sh '../terraform/terraform init -no-color'
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
                    sh '../terraform/terraform plan -out=tfplan -no-color'
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
                    sh '../terraform/terraform apply -auto-approve tfplan -no-color'
                }
            }
        }
    }
    post {
        always {
            script {
                echo "Limpando arquivos temporários..."
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
