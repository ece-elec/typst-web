# typst-web

Support de cours et travaux pratiques d'ingénierie (traitement du signal & systèmes embarqués, ECE Paris), généré avec [Typst](https://typst.app) et le package [Haita](https://typst.app/universe/package/haita).

- **Site en ligne** : https://ece-elec.github.io/typst-web/
- **Cours complet (PDF)** : https://ece-elec.github.io/typst-web/cours-complet.pdf

## Développement local

Nécessite `typst` (v0.15+) et `just`.

```bash
# Compiler le site web et le PDF dans dist/
just build

# Lancer un serveur local (http://localhost:8000)
just serve
```

## Structure

- `main.typ` : configuration du site et sommaire (Haita).
- `content/` : fichiers sources Typst des chapitres et des TP.
- `.github/workflows/deploy.yml` : compilation et déploiement automatique sur GitHub Pages.

## Licence

MIT — ECE Paris (Département Électronique).
