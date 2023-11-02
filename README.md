# MONEW - 2023

<img
  src="/Logo_port_yellow.png"
  alt="Alt text"
  title="Optional title"
  style="display: inline-block; margin: 0 auto; max-width: 300px">

## How to clone repository with Git

The access/clone for the **MoNEW** repository can be accessed with

    git clone https://github.com/munizlimap15/MoNEW_2023.git

# Link to the files:
https://ucloud.univie.ac.at/index.php/s/5QAqgIIr51ZYIdo


## Table of Contents

| Script Name                                           | What the Script Does                                                                                              |
|:------------------------------------------------------|:------------------------------------------------------------------------------------------------------------------|
| `1-TrainingSampling.R`                                | Merges new slides from BGK and IMASS with the same "landslide False" samples as used in MoNOE and prepares the final MoNEW training samples. Execution time: ~10 minutes on an Intel i7-10750H CPU. |
| `2-PerformanceEstimation.R`                           | Estimates the Susceptibility Model Performance for different models and calculates the Spatial Cross-validation.  |
| `3-PlotValid.R`                                       | Provides a summary of the sperrorest model results for MoNEW and MoNOE.                                           |
| `4-SamplingRatio.R`                                   | Processes data related to landslides for different lithological units, calculates key statistics, and exports the summarized information. |
| `5-ModelNumericalPrediction.R`                        | Processes and analyzes geological and topographical raster data to model landslide susceptibility using Generalized Additive Models (GAMs). |
| `6-ModelClassification.R`                             | Classifies the susceptibility into distinct classes based on quantile statistics. Fills holes in the prediction grid and saves the final susceptibility raster.                                                                                              |


## Citation

If you use the data or code from this repository in your research, please cite it as follows:

Lima P, Steger S, Petschko H, Goetz J, und Glade T (2023): Technische Anleitung für Experten zur regionalen Modellierung von Gefahrenhinweiskarten für Rutschungen in Niederösterreich. Mai 2023, Wien.


## Authors

### Universität Wien
- **Pedro Lima** - *Initial work* - [Email](mailto:pedro.lima@univie.ac.at)
- Institut für Geographie und Regionalforschung
- Universitätsstrasse 7, 1010 Wien, AT
- [Private Website](https://munizlimap15.github.io/Pedrolima/)  
- [Website](http://geomorph.univie.ac.at/)

- **Thomas Glade** - *Contributor* - [Email](mailto:thomas.glade@univie.ac.at)
  - Institut für Geographie und Regionalforschung
  - Universitätsstrasse 7, 1010 Wien, AT
  - [Website](http://geomorph.univie.ac.at/)

### Friedrich-Schiller-Universität Jena
- **Helene Petschko** - *Contributor* - [Email](mailto:helene.petschko@uni-jena.de)
- **Jason Goetz** - *Contributor* - [Email](mailto:jason.goetz@uni-jena.de)
  - Institut für Geographie
  - Grietgasse 6, 07745 Jena, DE
  - [Website](https://www.geographie.uni-jena.de/)

### EURAC research
- **Stefan Steger** - *Contributor* - [Email](mailto:stefan.steger@eurac.edu)
  - Zentrum für Klimawandel und Transformation
  - Drususallee 1/Viale Druso 1, 39100 Bolzano-Bozen, IT
  - [Website](https://www.eurac.edu/de/institutes-centers/center-for-climate-change-and-transformation)

## Contact

For any questions or issues related to this repository, please contact:
- Pedro Lima: [pedro.lima@univie.ac.at](mailto:pedro.lima@univie.ac.at), [pedrohe@gmail.com](mailto:pedrohe@gmail.com)
