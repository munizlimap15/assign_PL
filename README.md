# Assignment

## Visualizations

### Global Production Volume
![Global Production Volume](ggViz.png)

### Nitrogen Output in Harvested Wheat Yield
![Nitrogen Output](nitrogen_output.tif)

### Nitrogen Outputs X Losses for the Top Ten Wheat Producers
![Nitrogen Outputs X Losses](N_outputs_losses.png)

### TASK 4...
Among the top wheat producers, China leads in nitrogen productivity but with a low nitrogen use efficiency (NUE) of 0.26, suggesting higher potential for environmental loss. In contrast, France shows a balance between high productivity and a higher NUE of 0.74, indicating more sustainable nitrogen usage. The efficiency spectrum is broad, with countries like Kazakhstan and the Republic of Moldova achieving high NUE, while the United Arab Emirates and Kuwait are at the lower end.
| Rank | Country                | Production (Mt) | NUE    | N Output | N Input  | N Loss  |
|------|------------------------|-----------------|--------|----------|----------|---------|
| 1    | China                  | 63.39           | 0.262  | 1.268    | 4.832    | 3.565   |
| 2    | United States of America | 49.03         | 0.508  | 0.981    | 1.930    | 0.950   |
| 3    | India                  | 46.14           | 0.250  | 0.923    | 3.692    | 2.770   |
| 4    | Russian Federation     | 46.06           | 0.619  | 0.921    | 1.489    | 0.567   |
| 5    | France                 | 37.16           | 0.742  | 0.743    | 1.002    | 0.259   |
| 6    | Canada                 | 25.26           | 0.503  | 0.505    | 1.004    | 0.498   |
| 7    | Germany                | 23.68           | 0.459  | 0.474    | 1.033    | 0.559   |
| 8    | Pakistan               | 20.82           | 0.200  | 0.416    | 2.084    | 1.667   |
| 9    | Turkey                 | 20.77           | 0.423  | 0.415    | 0.983    | 0.568   |
| 10   | Australia              | 18.64           | 0.541  | 0.373    | 0.689    | 0.316   |

### TASK 5
Many of the BNR's models, such as GLOBIOM and EPIC-IIASA, could benefit from the insights taken from the analysis of Nitrogen use efficiency and loss to enhance the sustainability of agricultural practices. By integrating data on nitrogen management, these models can guide the development of agricultural strategies (crop management practices) that minimize environmental harm, particularly from excessive fertilizer use, which can lead to water/landscape contamination (eutrophication), finally leading to increased greenhouse gas emissions.

### TASK 6
**Performance Issues with raster::extract:** The raster::extract, which is the function I use more regularly had a performance much slower than expected. Possibly due to the complexity of the shapefile ("g2015_2005_2.shp") used for extraction. 

**Assumptions on units:** The assumption that production yield is in kg. This was not clear and might misled the results. The handling of geospatial data requires assumptions about the units of measurement and the appropriate methods for aggregation. It was assumed that the area was measured in hectares, which is a standard unit for agricultural land measurement. 

**Inconsistencies in Country Names (Task 4):** Discrepancies in country naming conventions between different datasets posed a challenge for data merging. For instance, _Zhang_data_ uses "USA"; while _prod_by_country_ has "United States of America". The _"countrycode"_ library was used to uniformize them and make the correct merge possible.

## How to clone repository with Git
    git clone https://github.com/munizlimap15/assign_PL.git

## Author
- **Pedro Lima** - *Initial work* - [Email](mailto:pedrohe@gmail.com)
- Institut für Geographie und Regionalforschung
- Universitätsstrasse 7, 1010 Wien, AT
- [Private Website](https://munizlimap15.github.io/Pedrolima/)  
- [Website](http://geomorph.univie.ac.at/)

### Date: Nov/2nd/2023

## Tools and Libraries
The analysis was performed using R and the following libraries:
- `raster`
- `rgdal`
- `sp`
- `sf`
- `tidyverse`
- `mapview`
- `rgeos`
- `exactextractr`
- `cowplot`
- `countrycode`

## Repository Structure
- `data/`: Directory containing raw data files.

## Contact
For any questions or issues related to this repository, please contact:
- Pedro Lima: [pedrohe@gmail.com](mailto:pedrohe@gmail.com)