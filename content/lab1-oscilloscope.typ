#title[Lab 1 : Instrumentation Numérique & Banc de Mesure]

Ce premier travail pratique vise à maîtriser les équipements de laboratoire essentiels pour valider les cartes électroniques et caractériser les signaux numériques.

= 1. Matériel Utilisé

- *Oscilloscope numérique à mémoire* (Keysight InfiniiVision 1000 X ou Rohde & Schwarz RTB2000, 100 MHz, 2 Géch/s).
- *Générateur de fonctions arbitraires (GBF)*.
- *Sonde passive 10:1* calibrée (compensation capacitive vérifiée sur mire 1 kHz).

= 2. Manipulations & Mesures Pratiques

== 2.1 Compensation de la Sonde de Mesure

Avant toute mesure haute fréquence, la sonde 10:1 doit être ajustée à l'aide de la vis de compensation sur la sortie de test carrée (1 kHz, 2.5 Vcc) de l'oscilloscope :

- *Sous-compensée* : fronts arrondis (atténuation des hautes fréquences).
- *Sur-compensée* : dépassements et suroscillations artificiels (_overshoot_).
- *Correctement compensée* : créneau parfaitement plat et rectangulaire.

== 2.2 Analyse Spectrale FFT sur Oscilloscope

1. Connecter le GBF à la voie 1 de l'oscilloscope.
2. Configurer un signal sinusoïdal d'amplitude 2 Vcc à la fréquence $f_0 = 10 "kHz"$.
3. Activer la fonction mathématique *FFT* :
   - Fenêtre de pondération : *Hanning*.
   - Échelle verticale : *dBV* ou *dBm*.
   - Plage de fréquence : $0 "à" 100 "kHz"$.
4. Relever l'amplitude de la raie fondamentale et mesurer le taux de distorsion harmonique (THD) :

$ "THD" = (sqrt(sum_(k=2)^infinity V_k^2)) / V_1 $

== 2.3 Échantillonnage & Aliasing Expérimental

En réduisant intentionnellement la base de temps de l'oscilloscope pour forcer une cadence d'échantillonnage inférieure à la fréquence de Nyquist du signal injecté ($f_e < 2 f_0$), observer l'apparition d'un alias basse fréquence à :

$ f_("alias") = |f_0 - k dot f_e| $

Ce phénomène démontre la nécessité physique absolue du filtre analogique anti-repliement.
