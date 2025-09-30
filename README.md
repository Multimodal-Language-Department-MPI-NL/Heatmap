# Heatmap
Description: Reproducible pipeline to plot gesture heatmaps from processed body landmark CSVs. Includes R script for publication figures and a notebook for exploration. Topics: gesture, mediapipe, heatmap, visualization, r, python, time-series


# Install conda environment 

```bash
conda env create -f environment.yml
conda activate heatmap
# register Python and R kernels (once)
python -m ipykernel install --user --name heatmap --display-name "Python (heatmap)"
R -q -e 'IRkernel::installspec(name="R (heatmap)", displayname="R (heatmap)")'
jupyter lab
```

# Heatmap

Reproducible heatmaps from body landmark CSVs.

## Setup
conda env create -f environment.yml
conda activate heatmap

## Data
Place CSV files in `data/processed/`:
- 1130_JS_body.csv
- 1349_HS_body.csv
- 5014_RS_body.csv
- 5137_JJ_body.csv

## Usage
# R figures
Rscript scripts/heatmap.R

# Notebook
jupyter lab
open `notebooks/01-heat_map_plot.ipynb`

## Outputs
Figures are written to `results/figures/`.