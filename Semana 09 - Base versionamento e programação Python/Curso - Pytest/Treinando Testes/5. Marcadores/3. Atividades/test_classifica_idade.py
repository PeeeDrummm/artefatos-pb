import pytest

def classifica_idade(idade):
    if idade < 13:
        return "Criança"
    elif idade < 20:
        return "Adolescente"
    elif idade < 60:
        return "Adulto"
    else:
        return "Idoso"

@pytest.mark.Crianca
@pytest.mark.parametrize("idade", [0, 5, 12])
def test_classifica_crianca(idade):
    assert classifica_idade(idade) == "Criança"

@pytest.mark.Adolescente
@pytest.mark.parametrize("idade", [13, 15, 19])
def test_classifica_adolescente(idade):
    assert classifica_idade(idade) == "Adolescente"

@pytest.mark.Adulto
@pytest.mark.parametrize("idade", [20, 30, 59])
def test_classifica_adulto(idade):
    assert classifica_idade(idade) == "Adulto"

@pytest.mark.Idoso
@pytest.mark.parametrize("idade", [60, 70, 99])
def test_classifica_idoso(idade):
    assert classifica_idade(idade) == "Idoso"