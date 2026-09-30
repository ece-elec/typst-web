#title[Chapitre 1 : Échantillonnage & Théorème de Shannon]

La conversion d'un signal analogique continu $x(t)$ vers le domaine discret $x[n]$ est le fondement de tout système de traitement numérique du signal (DSP).

= 1. Le Processus d'Échantillonnage

Mathématiquement, l'échantillonnage idéal par un peigne de Dirac à la période d'échantillonnage $T_e = 1 / f_e$ s'écrit :

$ x_e (t) = x(t) dot sum_(n = -infinity)^(+infinity) delta(t - n T_e) $

Dans le domaine fréquentiel, cela induit une périodisation du spectre continu $X(f)$ :

$ X_e (f) = f_e sum_(k = -infinity)^(+infinity) X(f - k f_e) $

= 2. Théorème de Shannon-Nyquist

Pour éviter tout phénomène de *repliement de spectre* (_aliasing_), la fréquence d'échantillonnage $f_e$ doit être strictement supérieure au double de la fréquence maximale $f_max$ contenue dans le signal utile :

$ f_e > 2 f_max $

La fréquence $f_N = f_e / 2$ est appelée *fréquence de Nyquist*.

== Conséquence pratique : le filtre anti-repliement

En amont de tout convertisseur analogique-numérique (CAN / ADC), il est impératif d'insérer un filtre passe-bas analogique passif ou actif pour atténuer toutes les fréquences situées au-delà de $f_e / 2$.

= 3. Quantification & Bruit de Quantification

La quantification convertit l'amplitude continue en une valeur finie codée sur $N$ bits. Le pas de quantification (quantum) $q$ pour une plage pleine échelle $V_("ref")$ est :

$ q = V_("ref") / (2^N) $

En supposant une distribution uniforme de l'erreur de quantification sur $[-q/2, +q/2]$, la puissance du bruit de quantification vaut :

$ P_b = q^2 / 12 $

Le rapport signal sur bruit maximal théorique (SNR) pour un signal sinusoïdal pleine échelle s'obtient par la formule classique :

$ "SNR"_(d B) approx 6.02 dot N + 1.76 "dB" $

#table(
  columns: (1fr, 1fr, 2fr),
  [Résolution $N$], [Pas $q$ ($V_("ref") = 3.3"V"$)], [SNR théorique],
  [8 bits], [12.89 mV], [49.92 dB],
  [10 bits], [3.22 mV], [61.96 dB],
  [12 bits (ADC STM32)], [0.806 mV], [74.00 dB],
  [16 bits (Audio)], [50.35 µV], [98.08 dB],
)
