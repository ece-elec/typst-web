# ⚡ Typst Web • Systèmes Embarqués & Traitement du Signal (ECE)

[![Deploy Typst Web (Haita) to GitHub Pages](https://github.com/ece-elec/typst-web/actions/workflows/deploy.yml/badge.svg)](https://github.com/ece-elec/typst-web/actions/workflows/deploy.yml)
[![GitHub Pages](https://img.shields.io/badge/Site-GitHub%20Pages-239dad?logo=github)](https://ece-elec.github.io/typst-web/)
[![Typst Universe - Haita](https://img.shields.io/badge/Typst%20Universe-haita%20v0.4.0-2f90ba?logo=typst)](https://typst.app/universe/package/haita)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

Site de cours et travaux pratiques en ligne déployé automatiquement sur **GitHub Pages** :
👉 **[Accéder au site en ligne](https://ece-elec.github.io/typst-web/)**

---

## 🎯 Présentation

Ce dépôt démontre la puissance du moteur de publication web de **Typst** via le package officiel [**Haita**](https://typst.app/universe/package/haita) (export multi-pages `--format bundle`).

Il propose un support de cours complet d'ingénierie (niveau ING5 ECE Paris) combinant :
- **Théorie du traitement du signal** : formules mathématiques vectorielles en **MathML natif** (sans KaTeX ni MathJax).
- **Travaux Pratiques (Labs)** : protocoles d'expérimentation et code firmware C (ARM Cortex-M4F / STM32 HAL).
- **Double export automatique** : le site web multi-pages et le livre PDF complet sont générés depuis les mêmes fichiers sources Typst.

---

## 📚 Structure Pédagogique

```text
typst-web/
├── main.typ                          # Fichier maître définissant l'arborescence du site (Haita)
├── content/
│   ├── index.typ                     # Page d'accueil & objectifs pédagogiques
│   ├── ch1-echantillonnage.typ       # Chapitre 1 : Échantillonnage & Théorème de Shannon
│   ├── ch2-fourier.typ               # Chapitre 2 : Transformée de Fourier Discrète & FFT
│   ├── ch3-filtrage.typ              # Chapitre 3 : Filtres Numériques RIF & RII
│   ├── lab1-oscilloscope.typ         # Lab 1 : Instrumentation numérique & banc de mesure
│   ├── lab2-filtre-stm32.typ         # Lab 2 : Filtre passe-bas temps réel sur STM32
│   └── ressources.typ                # Ressources, gabarit @preview/electrocentrale
├── .github/
│   └── workflows/
│       └── deploy.yml                # Déploiement automatique sur GitHub Pages
├── justfile                          # Commandes pratiques (build, serve, watch)
└── README.md
```

---

## 🚀 Utilisation Locale

### Prérequis
- [Typst](https://typst.app/) (version 0.15 ou supérieure).
- [just](https://github.com/casey/just) *(optionnel mais recommandé)*.

### Commandes

```bash
# Compiler le site web multi-pages et le PDF dans le dossier dist/
just build

# Lancer un serveur local de prévisualisation (http://localhost:8000)
just serve

# Mode watch : recompilation continue à chaque sauvegarde
just watch
```

Ou directement avec la CLI Typst :
```bash
typst compile --features bundle,html --format bundle main.typ dist
```

---

## ⚙️ Déploiement Continu (CI/CD)

Le workflow [`.github/workflows/deploy.yml`](.github/workflows/deploy.yml) compile le site à chaque `git push` sur la branche `main` et déploie le dossier `dist/` sur **GitHub Pages**.

---

## 📄 Licence

Ce projet est sous licence [MIT](LICENSE).
Propulsé par le département Électronique & Systèmes Embarqués de l'**ECE Paris**.
