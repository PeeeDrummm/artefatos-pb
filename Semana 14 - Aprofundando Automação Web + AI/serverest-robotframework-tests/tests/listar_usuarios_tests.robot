*** Settings ***
Documentation    Testes de Listagem de Usuários
Resource         ../resources/common/common.resource

Test Setup       Criar Sessao
Test Teardown    Take Screenshot
Suite Setup      Silenciar InsecureRequestWarning

*** Variables ***
${BASE_URL}         https://compassuolfront.serverest.dev
${BROWSER}          chromium
${NOME_ATUAL}       TesteBre
${EMAIL_ADMIN}      qabre@admin.com
${SENHA_ADMIN}      admin123

*** Test Cases ***
Cenário de teste 04 - Validar a lista de usuários no Serverest para usuário adm
    ${user}=    Criar usuario como administrador    #Thais
    Ir para a página de inscrição                   #Thais
    Excluir usuário - API    ${user['email']}       #Maria
    Enviar formulário de inscrição    ${user}       #Thais
    Acessar página de lista de usuários