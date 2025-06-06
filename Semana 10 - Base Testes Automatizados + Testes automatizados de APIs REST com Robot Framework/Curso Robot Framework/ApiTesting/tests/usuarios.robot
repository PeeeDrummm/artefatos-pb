*** Settings ***
Resource    ../resource/usuarios.resource

*** Test Cases ***
Cenário 01: Cadastrar um novo usuário com sucesso na ServeRest
    Criar um usuário novo
    Cadastrar o usuário na ServeRest    email=${email_teste}    status_code_desejado=201
    Conferir se o usuário foi cadastrado corretamente

Cenário 02: Cadastrar um usuário já existente
    Criar um usuário novo
    Cadastrar o usuário na ServeRest    email=${email_teste}    status_code_desejado=201
    Vou repetir o cadastro do usuário
    
Cenário 03: Consultar os dados de um novo usuário
    Criar um usuário novo
    Cadastrar o usuário na ServeRest    email=${email_teste}    status_code_desejado=201
    Consultar os dados do novo usuário
    Conferir os dados retornados

Cenário 04: Logar com o novo usuário criado
    Criar um usuário novo
    Cadastrar o usuário na ServeRest    email=${email_teste}    status_code_desejado=201
    Realizar Login com o usuário
    Conferir se o Login ocorreu com sucesso