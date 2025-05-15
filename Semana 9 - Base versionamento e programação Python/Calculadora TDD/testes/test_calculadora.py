import sys
import os
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 'app')))
# O Python não estava conseguindo encontrar o arquivo calculadora.py
# Pois ele está em uma subpasta (app/) e o Python não sabe disso por padrão
# Chat-GPT sugeriu as linhas acima para contornar o problema.

import pytest
from calculadora import Calculadora

@pytest.fixture # Cria um ambiente isolado para o teste / Decorador
                # Por conta das operações adicionais, estava tendo problemas.
def calc():
    return Calculadora()

def test_somar(calc):
    assert calc.somar(7, 17) == 24

# Teste adicional utilizando Parametrização
@pytest.mark.parametrize("n1, n2, esperado", [(7, -7, 0), (-7, 7, 0)])
def test_somar_parametrizado(calc, n1, n2, esperado):
    assert calc.somar(n1, n2) == esperado

def test_subtrair(calc):
    assert calc.subtrair(17, 7) == 10

def test_multiplicar(calc):
    assert calc.multiplicar(7, 17) == 119

def test_dividir(calc):
    # Usado round para arredondar o resultado com duas casas decimais
    assert round(calc.dividir(17, 7), 2) == 2.43

def test_divisao_por_zero(calc):
    # Teste da exceção: divisão por zero. Para cobrir 100% com o pytest-cov
    with pytest.raises(ValueError):
        calc.dividir(17, 0)

# Teste das operações adicionais: Juros Simples e Porcentagem

def test_juros_simples(calc):
    # Pytest estava comparando com todas as casas decimais
    # Utilizado o round para arredondar para 2 casas decimais da comparação
    assert round(calc.juros_simples(7000, 0.07, 17), 2) == 8330.0

def test_porcentagem(calc):
    # Arredondamento usado para evitar erro de precisão
    assert round(calc.porcentagem(17, 7), 2) == 1.19

# Tenho costume de dar espaço entre o nome do método e os parênteses
# Logo a IA presente no PyCharm, me sugeriu a remoção desses espaços
# Pois é uma boa prática do PEP8. Então de certa for foi utilizado IA para isso.