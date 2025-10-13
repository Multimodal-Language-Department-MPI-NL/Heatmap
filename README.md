# Gesture Heatmap Visualization

> Attribution: Cite: [OSF | Extracting Sign Language Articulation from Videos with MediaPipe](https://osf.io/x3pvq/) and [2023.nodalida-1.18.pdf](https://aclanthology.org/2023.nodalida-1.18.pdf)

Generate reproducible heatmaps from MediaPipe body landmark data to visualize gesture space usage patterns across participants.

## 🔬 Research Context

This module creates density-based heatmaps to visualize where participants place their hands during gestures, enabling comparative analysis of gesture space usage patterns. Based on Carl Börstell's work on sign language articulation extraction using MediaPipe.

## 🎯 What This Project Does

1. **Data Normalization**: Rescale hand coordinates relative to body landmarks for cross-participant comparison
2. **Density Estimation**: Calculate kernel density estimation for hand position data
3. **Heatmap Generation**: Create scatter plots with density-based color mapping
4. **Multi-participant Visualization**: Generate grid layouts for comparing multiple participants
5. **Publication-ready Figures**: Export high-quality plots for research publications

## 📊 Visualization Process

1. **Load Data**: Import MediaPipe body landmark CSV files
2. **Normalize Coordinates**: Rescale hand positions relative to shoulder width and body height
3. **Reshape Data**: Transform from wide to long format for analysis
4. **Calculate Density**: Apply Gaussian kernel density estimation
5. **Generate Plots**: Create heatmap visualizations with body reference overlays

## 🔧 Methods

### Data Normalization
- **Body-relative scaling**: Hand coordinates scaled by shoulder width and body height
- **Origin centering**: Coordinates centered on shoulder midpoint
- **Cross-participant consistency**: Enables comparison across different body sizes

### Density Estimation
- **Gaussian KDE**: Kernel density estimation for smooth density visualization
- **2D density mapping**: X-Y coordinate density calculation
- **Color mapping**: Viridis colormap for density visualization

### Visualization Features
- **Body reference overlays**: Ellipse and rectangle representing body silhouette
- **Grid layouts**: Multi-participant comparison plots
- **Equal aspect ratio**: Maintains spatial relationships
- **Customizable dimensions**: Configurable grid rows and columns

## 📁 Project Structure

```
Heatmap/
├── README.md
├── environment.yml
├── notebooks/
│   └── 01-heat_map_plot.ipynb
├── scripts/
│   └── heatmap.R                    # R script for publication figures
├── data/
│   └── processed/                   # MediaPipe body landmark CSVs
├── results/
│   └── figures/                     # Generated heatmap plots
└── src/
    └── heatmap/                     # Python package
```

## 🚀 Quick Start

### Prerequisites

```bash
conda env create -f environment.yml
conda activate heatmap
# Register Python and R kernels (once)
python -m ipykernel install --user --name heatmap --display-name "Python (heatmap)"
R -q -e 'IRkernel::installspec(name="R (heatmap)", displayname="R (heatmap)")'
```

### Run the Interactive Notebook

```bash
jupyter lab
# Open notebooks/01-heat_map_plot.ipynb
```

### Generate R Figures

```bash
Rscript scripts/heatmap.R
```


## 📈 Data Format

### Input
- **MediaPipe CSVs**: Body landmark time series with X, Y coordinates for nose, shoulders, and wrists
- **Required columns**: `X_LEFT_WRIST`, `Y_LEFT_WRIST`, `X_RIGHT_WRIST`, `Y_RIGHT_WRIST`, `X_LEFT_SHOULDER`, `Y_LEFT_SHOULDER`, `X_RIGHT_SHOULDER`, `Y_RIGHT_SHOULDER`, `X_NOSE`, `Y_NOSE`

### Output
- **PNG files**: Heatmap visualizations with density-based color mapping
- **Grid plots**: Multi-participant comparison layouts
- **Normalized coordinates**: Body-relative hand position data

## 🎛️ Configuration

### Visualization Parameters
- **Grid dimensions**: Number of rows and columns for multi-participant plots
- **Color mapping**: Density colormap selection (default: viridis)
- **Point size**: Scatter plot point size (default: 5)
- **Transparency**: Alpha value for density points (default: 0.7)

### Normalization Parameters
- **Y-axis scaling**: Vertical scaling factor (default: 0.6)
- **Coordinate bounds**: Plot axis limits (default: -2.5 to 2.5)

## 🔗 Related Projects

- `../MediaPipe_keypoints_extraction/`
- `../Smoothing/`
- `../Normalization/`
- `../Macneillian_Space_and_2D_Size/`

## 📖 References

- Börstell, C. (2023). Extracting Sign Language Articulation from Videos with MediaPipe. *Proceedings of the 24th Nordic Conference on Computational Linguistics (NoDaLiDa)*, 169–178. [https://aclanthology.org/2023.nodalida-1.18/](https://aclanthology.org/2023.nodalida-1.18/)
- Original OSF project: [https://osf.io/x3pvq/](https://osf.io/x3pvq/)

## 🤝 Contributing

This project is part of the MPI Multimodal Interaction Research framework. For questions or contributions, please refer to the main project documentation.

## 📄 License

This project is part of the MPI research framework. Please refer to the main project license for usage terms.