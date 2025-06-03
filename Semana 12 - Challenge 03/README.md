# ☁️ Guia de Configuração EC2 - Runner de Testes Robot Framework

Este guia apresenta o passo-a-passo para criar uma segunda instância EC2 na AWS com objetivo de executar os testes automatizados Robot Framework de uma aplicação previamente hospedada (ex: ServeRest).

---

## 📌 Pré-requisitos

- Já deve existir uma instância EC2 com a **API em execução** (ex: ServeRest na porta 3000).
- Par de chaves `.pem` já criado anteriormente (ex: `ec2-pb-aws.pem`).
- VPC e Internet Gateway já configurados.
- IP público da API hospedada anotado.

---

## ⚙️ Etapa 1: Criar a Instância EC2 (Runner)

1. Acesse o painel da AWS (EC2) e clique em **Executar Instância**.
2. Preencha os seguintes campos:

| Campo             | Valor                       |
|------------------|-----------------------------|
| Name             | `Robot Runner`              |
| Project          | `Programa de Bolsas`        |
| CostCenter       | `Quality Assurance`         |
| AMI              | Amazon Linux 2023 (x86_64)  |
| Tipo             | `t2.micro`                  |
| Par de chaves    | `ec2-pb-aws.pem`            |
| IP Público       | Habilitado                  |
| Grupo de Segurança | SSH, HTTP, HTTPS (tudo liberado para testes) |

> ⚠️ *Não é necessário abrir a porta 3000, pois essa instância apenas consome a API.*

---

## 🔗 Etapa 2: Conectar-se à Instância

No terminal local:

```bash
cd ~/AWS-EC2
chmod 400 ec2-pb-aws.pem
ssh -i ec2-pb-aws.pem ec2-user@<IP_DA_RUNNER>
```

---

## 🔄 Etapa 3: Clonar o Repositório de Testes

Ainda dentro da instância:

```bash
sudo yum install git -y
git clone https://github.com/<seu-usuario>/<seu-repositorio>.git

cd <seu-repositorio>/ServeRest-Tests
```

---

## ✏️ Etapa 4: Configurar a URL da API

Edite o arquivo `resources/common.resource` e substitua a URL atual (`https://serverest.dev/`) pela URL da instância onde a API está rodando (ex: `http://<IP_DA_API>:3000`).

```robot
*** Keywords ***
Criar Sessão
    Create Session    ServeRest    http://<IP_DA_API>:3000
```

---

## 🛠️ Etapa 5: Preparar o Ambiente Robot Framework

```bash
sudo yum update -y
sudo yum install python3 pip -y

# Instalar bibliotecas do Robot Framework
pip3 install robotframework
pip3 install robotframework-requests
pip3 install robotframework-faker
```

---

## 🤖 Etapa 6: Executar os Testes

```bash
robot -d reports tests/
```

### Exemplos adicionais:

- Executar por tag:
  ```bash
  robot -d reports -i POSTPRODUTO tests/
  ```

- Executar arquivo específico:
  ```bash
  robot -d reports tests/usuarios_tests.robot
  ```

Os relatórios serão salvos na pasta `reports/` dentro da instância.

---

## ⛔ Etapa 7: Encerrar a Instância Após os Testes

**Na instância:**
```bash
Ctrl + C
```

**Na AWS:**

- Vá para EC2 > Instâncias
- Selecione a `Robot Runner`
- Clique em **Estado da Instância > Interromper**

A instância será pausada e os arquivos permanecerão salvos.