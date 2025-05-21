*** Settings ***
Documentation    Desafio...

*** Variables ***
@{NUMEROS}    0    1    2    3    4    5    6    7    8    9    10

*** Test Cases ***
Executar Percurso da Lista
    Percorrer Lista

*** Keywords ***
Percorrer Lista
    FOR    ${I}    IN    @{NUMEROS}
        IF    ${I} == 5
            LOG    Eu sou o número 5!
        ELSE IF    ${I} == 10
            LOG    Eu sou o número 10!
        ELSE
            LOG    Eu não sou o número 5 e nem o 10!
        END
    END