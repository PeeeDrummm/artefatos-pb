class Calculadora:

    def somar(self, n1, n2):
        return n1 + n2

    def subtrair(self, n1, n2):
        return n1 - n2

    def multiplicar(self, n1, n2):
        return n1 * n2

    def dividir(self, n1, n2):
        if n2 == 0:
            # Mensagem personalizada de erro em vez de um padrão do Pytest
            # O Raise só será coberto pelo pytest-cov se a linha for executada
            # Ou seja, caso a divisão seja por 0
            raise ValueError("Não é possível dividir por zero.")
        return n1 / n2

    # Operações adicionais: Juros Simples e Porcentagem
    def juros_simples(self, principal, taxa, tempo):
        return principal * taxa * tempo

    def porcentagem(self, valor, percentual):
        return valor * (percentual / 100)

# Tenho costume de dar espaço entre o nome do método e os parênteses
# Logo a IA presente no PyCharm, me sugeriu a remoção desses espaços
# Pois é uma boa prática do PEP8. Então de certa for foi utilizado IA para isso.