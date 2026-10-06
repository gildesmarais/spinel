## r1

| benchmark | loops versioned | n | base median ms (IQR) | head median ms (IQR) | head/base | MWU p | verdict |
| --- | --: | --: | --: | --: | --: | --: | --- |
| bm_matmul | 2 | 30/30 | 8.58 (0.14) | 3.12 (0.09) | 0.364 | 2.9e-11 | FASTER (outside noise) |
| bm_spectral_norm | 1 | 30/30 | 3.36 (0.09) | 3.36 (0.12) | 1.000 | 0.5 | within noise |
| bm_huffman | 1 | 30/30 | 7.07 (0.27) | 7.04 (0.22) | 0.996 | 0.33 | within noise |

1 of 3 outside the noise

## r2

| benchmark | loops versioned | n | base median ms (IQR) | head median ms (IQR) | head/base | MWU p | verdict |
| --- | --: | --: | --: | --: | --: | --: | --- |
| bm_matmul | 2 | 30/30 | 8.59 (0.28) | 3.16 (0.31) | 0.368 | 2.9e-11 | FASTER (outside noise) |
| bm_spectral_norm | 1 | 30/30 | 3.38 (0.15) | 3.37 (0.11) | 0.997 | 0.85 | within noise |
| bm_huffman | 1 | 30/30 | 7.04 (0.09) | 7.04 (0.12) | 1.000 | 0.98 | within noise |

1 of 3 outside the noise

## void attempts

### r1-void1

| benchmark | loops versioned | n | base median ms (IQR) | head median ms (IQR) | head/base | MWU p | verdict |
| --- | --: | --: | --: | --: | --: | --: | --- |
| bm_matmul | 2 | 30/30 | 8.55 (0.11) | 3.09 (0.07) | 0.362 | 2.9e-11 | FASTER (outside noise) |
| bm_spectral_norm | 1 | 30/30 | 3.28 (0.07) | 3.30 (0.12) | 1.006 | 0.97 | within noise |
| bm_huffman | 1 | 30/30 | 6.98 (0.20) | 6.96 (0.17) | 0.998 | 0.89 | within noise |

1 of 3 outside the noise

### r1-void2

| benchmark | loops versioned | n | base median ms (IQR) | head median ms (IQR) | head/base | MWU p | verdict |
| --- | --: | --: | --: | --: | --: | --: | --- |
| bm_matmul | 2 | 30/30 | 9.83 (0.46) | 3.84 (0.41) | 0.390 | 2.9e-11 | FASTER (outside noise) |
| bm_spectral_norm | 1 | 30/30 | 3.49 (0.46) | 3.50 (0.43) | 1.005 | 0.99 | within noise |
| bm_huffman | 1 | 30/30 | 7.63 (0.77) | 7.81 (0.83) | 1.024 | 0.35 | within noise |

1 of 3 outside the noise

### r1-void3

| benchmark | loops versioned | n | base median ms (IQR) | head median ms (IQR) | head/base | MWU p | verdict |
| --- | --: | --: | --: | --: | --: | --: | --- |
| bm_matmul | 2 | 30/30 | 8.57 (0.17) | 3.10 (0.15) | 0.362 | 2.9e-11 | FASTER (outside noise) |
| bm_spectral_norm | 1 | 30/30 | 3.30 (0.09) | 3.27 (0.07) | 0.990 | 0.042 | within noise |
| bm_huffman | 1 | 30/30 | 6.96 (0.13) | 6.96 (0.11) | 0.999 | 0.77 | within noise |

1 of 3 outside the noise

### r2-void1

| benchmark | loops versioned | n | base median ms (IQR) | head median ms (IQR) | head/base | MWU p | verdict |
| --- | --: | --: | --: | --: | --: | --: | --- |
| bm_matmul | 2 | 30/30 | 8.60 (0.15) | 3.13 (0.15) | 0.365 | 2.9e-11 | FASTER (outside noise) |
| bm_spectral_norm | 1 | 30/30 | 3.33 (0.11) | 3.34 (0.09) | 1.003 | 0.59 | within noise |
| bm_huffman | 1 | 30/30 | 7.06 (0.10) | 7.07 (0.13) | 1.002 | 0.65 | within noise |

1 of 3 outside the noise

### r2-void2

| benchmark | loops versioned | n | base median ms (IQR) | head median ms (IQR) | head/base | MWU p | verdict |
| --- | --: | --: | --: | --: | --: | --: | --- |
| bm_matmul | 2 | 30/30 | 8.55 (0.12) | 3.10 (0.08) | 0.363 | 2.9e-11 | FASTER (outside noise) |
| bm_spectral_norm | 1 | 30/30 | 3.26 (0.11) | 3.26 (0.12) | 0.999 | 0.61 | within noise |
| bm_huffman | 1 | 30/30 | 6.92 (0.26) | 6.93 (0.14) | 1.001 | 0.63 | within noise |

1 of 3 outside the noise

## optcarrot

optcarrot fps: base median 1946.4 (IQR 22.8, n 20), head median 1937.8 (IQR 36.1, n 20), head/base 0.996, MWU p 0.19, within noise
