*** Settings ***
Documentation    Keywords e Variáveis para Ações Gerais
Library          OperatingSystem

*** Keywords ***
Validar Status Code "${statuscode}"
    Should Be True    ${response.status_code} == ${statuscode}

Validar Se Mensagem Contém "${palavra}"
    Should Contain    ${response.json()["message"]}    ${palavra}

Import JSON Estático
    [Arguments]    ${nome_arquivo}
    ${arquivo}     Get File    ${EXECDIR}/support/fixtures/static/${nome_arquivo}
    ${data}        Evaluate    json.loads('''${arquivo}''')    json
    RETURN       ${data}