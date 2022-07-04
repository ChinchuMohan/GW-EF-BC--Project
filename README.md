# Groundwater contribution to environmental flows

This repository contains the workflow of Mohan et al. (in review). **Quantifying groundwater's contribution to regional environmental flows in diverse hydrologic landscapes** Pre print: doi 10.1002/essoar.10511792.1 

The repository will be organised into three folders: 1) preprocessing/estimation, 2) analysis, 3) plotting
To access all details of the data used, visit README-data.md.
To access all the final outputs from this project, visit [add dataverse link]

Details of each folder is as below

#### Data extraction
- _Script_PCR_MODFLOW_extractBC_ : Script for extracting monthly PCR-ModFlow output for Only British Columbia
- _Clip_code.m_ : Function for extrating values with in lat-lot bounds
- _maskregion.m_ : maskregion mask out the data in the nc file as per the shapefile provided  [modified from Ankur Kumar's code on Atmospheric Science ToolBox]
- _Script_Upstream_Monthly.m_ : Script for extracting monthly upstream contribution data for British Columbia
- _Script_Precip.m_ : Script fro extracting Precipitaion data for British Columbia

#### Estimation
- _Script_E1_E2_calculation.m_ : Script for calculating groundwater contribution to environmental flow using groundwater centric and surface water centric method
- _convert_myr.m_ : Function for converting to m/y
- _f_local.m_ : Function for estimating flocal in E_SW estimation
- _combQ.m_ : Function for combining maximum low flow, miminum moderate flow and minimum high flow 
- _flowCondition.m_ :  Function for finding the condition of flow from mean annual discharge and mean monthly discharge [Not used in the main script]


## Project description
In this study we develop two methods for estimating groundwater contribution to environmental flows: 1) a groundwater-centric method and 2) a surface water-centric method. The two methods are demonstrated using the western province of Canada, British Columbia as a case study. The framework presented in this study can be implemented across different spatial and temporal scales for different regions and globally, in data-scarce, hydrologically complex landscapes. 

## Authors

Chinchu Mohan, Tom Gleeson,  Tara Forstner, James S Famiglietti,  Inge de Graaf

## Contact

If there are any queries, please contact
Chinchu Mohan
chinchu.mohan@usask.ca
