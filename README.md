Climate Model Downscaling
=========================

This code was used to create downscaled climatologies over CONUS. The observations were taken from PRISM and the model was CCSM4.

The following tree describes the workflow of processing data.

Inputs and Data needed
GCM CCSM4 data lgm and midH pr, tas, tmin, tmax
PRISM data

1. Preprocessing PRISM data
---------------------------
Same block commenting as code

PRISM was given my Michelle as arc project files. These needed to be converted to ascii files. Before running downscaling, observation data also needed to be reshaped and saved back to disk. It's impossible to hold all ~1300 observation filesat once.

*converstion.py | using arcpy, convert arcGIS project files into asc files
*obsBlockPreproc.m | this is done to create observation time series, each ascii file cut into 345 parts and rebuilt so they're continuous in time


*main.m | this takes 
