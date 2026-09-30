#title[Chapitre 2 : Transformée de Fourier Discrète & FFT]

L'analyse spectrale des signaux discrets repose sur la *Transformée de Fourier Discrète (TFD)* et son implémentation algorithmique optimisée, la *FFT* (_Fast Fourier Transform_).

= 1. Définition de la TFD

Pour un signal de $N$ échantillons discrets $x[n] = [x_0, x_1, dots, x_(N-1)]$, la composante spectrale complexe $X[k]$ à l'indice fréquentiel $k$ est définie par :

$ X[k] = sum_(n=0)^(N-1) x[n] dot e^(-j (2 pi) / N k n) quad "pour" k in {0, 1, dots, N-1} $

En notant le facteur de rotation (_twiddle factor_) $W_N = e^(-j (2 pi) / N)$, l'expression se simplifie en :

$ X[k] = sum_(n=0)^(N-1) x[n] dot W_N^(k n) $

= 2. Résolution Fréquentielle

Chaque raie fréquentielle $k$ correspond à la fréquence physique :

$ f_k = k dot (f_e) / N $

La résolution fréquentielle minimale discernable vaut ainsi :

$ Delta f = f_e / N = 1 / T_("obs") $

où $T_("obs") = N dot T_e$ est la durée totale d'observation du signal.

= 3. L'Algorithme FFT (Cooley-Tukey)

Le calcul direct de la TFD nécessite $N^2$ multiplications complexes. L'algorithme de Cooley-Tukey (à base 2) décompose récursivement la somme entre indices pairs et impairs :

$ X[k] = X_("pair")[k] + W_N^k dot X_("impair")[k] $

#table(
  columns: (1fr, 1.5fr, 1.5fr, 1.5fr),
  [Nombre d'échantillons $N$], [Opérations DFT ($N^2$)], [Opérations FFT ($N/2 log_2 N$)], [Gain de vitesse],
  [64], [4 096], [192], [~21x],
  [256], [65 536], [1 024], [~64x],
  [1 024], [1 048 576], [5 120], [~205x],
  [4 096], [16 777 216], [24 576], [~682x],
)

= 4. Fenêtrage Temporel (_Windowing_)

Tronquer un signal de manière finie équivaut à le multiplier par une fenêtre rectangulaire, ce qui provoque des fuites spectrales (_spectral leakage_). Pour atténuer les lobes secondaires, on applique des fenêtres pondérées :

- *Hann (Hanning)* : $w[n] = 0.5 - 0.5 cos((2 pi n) / (N-1))$ — excellent compromis général.
- *Hamming* : $w[n] = 0.54 - 0.46 cos((2 pi n) / (N-1))$ — atténuation de 43 dB du premier lobe secondaire.
- *Blackman* : atténuation supérieure à 58 dB, idéal pour la détection de signaux de faibles amplitudes proches de raies intenses.
