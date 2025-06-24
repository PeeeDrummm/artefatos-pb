*** Settings ***
Documentation    Testes de Edição de Produto
Resource         ../resources/common/common.resource

Test Teardown    Take Screenshot
Suite Setup      Silenciar InsecureRequestWarning

*** Test Cases ***
Atualizar produto valido - Maria Eduarda
    Criar produto - API
    Abrir página
    Logar
    Listar produtos e editar o produto criado
    # Validar se aparece o formulário de edição
    Excluir produto - API    ${data}[produto][nome]
    Excluir usuário - API    ${data}[usuario][email]