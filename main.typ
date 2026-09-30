#!/usr/bin/env -S typst compile --features bundle,html --format bundle
#import "@preview/haita:0.4.0": *

#book(
  base-url: "https://ece-elec.github.io/typst-web",
  title: "Systèmes Embarqués & Traitement du Signal • ECE",
  html-renderer: new-hamber.html-renderer,
  tree: (
    // Introduction
    [= Présentation Générale],
    chapter("index", content: include "content/index.typ"),

    // Partie I : Cours
    divider(),
    [= Partie I : Traitement du Signal],
    chapter("cours/ch1-echantillonnage", content: include "content/ch1-echantillonnage.typ"),
    chapter("cours/ch2-fourier", content: include "content/ch2-fourier.typ"),
    chapter("cours/ch3-filtrage", content: include "content/ch3-filtrage.typ"),

    // Partie II : Travaux Pratiques / Labs
    divider(),
    [= Partie II : Travaux Pratiques (Labs)],
    chapter("labs/lab1-oscilloscope", content: include "content/lab1-oscilloscope.typ"),
    chapter("labs/lab2-filtre-stm32", content: include "content/lab2-filtre-stm32.typ"),

    // Ressources
    divider(),
    [= Annexes & Outils],
    chapter("ressources", content: include "content/ressources.typ"),
  ),
)
