squad = ["Brenda", "Thais", "Maria", "Alice", "Pedro"]  # Cria uma lista com 5 nomes

print(squad[-3])  # Acessa o 3º item de trás pra frente (resultado: "Maria")
print(squad[1:3])  # Acessa do índice 1 até o 2 (o 3 é exclusivo), resultado: ["Thais", "Maria"]
print(squad[2:])  # Acessa a partir do índice 2 até o final, resultado: ["Maria", "Alice", "Pedro"]

squad[4] = "Afonso"  # Altera o item no índice 4 ("Pedro") para "Afonso"
print(squad)  # Exibe a lista atualizada