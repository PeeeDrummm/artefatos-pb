def classifica_idade(idade):
    if idade < 12:
        return "Criança"
    elif idade < 18:
        return "Adolescente"
    elif idade < 60:
        return "Adulto"
    else:
        return "Idoso"

@pytest.mark.parametrize("idade,categoria_esperada",[(10, "Criança"),(15, "Adolescente"), (30, "Adulto"), (70, "Idoso",)])
def test_classifica_idade(idade,categoria_esperada):
    assert classifica_idade(idade) == categoria_esperada