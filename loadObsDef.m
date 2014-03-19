%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% NAME: obsDef.m
%% PROJECT: Bias-Corrected Spatial Disaggregation
%% AUTHOR: Yugarshi Mondal
%% DESCRIPTION: This function returns the PRISM resolution parameters. Everything is hardcoded.
%% INPUTS: - none -
%% OUTPUTS: - none -
%%
%% HISTORY:
%% YM 05/22/2013 -- Created

function obsDef = loadObsDef()

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%% DEFINITIONS // define ngrids for GCM data and create them for OBS data
	%% 1. Create ngrid from OBS data from PRISM parameters.
	%% 	Note: These parameters were determined by previous 
	%%     		analysis of PRISM data. As such, they are hardcoded.
	%% 2. Create ngrid from GCM data
	%% 3. Fix Units

	%% 1. Create ngrid for PRISM interpolation
	%%
	%% R Matrix: [Z, R] = arcgridread(PRISM_DATA)
	%% R =
	%%         0   -0.0083
	%%    0.0083         0
	%% -125.0250   49.9417
	%%
	%% size(Z) = [ 3105, 7025 ]
	%%
	%% we know delta_lat/lon, first_lat/lon,
	%% so we can calulate last_lat/lon
	%% values are precalulated and hard coded here
	
	zero_lat = 49.9417;
	delta_lat = -0.0083;
	first_lat = zero_lat + delta_lat;
	last_lat = zero_lat + 3105 * delta_lat;

	zero_lon = -125.0250;
	delta_lon = 0.0083;
	first_lon = zero_lon + delta_lon;
	last_lon = zero_lon + 7025 * delta_lon;

	obsDef = struct('zero_lat',zero_lat,'delta_lat',delta_lat,'first_lat',first_lat,'last_lat',last_lat,'zero_lon',zero_lon,'delta_lon',delta_lon,'first_lon',first_lon,'last_lon',last_lon,'zeroLat',zero_lat,'deltaLat',delta_lat,'firstLat',first_lat,'lastLat',last_lat,'zeroLon',zero_lon,'deltaLon',delta_lon,'firstLon',first_lon,'lastLon',last_lon);



