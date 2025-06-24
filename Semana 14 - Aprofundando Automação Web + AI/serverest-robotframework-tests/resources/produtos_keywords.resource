*** Settings ***
Documentation    Keywords de Produto
Resource         ./common/common.resource  

*** Keywords ***
Cadastrar um produto valido
    # Ir para cadastro
    Get Text    [data-testid="cadastrarProdutos"]    ==    Cadastrar
    Click       [data-testid="cadastrarProdutos"]

    Wait For Elements State    h1           visible    5s
    ${titulo}=                 Get Text     h1
    Should Be Equal            ${titulo}    Cadastro de Produtos

    # Preenche e cadastra
    Set Suite Variable    ${nome_produto}    TV do Pedro

    Fill Text    [data-testid="nome"]         ${nome_produto}
    Fill Text    [data-testid="preco"]        777
    Fill Text    [data-testid="descricao"]    Uma TV Muito Boa
    Fill Text    [data-testid="quantity"]     7

    Get Text     [data-testid="cadastarProdutos"]    ==    Cadastrar
    Click        [data-testid="cadastarProdutos"]

    # Aguarda a tabela da lista de produtos carregar
    Wait For Elements State    css=.table.table-striped    visible    5s

Listagem de produtos validos
    # Pegar Linha dos Produtos
    ${linhas}=    Get Elements    css=.table.table-striped tbody tr

    # Percorrer TODOS os Produtos até Encontrar o Último Cadastrado
    ${produto_encontrado}=    Set Variable    False
    FOR    ${linha}    IN    @{linhas}
        ${texto_linha}=    Get Text    ${linha}
        IF    $nome_produto in $texto_linha
            ${produto_encontrado}=    Set Variable    True
            Exit For Loop
        END
    END
    Should Be True    ${produto_encontrado}    Produto ${nome_produto} não encontrado na tabela.