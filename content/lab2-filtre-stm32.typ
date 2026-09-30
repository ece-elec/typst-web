#title[Lab 2 : Filtre Numérique Temps Réel sur STM32]

Dans ce travail pratique, nous concevons et déployons un filtre passe-bas numérique temps réel sur cible microcontrôleur *STM32 (ARM Cortex-M4F)* à l'aide des bibliothèques CMSIS-DSP.

= 1. Architecture Matérielle

La chaîne d'acquisition et de restitution fonctionne sans intervention continue du processeur grâce aux contrôleurs DMA :

1. *Timer 2 (TIM2)* : Cadence les conversions de l'ADC à une fréquence stable $f_e = 40 "kHz"$ sans gigue logicielle (_jitter_).
2. *ADC1 (12 bits)* : Échantillonne le signal analogique injecté sur la broche `PA0`.
3. *DMA2 Stream 0* : Transfère les échantillons vers un double-tampon (_ping-pong buffer_) en mémoire SRAM.
4. *Calcul du filtre (CMSIS-DSP)* : Traitement par bloc exécuté lors des interruptions `HalfTransfer` et `TransferComplete`.
5. *DAC1 (12 bits)* : Restitue le signal filtré sur la broche `PA4`.

= 2. Code du Firmware (C / STM32 HAL)

```c
#include "stm32f4xx_hal.h"
#include "arm_math.h"

#define BUFFER_SIZE     128
#define NUM_TAPS        29

// Buffers DMA circulaires
uint16_t adc_buffer[BUFFER_SIZE];
uint16_t dac_buffer[BUFFER_SIZE];

// Instance du filtre RIF CMSIS-DSP
arm_fir_instance_f32 S;
float32_t fir_state[NUM_TAPS + (BUFFER_SIZE / 2) - 1];

// Coefficients passe-bas (fc = 4 kHz, fe = 40 kHz)
const float32_t fir_coeffs[NUM_TAPS] = {
    -0.0014f, -0.0028f, -0.0035f,  0.0000f,  0.0102f,
     0.0264f,  0.0435f,  0.0538f,  0.0489f,  0.0238f,
    -0.0185f, -0.0652f, -0.0967f, -0.0950f, -0.0504f,
     0.0385f,  0.1558f,  0.2796f,  0.3845f,  0.4462f,
     0.4462f,  0.3845f,  0.2796f,  0.1558f,  0.0385f,
    -0.0504f, -0.0950f, -0.0967f, -0.0652f
};

void process_block(uint16_t *src, uint16_t *dst, uint16_t len) {
    float32_t in_f32[BUFFER_SIZE / 2];
    float32_t out_f32[BUFFER_SIZE / 2];

    // Conversion uint16 -> float32
    for (int i = 0; i < len; i++) {
        in_f32[i] = (float32_t)src[i];
    }

    // Filtrage vectoriel avec FPU matériel
    arm_fir_f32(&S, in_f32, out_f32, len);

    // Reconversion float32 -> uint16 pour le DAC
    for (int i = 0; i < len; i++) {
        dst[i] = (uint16_t)out_f32[i];
    }
}

// Callback mi-transfert DMA
void HAL_ADC_ConvHalfCpltCallback(ADC_HandleTypeDef* hadc) {
    process_block(&adc_buffer[0], &dac_buffer[0], BUFFER_SIZE / 2);
}

// Callback transfert complet DMA
void HAL_ADC_ConvCpltCallback(ADC_HandleTypeDef* hadc) {
    process_block(&adc_buffer[BUFFER_SIZE / 2], &dac_buffer[BUFFER_SIZE / 2], BUFFER_SIZE / 2);
}
```

= 3. Validation au Laboratoire

À l'aide d'un balayage en fréquence sinusoïdal de 500 Hz à 20 kHz sur le GBF :

- Vérifier que l'amplitude reste constante jusqu'à la fréquence de coupure $f_c = 4 "kHz"$.
- Mesurer l'atténuation à $f = 8 "kHz"$ (supérieure à $-35 "dB"$).
- Relever le temps de traitement de l'algorithme via une broche de debug basculée à l'état haut en début d'interruption : le calcul doit s'exécuter en moins de $150 "µs"$ pour respecter la contrainte de temps réel.
