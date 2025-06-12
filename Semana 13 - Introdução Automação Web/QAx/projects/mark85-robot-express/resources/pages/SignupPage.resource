*** Settings ***
Documentation    Elemtos e ações da página de cadastro
Library          Browser
Resource         ../env.resource

*** Keywords ***
Go to signup page
    Go To          ${BASE_URL}/signup

    # Checkpoint                #//h1[text()="Faça seu cadastro"]
    # Wait For Elements State    xpath=//h1    visible    5
    # Get Text                   xpath=//h1    equal      Faça seu cadastro

    Wait For Elements State    css=h1           visible    5
    Get Text                   css=h1           equal      Faça seu cadastro
Submit signup form
    [Arguments]                ${user}
    # Fill Text                css=#name
    # Fill Text                xpath=//input[@id="name"]
    Fill Text                  css=input[name=name]        ${user}[name]
    Fill Text                  css=input[name=email]       ${user}[email]
    Fill Text                  css=input[name=password]    ${user}[password]

    # Click                    //button[text()="Cadastrar"]
    Click                      css=button[type=submit] >> text=Cadastrar
