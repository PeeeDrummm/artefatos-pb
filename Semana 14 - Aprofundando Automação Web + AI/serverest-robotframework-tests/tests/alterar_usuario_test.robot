*** Settings ***
Documentation    Testes de Validção de Alteração de Usuário Válido
Resource         ../resources/common/common.resource

Test Setup       Criar Sessao
Test Teardown    Take Screenshot
Suite Setup      Silenciar InsecureRequestWarning

*** Test Cases ***
Cenário de teste 03 - Validar o campo de alteração/edição de um usuário válido
    ${user}=    Criar usuario como administrador    #Thais
    Ir para a página de inscrição                   #Thais
    Excluir usuário - API    ${user['email']}       #Maria
    Enviar formulário de inscrição    ${user}       #Thais
    Acessar página de usuários
    # Clicar no botão editar do primeiro usuário
    # Verificar o campo de preenchimento dos novos dados do usuário
