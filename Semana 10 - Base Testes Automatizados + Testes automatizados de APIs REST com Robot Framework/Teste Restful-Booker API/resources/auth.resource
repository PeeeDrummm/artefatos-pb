*** Settings ***
Library    RequestsLibrary
Library    Collections
Resource   variables.resource

*** Keywords ***
# Gera um token de autenticação válido na API e armazena como Suite Variable
Generate Auth Token
    # Cria cabeçalhos HTTP
    ${headers}      Create Dictionary    Content-Type=application/json
    # Cria corpo de requisição com usuário e senha padrão da API
    ${body}         Create Dictionary    username=admin    password=password123

    # Cria sessão de conexão com a API
    Create Session  Booker    ${base_url}
    # Realiza o POST no endpoint de autenticação
    ${response}     POST On Session    Booker    /auth    json=${body}    headers=${headers}    expected_status=200

    # Converte resposta em JSON
    ${json}         Set Variable    ${response.json()}
    # Valida se a chave 'token' existe na resposta
    Dictionary Should Contain Key    ${json}    token

    # Salva token como Suite Variable para uso em outros testes/keywords
    Set Suite Variable    ${auth_token}    ${json['token']}