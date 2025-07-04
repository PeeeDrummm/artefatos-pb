*** Settings ***
Documentation    Page Object: operações genéricas de navegador (abrir, fechar, novo contexto).
...              Reutilizado em qualquer teste UI; não contém lógica de páginas específicas.

Resource         ../base.resource

*** Keywords ***
Iniciar Navegador
    [Documentation]    Abre browser headless (${BROWSER}) e navega para ${BASE_FRONT_URL}.
    New Browser    browser=${BROWSER}    headless=true
    New Page       url=${BASE_FRONT_URL}

Fechar Navegador
    [Documentation]    Fecha todas as janelas/contexts do browser.
    Close Browser

Iniciar Página Limpa
    [Documentation]    Cria novo Browser Context limpo e carrega página inicial.
    New Context
    New Page       url=${BASE_FRONT_URL}