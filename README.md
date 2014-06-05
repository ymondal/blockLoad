Climate Model Downscaling
=========================

This code was used to create downscaled climatologies over CONUS. The observations were taken from PRISM and the model was CCSM4.

* indicated internally called functions
- indicated independantly called functions

The following tree describes the workflow of processing data.

Inputs and Data needed
GCM CCSM4 data lgm and midH pr, tas, tmin, tmax
PRISM data 

1. Preprocessing PRISM data
---------------------------
```
DESCRIPTION: PRISM was given my Michelle as arc project files. These need to be converted to ascii
		to be read by MATLAB. It's impossible to hold all ~1300 observation files at once 
		in memory. Downscaling requires continuous time-series, not spatially continugous fields.
		So ascii files are cut into 345 parts and stacked so they're continuous in time. This is
		done for each variable.
INPUTS: PRSIM project files
OUTPUTS: (chunked observation files) PPT_[1-345].mat, TMIN_[1-345].mat, TMAX_[1-345].mat 

- converstion.py // using arcpy, convert arcGIS project files into asc files
- obsBlockPreproc.m // this is done to create observation time series, each ascii file cut into 345 parts and rebuilt so they're continuous in time
```

2. Downscaling Code
-------------------
```
DESCRIPTION:	This executes the main downscaling
INPUTS: 	Preprocessed PRISM data, CCSM4 netcdf files
		(precip, tmin, tmax, tas for lgm, historical, and mid-Holocene)
OUTPUTS:	Sections of the Monthly Climatology
		PPT_[1-345]_M[1-12].mat, TMIN_[1-345]_M[1-12].mat, 
		TMAX_[1-345]_M[1-12].mat, TMAX_[1-345]_M[1-12].mat

- main.m // main downscaling script
  * createBox.m // creates box
  * * loadObsDef.m // contains PRISM observation defintions
  * fileLoader.m // load GCM data to memory
  * * getLock.m // implements rudimentary file locking
  * * releaseLock.m // implements rudimentary file lock releasing
  * precip_main.m // precipitation downscaling
  * * stackBlock.m // interpolates section of GCM data
  * * * loadObsDef.m, getLock.m, releaseLock.m [defined above]
  * * obsLoad.m // loads relevant observations
  * * quantileMatching.m // Projection renoarmalization for precipitation
  * temp_main.m // temperature downscaling
  * * quantileMatching.m // quantile matching script
  * * temp_main.m // EDCDFm for temperature
```  
3. Utilities
-------------------
```
DESCRIPTION: Independant scripts that accomplish different tasks
INPUTS: - consult script header -
OUTPUTS: - consult script header -

- u1_
```
