# Publicar no itch.io — What's Behind the Door?

## Arquivos gerados
- Pasta: `export/web/` (contém `index.html` e arquivos `.js`, `.wasm`, `.pck`)
- Zip para upload: `export/whats-behind-the-door-web.zip`

## Passos no itch.io

1. Acesse https://itch.io e faça login (ou crie conta com **Register**)
2. **Dashboard → Create new project**
3. Preencha:

| Campo | Valor sugerido |
|-------|----------------|
| **Title** | What's Behind the Door? |
| **Project URL** | `whats-behind-the-door` |
| **Kind of project** | HTML |
| **Classification** | Games |
| **Release status** | Prototype |
| **Pricing** | No payments |

4. Em **Uploads**, envie o arquivo `export/whats-behind-the-door-web.zip`
5. Marque **This file will be played in the browser**
6. Em **Embed options**, use resolução **1152 × 648**
7. Cole a descrição de `itch_description.md`
8. Visibilidade: **Restricted** (só quem tem o link) para entregar no Teams
9. Clique em **Save** e teste o jogo na página (F12 → Console para erros)

## Testar antes de entregar
- [ ] Jogo carrega no navegador
- [ ] Menu → Jogar funciona
- [ ] Controles respondem (clique dentro do iframe primeiro)
- [ ] Dá para completar a fase e ver o Reino dos Gatos
