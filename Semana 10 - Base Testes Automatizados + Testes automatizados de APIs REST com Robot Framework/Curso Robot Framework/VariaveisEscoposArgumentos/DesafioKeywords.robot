*** Settings ***
Documentation  Teste de geração de e-mail automatizado a partir de nome, sobrenome e string aleatória
Library  String

*** Test Cases ***
Validar Geração De Email Com Nome E Sobrenome
  ${EMAIL}=  Gerar Email Personalizado  Pedro  Afonso
  Log To Console  ${EMAIL}

*** Keywords ***
Gerar Email Personalizado
  [Arguments]  ${NOME}  ${SOBRENOME}
  ${PALAVRA_RANDOMICA}=  Generate Random String
  ${EMAIL}=  Set Variable  ${NOME}${SOBRENOME}${PALAVRA_RANDOMICA}@testerobot.com
  RETURN  ${EMAIL}