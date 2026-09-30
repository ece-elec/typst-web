#title[Chapitre 3 : Filtres Numériques (RIF & RII)]

Les filtres numériques permettent de modifier le contenu spectral d'une séquence d'échantillons avec une précision et une répétabilité impossibles à atteindre avec des composants analogiques.

= 1. Équation aux Différences Générale

La relation temporelle entre l'entrée $x[n]$ et la sortie $y[n]$ d'un filtre linéaire invariant dans le temps (LTI) d'ordre $M$ et $N$ s'écrit :

$ y[n] = sum_(k=0)^M b_k dot x[n-k] - sum_(k=1)^N a_k dot y[n-k] $

Dans le domaine de la transformée en $Z$, la fonction de transfert $H(z)$ s'exprime comme le quotient de deux polynômes :

$ H(z) = (Y(z)) / (X(z)) = (sum_(k=0)^M b_k z^(-k)) / (1 + sum_(k=1)^N a_k z^(-k)) $

= 2. RIF vs RII : Comparaison d'Architecture

#table(
  columns: (2fr, 2.5fr, 2.5fr),
  [Critère], [Filtre RIF (FIR)], [Filtre RII (IIR)],
  [Coefficients], [$a_k = 0$ pour $k >= 1$ (non-récursif)], [Coefficients $a_k$ non nuls (récursif)],
  [Stabilité], [*Toujours inconditionnellement stable* (zéros uniquement)], [Instabilité possible (pôles à vérifier)],
  [Phase], [*Phase strictement linéaire* possible (zéro distorsion de groupe)], [Phase non linéaire],
  [Ordre requis], [Élevé pour une coupure raide (ex. 64 à 256 taps)], [Faible (ordre 2 à 8)],
  [Complexité calculatoire], [Nombre important de multiplications-accumulations (MAC)], [Très économe en cycles CPU],
)

= 3. Condition de Stabilité pour les Filtres RII

Pour qu'un filtre RII soit causal et stable (au sens BIBO — _Bounded-Input, Bounded-Output_), l'ensemble de ses pôles $p_i$ (racines du dénominateur $A(z)$) doivent être strictement situés à l'intérieur du cercle unité dans le plan complexe $z$ :

$ |p_i| < 1 quad forall i in {1, dots, N} $

= 4. Implémentation Algorithmique en C (Filtre RIF)

Voici la boucle de calcul Direct Form d'un filtre RIF à $M$ coefficients optimisée pour microcontrôleur :

```c
#define NUM_TAPS 16

float fir_process(float input, const float *coeffs, float *buffer, uint16_t *idx) {
    buffer[*idx] = input;
    float output = 0.0f;
    uint16_t pos = *idx;

    for (uint16_t k = 0; k < NUM_TAPS; k++) {
        output += coeffs[k] * buffer[pos];
        if (pos == 0) pos = NUM_TAPS - 1;
        else pos--;
    }

    *idx = (*idx + 1) % NUM_TAPS;
    return output;
}
```
