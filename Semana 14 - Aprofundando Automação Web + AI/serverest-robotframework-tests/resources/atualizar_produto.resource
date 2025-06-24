*** Settings ***
Documentation    Keywords de Edição de Produtos
Resource         ./common/common.resource  

*** Keywords ***
Listar produtos e editar o produto criado
    Go To    ${BASE_URL}/admin/listarprodutos

    Wait For Elements State    css=table tbody td >> text=${data}[produto][nome]
    ...    visible
    ...    5

    ${element}    Set Variable
    ...    xpath=//td[text()="${data}[produto][nome]"]/..//button[@class="btn btn-info"]

    Wait For Elements State    ${element}
    ...    visible
    ...    5

    Click    ${element}

Validar se aparece o formulário de edição
    Wait For Elements State    css=for="price"
    ...    visible
    ...    5