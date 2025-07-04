*** Settings ***
Documentation    Page Object – seleção de assentos + helpers (conversão de linha).

Resource         ../base.resource

*** Keywords ***
Selecionar Assento
    [Documentation]    Marca assentos; falha se ocupado; prossegue para pagamento.
    [Arguments]    @{assentos}

    FOR    ${assento}    IN    @{assentos}
        ${linha}=         Set Variable                  ${assento}[0]
        ${coluna}=        Set Variable                  ${assento}[2]
        ${linha_num}=     Converter Letra Para Linha    ${linha}

        ${seletor}=       Set Variable                   css=div.seat-row:nth-child(${linha_num}) > div:nth-child(2) > button:nth-child(${coluna})
        ${classe}=        Get Attribute                  ${seletor}    class

        Run Keyword If    'occupied' in '${classe}'      Fail    Assento ${linha}${coluna} está ocupado!
        Click             ${seletor}
    END

    # Prossegue para o pagamento se os assentos recebidos estiverem disponiveis
    Get Text    css=.checkout-button    ==    Continuar para Pagamento
    Click       css=.checkout-button

    Wait For Elements State    css=.payment-section    visible

Converter Letra Para Linha
    [Documentation]    Retorna índice numérico da linha A-Z.
    [Arguments]    ${letra}
    ${letras}=     Create List    A    B    C    D    E    F    G    H    I    J    K    L    M    N    O    P    Q    R    S    T    U    V    W    X    Y    Z
    ${indice}=     Evaluate       ${letras}.index("${letra}") + 1
    RETURN         ${indice}