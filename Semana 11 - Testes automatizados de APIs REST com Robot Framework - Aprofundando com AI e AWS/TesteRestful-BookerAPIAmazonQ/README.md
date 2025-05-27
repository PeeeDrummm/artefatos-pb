# Uso do AmazonQ nos Testes com Robot Framework

## Visão Geral  
Neste projeto, exploramos o uso do AmazonQ como suporte à automação de testes de APIs (Restful-Booker) em Robot Framework. A ideia era avaliar onde a ferramenta incrementa produtividade e onde apresenta limitações.

---

## Pontos em que o AmazonQ foi efetivo  
1. **Geração inicial de cenários**  
  — Criou estruturas básicas de casos de teste (requests + asserts) com rapidez, acelerando o setup inicial.  

---

## Limitações identificadas no AmazonQ  
1. **Refatoração com base em Gherkin BDD**  
   — Não converte corretamente cenários em Gherkin para keywords legíveis: gera blocos muito verbosos e pouco organizados.  
2. **Adaptação de código após Code Review**  
   — Ignora sugestões de estilo e melhores práticas, mantendo ou até ampliando defeitos detectados (duplica lógica, não separa recursos).  
3. **Tamanho e organização de arquivos**  
   — Cria linhas e keywords excessivamente longas, sem respeitar a estrutura de múltiplos arquivos .resource/.robot pré-definida, concentrando tudo num só.  
4. **“Alucinações” em sessões prolongadas**  
   — Após várias requisições, começa a produzir trechos incoerentes (payloads inválidos, referências de variáveis inexistentes, sintaxe Robot quebrada).

---

## Dificuldades na Conclusão da Atividade  
- **Código anteriormente funcional foi corrompido**  
  — Após interações com o AmazonQ, o código que inicialmente funcionava quebrou, principalmente nos testes de autenticação e booking.
- **Complexidade na correção**  
  — Mesmo com suporte de outras ferramentas de IA, a recuperação e estabilização dos testes se mostrou difícil e demorada. Isso gerou atrasos na entrega e impediu a conclusão completa da atividade.