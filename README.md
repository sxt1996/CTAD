# CTAD
open source codes of paper:《Hyperspectral Anomaly Detection Based on Chessboard Topology》

DOI: 10.1109/TGRS.2023.3249748
# Abstract
Without any prior information, hyperspectral anomaly detection is devoted to locating targets of interest within a specific scene by exploiting differences in spectral characteristics between various land covers. Traditional methods originated from the signal processing perspective, and most of them rely heavily on specific model assumptions. Due to the model-driven attributes, such methods cannot mine the deep-level features of data to adapt to the variability of scenes, and cannot fully extract the information of land covers contained in images to accurately separate anomalies from background. By independently designing a chessboard-shaped topological framework that avoids making any distribution assumptions but directly mines high-dimensional data features to break through the limitations of traditional detectors, this paper proposes a novel chessboard topology-based anomaly detection (CTAD) method, which constructs a chessboard-shaped topology to dissect images and extract detailed information of land covers adaptively, thereby enabling highly accurate detection. Extensive experimental results on HSIs in real scenes demonstrate that the proposed CTAD can be adapted to the variability of scenes by autonomously learning data features, and exhibits strong generalization and detection capabilities, facilitating practical applications.
# Index Terms
Hyperspectral image, anomaly detection, data mining, topology, machine learning.
# Flowchart
![FlowChart](https://github.com/sxt1996/CTAD/assets/55687887/133ea36d-909e-4858-805a-8019c0883ec9)
# Data Set
AVIRIS-WTC: The data set was acquired on September 16, 2001 by NASA's Jet Propulsion Laboratory using the AVIRIS to image the World Trade Center (WTC) in New York. The experimental image preserves 224 spectral channels spanning the wavelength range of 370-2510 nm. This scene contains 200×200 pixels, of which the anomalies to be detected are fire sources, occupying 83 pixels in a total of 10 locations. 
# Guidelines
1. Install R2014a or higher versions of MATLAB.
2. Download this code package.
3. Set path.
4. Don't worry about importing data or anything else, just run Main.m.
# Contact
If you have any questions, please feel free to contact me.
sxt1996@outlook.com
