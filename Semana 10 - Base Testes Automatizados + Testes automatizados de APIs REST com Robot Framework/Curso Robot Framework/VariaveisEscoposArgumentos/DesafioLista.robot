*** Settings ***
Documentation  Teste simples para imprimir os meses do ano individualmente

*** Variables ***
@{MESES_DO_ANO}  Janeiro  Fevereiro  Março  Abril  Maio  Junho  Julho  Agosto  Setembro  Outubro  Novembro  Dezembro

*** Test Cases ***
Imprimir Meses
  Log To Console  ${MESES_DO_ANO}[0]
  Log To Console  ${MESES_DO_ANO}[1]
  Log To Console  ${MESES_DO_ANO}[2]
  Log To Console  ${MESES_DO_ANO}[3]
  Log To Console  ${MESES_DO_ANO}[4]
  Log To Console  ${MESES_DO_ANO}[5]
  Log To Console  ${MESES_DO_ANO}[6]
  Log To Console  ${MESES_DO_ANO}[7]
  Log To Console  ${MESES_DO_ANO}[8]
  Log To Console  ${MESES_DO_ANO}[9]
  Log To Console  ${MESES_DO_ANO}[10]
  Log To Console  ${MESES_DO_ANO}[11]