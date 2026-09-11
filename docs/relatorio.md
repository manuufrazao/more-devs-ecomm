# 📋 Homologação em Par — Teste Cruzado (Flutter)

**Projeto avaliado:** ‹more-devs-ecomm›
**Dupla autora:** ‹Manuela›
**Dupla avaliadora:** ‹Emerson› 
**Data:** ‹10/09/2026›
---

## 🐞 Bugs encontrados

_(o que quebra ou não funciona ao usar o app — descreva o problema e, se possível, como reproduzir)_

- Na tela de recuperação de senha, não há botão de voltar — o usuário fica sem caminho de retorno visível caso queira desistir do fluxo.
- Ao concluir o cadastro, não há mensagem de confirmação de sucesso nem navegação automática para a próxima tela, deixando o usuário sem feedback do que aconteceu.

---

## ⚠️ Práticas ruins de codificação

_(o que está mal feito no código — ex.: tudo em um arquivo só, nomes confusos, código duplicado, sem tratamento de erro, warnings no `flutter analyze`)_

- As seções da Home (Categorias, Produtos, Banner) não estão componentizadas — o corpo da página concentra a lógica de renderização de todas elas junto, em vez de widgets próprios e reutilizáveis.
- Nome do usuário hardcoded na Home em vez de vir de uma variável/estado do controller de login, dificultando manutenção e testes.
