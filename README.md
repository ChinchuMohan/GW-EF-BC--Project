# Groundwater contribution to environmental flows

This repository contains the workflow of Mohan et al. (in review). **Quantifying groundwater's contribution to regional environmental flows in diverse hydrologic landscapes**  Pre print doi: https://www.essoar.org/doi/10.1002/essoar.10511792.1

The repository is organised into three folders: 1) Data extraction, 2) Estimation, 3) Analysis-Plotting
To access all details of the data used, visit [Data-sources.md](https://github.com/ChinchuMohan/Groundwater-Eflows-British-Columbia-Project/blob/main/Data-sources.md)

To access all the final outputs from this project follow the link https://doi.org/10.5683/SP3/938XJR

Details of each folder in Matlab-Code folder is as below

#### Data extraction
- _Script_PCR_MODFLOW_extractBC_ : Script for extracting monthly PCR-ModFlow output for Only British Columbia
- _Clip_code.m_ : Function for extracting values with in lat-lon bounds
- _maskregion.m_ : maskregion mask out the data in the any netcdf file as per the shapefile provided  [modified from Ankur Kumar's code on Atmospheric Science ToolBox]
- _Script_Upstream_Monthly.m_ : Script for extracting monthly upstream contribution data for British Columbia
- _Script_Precip.m_ : Script for extracting precipitaion data for British Columbia

#### Estimation
- _Script_E1_E2_calculation.m_ : Script for calculating groundwater contribution to environmental flow using groundwater centric and surface water centric method
- _convert_myr.m_ : Function for converting to m/y
- _f_local.m_ : Function for estimating flocal in E_SW estimation
- _combQ.m_ : Function for combining maximum low flow, miminum moderate flow and minimum high flow 
- _flowCondition.m_ :  Function for finding the condition of flow from mean annual discharge and mean monthly discharge [Not used in the main script]

#### Analysis-Plotting
- _Script_paper.m_ : Script for plotting the figures for paper
- _crameri.m_ : Function returns perceptually-uniform scientific colormaps created by Fabio Crameri. Click [here](http://www.fabiocrameri.ch/colourmaps.php) for more details
- _multiple_boxplot.m_ : Function for plotting multiple box plots in a single figure. Matlab code modified by the code by Ander Biguri. Click [here](https://www.mathworks.com/matlabcentral/fileexchange/47233-multiple_boxplot-m) for original code 
- _arcgridwrite.m_ : Function to write gridded data set in Arc ASCII Grid Format.  Matlab code modified by the code by A.Stevens @ USGS. Click [here](https://www.mathworks.com/matlabcentral/fileexchange/16176-arcgridwrite) for original code

_Note_ : All file paths in the matlab scripts need to be modified to match the local working directory, when  downloaded and used in a local system

## Project description
In this study we develop two methods for estimating groundwater contribution to environmental flows: 1) a groundwater-centric method and 2) a surface water-centric method. The two methods are demonstrated using the western province of Canada, British Columbia as a case study. The framework presented in this study can be implemented across different spatial and temporal scales for different regions and globally, in data-scarce, hydrologically complex landscapes. 

## Authors

Chinchu Mohan, Tom Gleeson,  Tara Forstner, James S Famiglietti,  Inge de Graaf

## Contact

If there are any queries, please contact
Chinchu Mohan
chinchu.mohan@usask.ca

## Last update
Aug-25-2022
