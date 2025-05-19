print("Pedro\'s Afonso")  # Adiciona aspas simples na string usando caractere de escape
print("Pedro\nAfonso")  # Quebra de linha (newline)

nome = "Pedro Afonso"  # Cria uma variável com uma string
print(nome + " tem 25 anos de idade")  # Concatena variável com uma string literal

print(nome.upper())  # Converte todos os caracteres da string para maiúsculo
print(len(nome))  # Retorna o número total de caracteres na string (inclui espaço)

print(nome[6])  # Acessa o caractere no índice 6 (lembre: index começa em 0)
print(nome.index("Afo"))  # Retorna o índice onde começa a substring "Afo"
print(nome.count("A"))  # Conta quantas vezes a letra "A" aparece na string