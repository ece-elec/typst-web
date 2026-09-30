#title[Ressources & Outils Pédagogiques]

Retrouvez ici les références, outils logiciels et gabarits officiels recommandés pour la rédaction de vos livrables.

= Rédaction des Comptes-Rendus de TP

Pour rédiger vos rapports de travaux pratiques et de projet à l'ECE, utilisez le package officiel disponible sur #link("https://typst.app/universe/package/electrocentrale")[Typst Universe] :

== Initialisation en 1 ligne (CLI Typst)

```bash
typst init @preview/electrocentrale mon-rapport-tp
cd mon-rapport-tp
typst watch main.typ
```

== Import direct dans un document Typst ou sur l'application Web

```typst
#import "@preview/electrocentrale:0.1.0": *

#show: tp.with(
  title: "Traitement du Signal Numérique",
  tp-num: "2",
  promo: "ING5",
  major: "Systèmes Embarqués",
  authors: ("André-Marie AMPÈRE", "Alessandro VOLTA"),
)
```

= Outils Logiciels & Bibliothèques

- *STM32CubeIDE* : Environnement officiel STMicroelectronics pour le développement firmware et la configuration des périphériques.
- *ARM CMSIS-DSP* : Bibliothèque de traitement du signal optimisée pour ARM Cortex-M (`arm_fir_f32`, `arm_rfft_fast_f32`).
- *Python (NumPy / SciPy / Matplotlib)* : Pour le calcul des coefficients de filtrage (`scipy.signal.firwin`).
- *Typst* : Compilateur de documents moderne et ultra-rapide (#link("https://typst.app")[typst.app]).

= Liens Utiles

- #link("https://github.com/ece-elec/Electrocentrale")[Dépôt GitHub ece-elec/Electrocentrale] — Code source et gabarits officiels ECE.
- #link("https://typst.app/docs/")[Documentation Officielle Typst] — Syntaxe et référence standard.
- #link("https://github.com/ece-elec/typst-web")[Code source de ce site (ece-elec/typst-web)] — Dépôt de ce support de cours.
