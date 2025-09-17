# Geometric Signal Processing for 3D Forest Point Clouds: Handheld SLAM–LiDAR Stem Modeling

> **Notice:** Our ICASSP manuscript is under review. We have released the full processing pipeline: terrain normalization, stem seeding, BEV cross-section fitting, piecewise cylindrical modeling, and feature extraction. We warmly invite reviewers and researchers to try the code, reproduce our metrics, and share feedback. The Western Australia *Pinus radiata* dataset (plots, annotations, splits) will be made publicly available upon publication.  

---

## Table of Contents
- [1. Introduction](#1-introduction)
- [2. Motivation and Background](#2-motivation-and-background)
- [3. System Overview](#3-system-overview)
- [4. Study Sites & Data Acquisition](#4-study-sites--data-acquisition)
- [5. Methodology](#5-methodology)
- [6. Experimental Design](#6-experimental-design)
- [7. Results and Performance](#7-results-and-performance)
  - [7.1 Representative Plot Statistics](#71-representative-plot-statistics)
  - [7.2 Accuracy & Robustness](#72-accuracy--robustness)
  - [7.3 Comparison with State-of-the-Art](#73-comparison-with-state-of-the-art)
- [8. Limitations & Future Work](#8-limitations--future-work)
- [9. Main Contributors](#9-main-contributors)
- [10. How to Cite](#10-how-to-cite)

---

## 1. Introduction

Reliable **stem measurements**—DBH, total height, stem length, taper curve, and axis lean/curvature—are key to forest inventory, growth modeling, and value recovery. Aerial and conventional terrestrial sensing often miss **near-ground geometry** in dense plantations due to occlusion, motion distortion, and terrain bias.

This repository implements a **handheld SLAM–LiDAR** pipeline that delivers **TLS-like DBH accuracy** with the mobility needed for plot-scale surveys. The system performs **convex terrain normalization (Huber + TV)**, **density-regularized stem seeding**, **constrained BEV algebraic circle fitting**, and **taper-aware piecewise cylindrical growth under a robust inlier–outlier likelihood** to reconstruct per-tree geometry end-to-end.

![Overview Diagram](./docs/Figures/Overview_Pipeline.png)

---

## 2. Motivation and Background

- **Inventory-critical variables**: DBH at 1.3 m, total height, taper \(r(z)\), stem length, lean & curvature.  
- **Why handheld SLAM–LiDAR?** Offers speed and coverage in dense stands where TLS is logistically heavy and UAV lacks basal cross-section fidelity.  
- **Key challenge**: Near-ground occlusions and terrain bias corrupt cross-section fitting and axis tracking.  
- **Our answer**: A geometry-aware, robust pipeline in terrain-normalized coordinates to stabilize cross-sections and stem growth across cluttered plots.

---

## 3. System Overview

The pipeline outputs **per-tree**:
- **DBH**, **total height**, **stem length**
- **Taper curve** \(r(z)\) (and optional smoothed \(\hat r(z)\))
- **Axis lean** (magnitude/azimuth) and **curvature** profile

Core building blocks:
1. **Voxel aggregation** (reduce anisotropy, keep stem detail)  
2. **Convex terrain fitting** with **Huber/TV** → **height normalization**  
3. **Density-regularized seeding** in a thin height band  
4. **BEV constrained algebraic circle fitting** (Taubin-style)  
5. **Piecewise cylindrical modeling** with **MLESAC** + **one-sided taper penalty**

---

## 4. Study Sites & Data Acquisition

We surveyed **40 fixed-area plots** in *Pinus radiata* plantations (Western Australia), spanning four age classes. A **Hovermap-class VLP-16** handheld unit was walked in concentric paths with loop closure; differential GNSS located plot centers. Near stems, point density exceeded \(5 \times 10^4\) pts/m\(^2\). Ground-truth includes **DBH & height** for all trees; **3 plots** underwent **destructive sampling** for section diameters/lengths, enabling full taper/flexure validation.

![Device & Field Setup](./docs/Figures/LiDAR_data.png)  

### Representative Plot Statistics

| Plot ID | Trees | Age (yr) | DBH Range (mm) | DBH Mean (mm) | Height Range (m) | Height Mean (m) | Points (M) | Density (pts/m²) | Scan Time (min) |
|---------|-------|----------|----------------|---------------|------------------|-----------------|------------|------------------|-----------------|
| 25      | 15    | 34       | 315–535        | 417.5         | 29.0–43.1        | 36.5            | 28.6       | 42,950           | 7               |
| 31      | 24    | 18       | 160–310        | 243.8         | 10.5–26.9        | 23.1            | 49.9       | 74,860           | 8               |
| 42      | 50    | 8        | 65–205         | 137.6         | 9.8–16.2         | 14.0            | 40.2       | 58,120           | 10              |

---

## 5. Methodology

### Signal Preprocessing
![Preprocessing](./docs/Figures/Data_Preprocessing.png)

- **Voxel aggregation** (2 cm)  
- **Ground surface fit**: convex Huber + TV regularization  
- **Height normalization**: \(\tilde z = z - g(x,y)\)

### Stem Extraction
![Stem Extraction Workflow](./docs/Figures/Stem_Extraction_pipeline.png)

- Density-regularized clustering in thin height band  
- BEV constrained algebraic circle fitting  
- Piecewise cylindrical fitting (MLESAC + taper penalty)

### Feature Computation
- **DBH**: at 1.3 m  
- **Height**: max normalized elevation  
- **Taper, Lean, Curvature**: derived from reconstructed axis

---

## 6. Experimental Design

- **Complexity levels**: Low, Medium, High (based on density, canopy closure, understory clutter)  
- **Metrics**: RMSE, rRMSE, MAE (DBH/Height/Stem length), flexure angles  
- Dataset includes **per-tree annotations**, **benchmark splits**, and **reconstructed outputs**

---

## 7. Results and Performance

### 7.2 Accuracy & Robustness

| Complexity Level | DBH (cm, gt/est; error) | Height (m, gt/est; error) | Stem Length (m, gt/est; error) | Flexure (°) max(θx/θy) |
|------------------|--------------------------|----------------------------|--------------------------------|-------------------------|
| Low              | 31.7 / 30.9 (0.8)       | 30.4 / 30.9 (0.5)          | 30.4 / 30.1 (0.3)              | 3.5 / 2.2              |
| Medium           | 30.3 / 31.4 (1.1)       | 26.1 / 26.8 (0.7)          | 26.9 / 26.2 (0.7)              | 3.6 / 2.3              |
| High             | 14.6 / 15.8 (1.2)       | 14.3 / 15.3 (1.0)          | 14.7 / 14.1 (0.6)              | 2.6 / 3.3              |
| **Avg (MAE)**    | **-- (1.0)**            | **-- (0.7)**               | **-- (0.5)**                   | --                      |
| **Avg (RMSE/rRMSE)** | **1.15 / 4.20%**    | **0.50 / 3.90%**           | --                             | --                      |

![Flexure Visualization](./docs/Figures/Tree_Stem_Flexure.png)

---

### 7.3 Comparison with State-of-the-Art

#### DBH Accuracy

| Study              | Platform | Species/Stand               | DBH RMSE / rRMSE |
|---------------------|----------|-----------------------------|------------------|
| Liu et al. (2018)   | TLS      | *Pinus yunnanensis*         | 1.17 / --        |
| Liu et al. (2018)   | TLS      | *Pinus densata*             | 1.28 / --        |
| Liu et al. (2018)   | TLS      | *Quercus semecarpifolia*    | 1.22 / 4.97%     |
| Feng et al. (2022)  | ULS      | Poplar (plant.)             | 2.10 / 12.44%    |
| Zhang et al. (2023) | ALS      | Chinese fir                 | 1.71 / 12.91%    |
| Gollob et al. (2021)| sLiDAR   | Mixed urban                 | 1.50 / 8.6%      |
| **Ours (2026)**     | HMLS     | *Pinus radiata*             | **1.15 / 4.20%** |

#### Height Accuracy

| Study              | Platform | Species/Stand               | Height RMSE / rRMSE |
|---------------------|----------|-----------------------------|---------------------|
| Liu et al. (2018)   | TLS      | *Pinus yunnanensis*         | 0.54 / --           |
| Liu et al. (2018)   | TLS      | *Pinus densata*             | 0.57 / 6.17%        |
| Corte et al. (2020) | ULS      | *Eucalyptus benthamii*      | 1.51 / 7.91%        |
| Ganz et al. (2019)  | ULS      | Douglas-fir stand           | 0.76 / --           |
| Ganz et al. (2019)  | ALS      | Mixed conifer               | 1.20 / --           |
| **Ours (2026)**     | HMLS     | *Pinus radiata*             | **0.50 / 3.90%**    |

---

## 8. Limitations & Future Work
...
