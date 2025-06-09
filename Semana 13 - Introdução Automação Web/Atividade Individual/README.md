
# 🗂️ Mapeamento de Mesmas Funções com Estratégias Diferentes

Este documento apresenta as diferentes estratégias de mapeamento aplicadas às mesmas funções no site **Bixo Café**, seguindo a **ordem preferencial**:  
1. ID  
2. Seletor customizado (atributo único)  
3. Name  
4. Class name  
5. CSS combinado  
6. XPath sem texto  
7. XPath por atributo/texto  
8. XPath por índice  
9. XPath relacional  

---

## 🔎 1. Botão de Lupa (Busca)

| Estratégia                  | Seletor                                                         | Justificativa                             |
|-----------------------------|------------------------------------------------------------------|-------------------------------------------|
| Class name                  | `.utilities-icon`                                                | Três Icones do Cabeçalho (Lupa, Conta e Carrinho/Sacola)                          |
| CSS combinado               | `svg.icon-inline.utilities-icon.align-bottom`                    | Garante todas as classes                  |


---

## 🛒 2. Botão da Sacola (Carrinho)

| Estratégia                  | Seletor                                                         | Justificativa                             |
|-----------------------------|------------------------------------------------------------------|-------------------------------------------|
| Class name                  | `.cart-icon`                                                     | Classe única                              |
| CSS combinado               | `svg.icon-inline.utilities-icon.cart-icon`                       | Todas as classes combinadas               |

---

## 🧱 3. Produtos na Página Inicial

| Estratégia                  | Seletor                                                                      | Justificativa                            |
|-----------------------------|-------------------------------------------------------------------------------|------------------------------------------|
| Atributo customizado        | `div[data-product-id='192904430']`                                          | Seleção específica de produto            |
| Class name                  | `.js-item-product`                                                          | Classe de cada card de produto           |
| CSS combinado               | `div.js-item-product.item-product.col-grid`                                 | Junta várias classes                     |
| CSS por atributo            | `div[data-component='product-list-item']`                                   | Tag de componente                         |
| XPath sem texto             | `//div[contains(@class,'js-item-product')]`                                 | Seleção por parte da classe              |
| XPath por atributo          | `//div[@data-product-id]`                                                   | Qualquer produto com atributo data-product-id |
| XPath por índice            | `(//div[contains(@class,'js-item-product')])[1]`                            | Primeiro item do grid                    |

---

## 📬 4. Botão "Enviar" (Newsletter)

| Estratégia                  | Seletor                                                                      | Justificativa                             |
|-----------------------------|-------------------------------------------------------------------------------|-------------------------------------------|
| XPath por índice            | `(//input[@type='submit'])[last()]`                                          | Seleciona último botão de submit          |

---

## 🧠 Conclusão

Mapeamos as **mesmas funções** utilizando **estratégias variadas** para evidenciar:

- Diferença de robustez entre seletores (ID vs CSS vs XPath).  
- A importância de selecionar elementos estáveis e semânticos.  
- Combinação de métodos para máxima flexibilidade.