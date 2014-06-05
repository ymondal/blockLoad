"""
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Title:	Conversion.py
%% Project:     MVZ Downscaling
%% Author:	Yugarshi Mondal
%% Desc:	Walk down PRISM file structure and turn AUX files into
%%		ASC files. These will be stacked to contruct OBS data for
%%		BCSD interpolation.
%% History:
%% YM 05/22/2013 - First Version of Script
%%
"""

import os
import arcpy

def raster_to_asc(rootName, fileName):
	inRaster = rootName
	outASCII = "F:\\RAID\\data\\PRISM_800m\\TMIN\\" + fileName + ".asc"
	
	arcpy.RasterToASCII_conversion(inRaster, outASCII)

indir = "F:\\data\\PRISM_800m\\tmin"

# walk down the directory tree
for root, dirs, filenames in os.walk(indir):
	# if i'm looking in a directory and it has no subdirectories, im at the base
	if not dirs:
		# the back end of the root contains the name of the arcfile
		lowestDir = root.split('\\')[-1]
		dummy = lowestDir.split('_')
		if len(dummy) == 3 and dummy[0] == 'tmin':
			print str(root.split('\\')[-1]) + ' in progress'
			raster_to_asc(root, lowestDir)
