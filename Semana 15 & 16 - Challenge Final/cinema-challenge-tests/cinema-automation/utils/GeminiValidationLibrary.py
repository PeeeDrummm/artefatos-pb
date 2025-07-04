import os
import google.generativeai as genai
from dotenv import load_dotenv

# Carrega as variáveis do ficheiro .env
load_dotenv()

class GeminiValidationLibrary:
    """
    Biblioteca personalizada para o Robot Framework que usa o Gemini para validações inteligentes.
    """

    def __init__(self):
        # Configura a API do Gemini com a chave do .env
        api_key = os.getenv('GEMINI_API_KEY')
        if not api_key:
            raise Exception("A variável de ambiente GEMINI_API_KEY não foi definida no ficheiro .env.")
        genai.configure(api_key=api_key)
        
        # Seleciona o modelo do Gemini
        self.model = genai.GenerativeModel('gemini-1.5-flash-latest')

    # A CORREÇÃO: Adicionamos um novo argumento 'status_code_real'
    def validar_resposta_da_api_com_ia(self, resposta_real_api: str, status_code_real: str, status_code_esperado: str, contexto_esperado: str):
        """
        Envia a resposta completa (body e status) para o Gemini e pede um veredito.
        """
        
        # A CORREÇÃO: O prompt agora inclui o status code real que recebemos da API.
        prompt = f"""
        Você é um engenheiro de QA a validar um teste de API.

        O resultado esperado do teste era:
        - Status Code: "{status_code_esperado}"
        - Contexto: "{contexto_esperado}"

        A resposta REAL recebida da API foi:
        - Status Code Real: "{status_code_real}"
        - Corpo da Resposta:
        ```json
        {resposta_real_api}
        ```

        Analise se a resposta real corresponde ao resultado esperado.
        A sua análise DEVE começar com uma das seguintes palavras em maiúsculas: SUCESSO ou FALHA.
        - Use SUCESSO se o status code real e o conteúdo da mensagem na resposta real correspondem ao que era esperado.
        - Use FALHA se o status code for diferente ou se a mensagem não corresponder ao contexto esperado.
        Após o veredito, forneça uma explicação curta em português.
        """

        try:
            # Envia o prompt para o Gemini
            response = self.model.generate_content(prompt)
            
            # Pega a análise de texto do Gemini
            analysis = response.text.strip()
            
            # Imprime a análise completa no log para depuração
            print(f"\n--- Análise do Gemini ---\n{analysis}\n------------------------")

            # Faz a keyword falhar no Robot Framework se a análise não começar com "SUCESSO"
            if not analysis.startswith("SUCESSO"):
                raise AssertionError(f"Validação da IA falhou. Análise do Gemini: {analysis}")
            
            # Se começar com SUCESSO, o teste passa e a análise é retornada para o log.
            return analysis

        except Exception as e:
            raise AssertionError(f"FALHA: Erro ao comunicar com a API do Gemini: {e}")