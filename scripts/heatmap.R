### Gesture heat map scatterplot
### Sharice Clough
### 10 April, 2024

# Adapted from Carl Börstell's OSF project: Extracting Sign Language Articulation from Videos with MediaPipe (https://osf.io/x3pvq/)
# Börstell, Carl. 2023. Extracting Sign Language Articulation from Videos with MediaPipe. 
# In Proceedings of the 24th Nordic Conference on Computational Linguistics (NoDaLiDa) (NEALT Proceedings Series, No. 52), 
# 169–178. Tórshavn, Faroe Islands: University of Tartu Library. https://aclanthology.org/2023.nodalida-1.18/


#install any packages you don't already have installed in R
#install.packages(c("dplyr", "ggplot2", "ggpointdensity", "viridis", "ggforce"))

# Load necessary libraries
library(dplyr)      # for data manipulation
library(tidyr)      # for data reshaping
library(ggplot2)    # for plotting
library(ggpointdensity)  # for point density plot
library(viridis)    # for color palette
library(ggforce)    # for drawing shapes

# Set working directory
# Change to source file location
#setwd("~/Downloads/heatmap_tutorial")

# Read in media pipe motion tracking files
files <- list.files(pattern = "\\.csv$")

# Initialize an empty list to store rescaled data frames
rescaled_data_list <- list()

# Rescale the motion tracking data
for (file in files) {
  # Read in each data file
  mt <- read.csv(file) 
  
  # Rescale the data
  mt_rescaled <- mt %>%
    mutate(
      # Calculate body width
      width = mean(X_LEFT_SHOULDER) - mean(X_RIGHT_SHOULDER),
      # Calculate x-coordinate for the origin
      x_origo = mean(X_RIGHT_SHOULDER) + (mean(X_LEFT_SHOULDER) - mean(X_RIGHT_SHOULDER)) / 2,
      # Calculate y-coordinate for the origin
      y_origo = mean(c(Y_LEFT_SHOULDER, Y_RIGHT_SHOULDER)),
      # Calculate body height
      height = mean(Y_NOSE) - y_origo,
      # Define scaling factors for x and y
      x_factor = 1 / width,
      y_factor = .6 / height,
      # Apply transformations to x coordinates
      X_NOSE = (X_NOSE - x_origo) * x_factor,
      X_LEFT_SHOULDER = (X_LEFT_SHOULDER - x_origo) * x_factor,
      X_RIGHT_SHOULDER = (X_RIGHT_SHOULDER - x_origo) * x_factor,
      X_LEFT_WRIST = (X_LEFT_WRIST - x_origo) * x_factor,
      X_RIGHT_WRIST = (X_RIGHT_WRIST - x_origo) * x_factor,
      # Apply transformations to y coordinates
      Y_NOSE = (Y_NOSE - y_origo) * y_factor,
      Y_LEFT_SHOULDER = (Y_LEFT_SHOULDER - y_origo) * y_factor,
      Y_RIGHT_SHOULDER = (Y_RIGHT_SHOULDER - y_origo) * y_factor,
      Y_LEFT_WRIST = (Y_LEFT_WRIST - y_origo) * y_factor,
      Y_RIGHT_WRIST = (Y_RIGHT_WRIST - y_origo) * y_factor,
      # Add file name as a new column
      file_name = file
    )
  
  # Store the rescaled data frame in the list
  rescaled_data_list[[file]] <- mt_rescaled
}

# Combine all rescaled data frames into a single data frame
all_rescaled_data <- dplyr::bind_rows(rescaled_data_list)

# Extract subject ID information from File name
# You will need to customize this code for the format of your own file names
#all_rescaled_data$SubjectID <- substr(all_rescaled_data$file_name, 1, 4)  # Extract subject ID (first four characters of file name)
#all_rescaled_data$SubjectID <- as.factor(all_rescaled_data$SubjectID)     # Convert to factor

# Reshape data from wide to long format
all_rescaled_data <- all_rescaled_data %>%
  select(file_name, X_LEFT_WRIST, Y_LEFT_WRIST, X_RIGHT_WRIST, Y_RIGHT_WRIST, time) %>%
  pivot_longer(cols = 2:5, names_to = "keypoint", values_to = "coordinate") %>%
  mutate(
    hand = ifelse(grepl("LEFT", keypoint), "LEFT", "RIGHT"),
    axis = ifelse(grepl("^X", keypoint), "x_axis", "y_axis")
  ) %>%
  select(-keypoint)

# Reshape data from long to wide format
all_rescaled_data <- all_rescaled_data %>%
  pivot_wider(names_from = axis, values_from = coordinate)

# Create the plot
ggplot(all_rescaled_data, aes(x = x_axis, y = y_axis)) +
  geom_ellipse(aes(x0 = 0, y0 = .6, a = 3/5/2, b = 4/5/2, angle = 0), fill = "grey50", color = NA) +
  geom_rect(aes(xmin = -.5, xmax = .5, ymin = -1.4, ymax = 0), fill = "grey50", color = NA) +
  geom_pointdensity(size = .5, alpha = .2) +
  scale_color_viridis()+
  labs(y = "", x = "") +
  xlim(c(-2.5, 2.5)) +
  ylim(c(-2.5, 2.5)) +
  facet_wrap(~file_name) +
  theme_bw(base_size = 14)

# Save the plot
ggsave("heatmap_plot.png", width = 7, height = 5)
