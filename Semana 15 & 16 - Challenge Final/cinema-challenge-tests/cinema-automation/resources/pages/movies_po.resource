*** Settings ***
Documentation    Page Object – listagem / busca de filmes e navegação para detalhes.

Resource         ../base.resource

*** Keywords ***
Ir para Página de Filmes em Cartaz
    [Documentation]   Abre grid de filmes pelo menu.
    Click                      css=header a[href="/movies"]
    Wait For Elements State    css=.movies-container    visible

Selecionar Filme
    [Documentation]    Clica em “Ver Detalhes” conforme índice de card.
    [Arguments]                ${indice}
    ${seletor}=                Set Variable                css=div.movie-card:nth-child(${indice}) > div:nth-child(2) > a:nth-child(5)
    Wait For Elements State    ${seletor}                  visible
    Get Text                   ${seletor}    ==            Ver Detalhes
    Click                      ${seletor}
    Wait For Elements State    css=.movie-detail-header    visible

Buscar Filmes e Validar
    [Documentation]    Executa busca para lista de títulos em loop.
    [Arguments]    @{titulos}
    FOR    ${titulo}    IN    @{titulos}
        Preencher E Validar Busca    ${titulo}
    END

Preencher E Validar Busca
    [Documentation]    Busca título específico e valida resultado.
    [Arguments]    ${titulo}

    Clear Text                        css=.search-box input
    Fill Text                         css=.search-box input    ${titulo}
    Wait Until Keyword Succeeds       5x    1s                 Wait For Elements State    css=.loading-spinner    hidden

    ${existe}=    Run Keyword And Return Status    Wait For Elements State    css=.movie-card h3    visible    timeout=3s

    IF    ${existe}
        ${resultado}=    Get Text    css=.movie-card h3
        Log To Console  🔍 Filme encontrado: ${resultado}
        Should Contain    ${resultado}    ${titulo}
    ELSE
        Log To Console    ⚠️ Nenhum filme encontrado para: ${titulo}    WARN
    END
    