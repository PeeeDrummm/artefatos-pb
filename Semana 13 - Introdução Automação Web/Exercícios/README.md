
# 🧭 Estratégia de Mapeamento de Elementos - Projeto Automação Web

Este documento apresenta os mapeamentos realizados pela squad em três sites diferentes, utilizando seletores alinhados à **ordem preferencial** estudada, priorizando **estabilidade, clareza e manutenibilidade**.

---

## ✅ Site: [Livelo](https://www.livelo.com.br)

| Elemento                     | Seletor             | Tipo de seletor | Justificativa |
|-----------------------------|---------------------|------------------|----------------|
| Botão do carrinho           | `#l-cart__button`   | ID único         | IDs são a forma mais estável e preferencial de mapeamento. |
| Botão de login              | `#l-header__button_login` | ID único   | ID fixo e descritivo. |
| Botão de cadastro           | `#l-header__button_register` | ID único | Garantia de unicidade e fácil manutenção. |

---

## ✅ Site: [Divvino](https://www.divvino.com.br)

### 🔹 Mapeamento de Categorias (Menu Principal)

Usamos **CSS combinados com seletor de atributo `[title='...']`**, pois os elementos não têm IDs, mas têm títulos fixos e semânticos.

```css
ul[class*='menuContainer--headerMenuDesktop'] [title='VINHOS']
ul[class*='menuContainer--headerMenuDesktop'] [title='KITS']
ul[class*='menuContainer--headerMenuDesktop'] [title='VINHOS PONTUADOS']
ul[class*='menuContainer--headerMenuDesktop'] [title='ACESSÓRIOS']
ul[class*='menuContainer--headerMenuDesktop'] [title='CERVEJAS']
ul[class*='menuContainer--headerMenuDesktop'] [title='GOURMET']
ul[class*='menuContainer--headerMenuDesktop'] [title='DESTILADOS']
ul[class*='menuContainer--headerMenuDesktop'] [title='BLOG']
```

### 🔹 Mapeamento de Produtos

| Elemento             | Seletor                             | Tipo de seletor | Justificativa |
|----------------------|--------------------------------------|------------------|----------------|
| Box de produto       | `.vtex-product-summary-2-x-container` | CSS combinado    | Classe aplicada diretamente a cada item da prateleira. |

### 🔹 Outros Elementos

| Elemento                     | Seletor                                                             | Tipo de seletor | Justificativa |
|------------------------------|----------------------------------------------------------------------|------------------|----------------|
| Ícone de lupa (busca)        | `.vtex-store-components-3-x-searchBarIcon--headerSearch--external-search` | CSS combinado    | Classe específica e direta. |
| Botão 'ir para o carrinho'   | `#hpa-cart`                                                        | ID único         | Estável e direto. |

---

## ✅ Site: [Google](https://www.google.com)

| Elemento                          | Seletor                             | Tipo de seletor | Justificativa |
|-----------------------------------|--------------------------------------|------------------|----------------|
| Campo de busca                    | `#APjFqb`                            | ID único         | ID fixo e altamente confiável. |
| Botão “Pesquisa Google”          | `(//input[@class='gNO89b'])[1]`      | XPath com índice | Como há dois botões iguais, usamos índice para pegar o visível. |
| Sugestões automáticas (autocomplete) | `div.UUbT9.EyBRub ul li`         | CSS combinado    | Mapeia a lista de sugestões geradas antes da pesquisa. |

---

## 🧠 Conclusão

Todos os mapeamentos foram feitos seguindo a **ordem preferencial de seletores**, priorizando `ID` quando possível, e recorrendo a `class`, `CSS combinados` ou `XPath` apenas quando necessário. Isso garante:

- Testes mais robustos e menos suscetíveis a falhas com mudanças de layout.
- Manutenção mais simples.
- Clareza nos scripts automatizados.

