pipeline {
    agent any
    environment {
        // Define o caminho do Terraform e outras variáveis, se necessário
        TERRAFORM_DIR = 'terraform-code'
    }
    stages {
        stage('Prepare') {
            checkout scm
            steps {
                script {
                    echo "Preparando o ambiente..."
                }
                // Baixar ou configurar dependências necessárias
                sh 'terraform --version'
            }
        }
        stage('Init') {
            steps {
                script {
                    echo "Inicializando Terraform..."
                }
                dir("${env.TERRAFORM_DIR}") {
                    // Inicializar o Terraform
                    sh 'terraform init'
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
                    sh 'terraform plan -out=tfplan'
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
                    sh 'terraform apply -auto-approve tfplan'
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
