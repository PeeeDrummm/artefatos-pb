*** Settings ***
Documentation    Keywords de Acesso as Páginas e Ações
Resource         ./common/common.resource  

*** Keywords ***
Acessar o site serverest
    Abrir página
    Wait For Elements State    xpath=//h1[text()="Login"]
    ...    visible
    ...    5

Logar com usuário administrador válido
    Fill Text      css=input[data-testid="email"]     ${EMAIL_ADMIN}
    Fill Text      css=input[data-testid="senha"]      ${SENHA_ADMIN}
    Click    css=button[data-testid="entrar"] 

Acessar página de usuários
    Wait For Elements State        css=[data-testid="listar-usuarios"]
    ...    visible
    ...    5
    Click                      css=[data-testid="listar-usuarios"]

Clicar no botão editar do primeiro usuário
    Wait For Elements State    xpath=(//tbody//button[contains(text(), "Editar")])[1]
    ...    visible
    ...    5

    Click                       xpath=(//tbody//button[contains(text(), "Editar")])[1]