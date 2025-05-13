acordei_antes_9 = False  # Define se acordou antes das 9h
fome = True  # Define se está com fome

if acordei_antes_9 and fome:  # Se acordou antes das 9h e está com fome
    print("Hora de fazer o Café da Manhã")
elif acordei_antes_9 and not(fome):  # Se acordou antes das 9h e NÃO está com fome
    print("Hora de fazer uma Corrida")
else:  # Qualquer outro caso (acordou depois das 9h)
    print("Hora de fazer o Almoço")