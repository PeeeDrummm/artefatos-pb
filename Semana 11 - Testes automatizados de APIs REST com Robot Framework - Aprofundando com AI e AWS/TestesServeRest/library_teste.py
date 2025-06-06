import requests as req
import json

def Get_Endpoint_Usuario_Tantas_Vezes(vezes):
    lista = []
    for vez in range(0, vezes):
        r = req.get("http://localhost:3000/usuarios")
        para_json = r.json()
        lista.append(para_json)
    return lista

def Pegar_Quantidade_de_Usuarios_Cadastrados():
    r = req.get("http://localhost:3000/usuarios")
    request_json = r.json()
    return request_json["quantidade"]