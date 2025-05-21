*** Settings ***
Library  Collections
Documentation  Teste com dicionário e loop automático pelos meses

*** Variables ***
&{MESES_DIAS}
...  Janeiro=31  
...  Fevereiro=28
...  Marco=31
...  Abril=30
...  Maio=31
...  Junho=30
...  Julho=31
...  Agosto=31
...  Setembro=30
...  Outubro=31
...  Novembro=30
...  Dezembro=31

*** Test Cases ***
Imprimir Todos Os Meses E Dias
  FOR  ${MES}  IN  @{MESES_DIAS.keys()}
    Exibir Mes Com Dias  ${MES}
  END

*** Keywords ***
Exibir Mes Com Dias
  [Arguments]  ${MES}
  ${DIAS}=  Get From Dictionary  ${MESES_DIAS}  ${MES}
  Log To Console  ${MES}: ${DIAS} dias