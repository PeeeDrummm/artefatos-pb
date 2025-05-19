numeros = [3, 9, 71, 800, 20, 88]  # Lista de números inteiros
amigos = ["Brenda", "Thais", "Maria", "Alice"]  # Lista de nomes (strings)

amigos.extend(numeros)  # Adiciona todos os elementos da lista 'numeros' ao final da lista 'amigos'
print(amigos)

amigos.append("Jacques QA")  # Adiciona um item ao final da lista
print(amigos)

amigos.insert(1, "Jacques QA")  # Insere um item no índice 1 (empurra os demais para frente)
print(amigos)

amigos.remove("Alice")  # Remove o item "Alice" da lista (primeira ocorrência)
print(amigos)

amigos.pop(0)  # Remove o item do índice 0 (primeiro item da lista)
print(amigos)

print(amigos.index("Thais"))  # Retorna o índice onde está o item "Thais"

amigos.append("Thais")  # Adiciona mais uma "Thais" para mostrar o count()
print(amigos.count("Thais"))  # Conta quantas vezes "Thais" aparece na lista

amigos.sort()  # Ordena a lista em ordem alfabética (cuidado: mistura de tipos como int/str dá erro)
print(amigos)

numeros.sort()  # Ordena a lista de números em ordem crescente
print(numeros)