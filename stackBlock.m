%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% NAME: stackBlock.m
%% PROJECT: MVZ Downscaling
%% AUTHOR: Yugarshi Mondal
%% DESCRIPTION: This function interpolates the GCM data to observational resolution. The 
%%		definitions for the resolution are hard coded from analysis -- so it is 
%%		specific to PRISM data.
%% INPUTS: GCM lats, GCM lons, stack (to be interpolated), boxLatLon (bounding region) 
%% OUTPUTS: interpolatedSlice (this is actually a block of interpolated slices from GCM)
%%
%% HISTORY:
%% YM 05/22/2013 -- Created

function [interpolatedSlice] = stackBlock(lat,lon,stack,boxLatLon)

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%% INITIALIZATION // PRISM is gridded one way, GCM is gridded another
	%%			these initialization steps define a common gridding,
	%%			then interpolate over the region of interest
	%% 1. Load region of interest
	%% 2. Load Observation Definitions
	%% 3. Convert PRISM lats and lons to GCM convention, create PRISM lat/lon mesh
	%% 4. Create a GCM lat/lon mesh

	%% 1. Region of Interest
	dummy = boxLatLon(1,2:5); %% Drop 1st col & last two rows of boxLatLon
	clear boxLatLon; boxLatLon = dummy;

	%% 2. Load Observation Defs
	obsDef = loadObsDef();
	PRISM_LONS = [obsDef.first_lon:obsDef.delta_lon:obsDef.last_lon];
	PRISM_LATS = [obsDef.first_lat:obsDef.delta_lat:obsDef.last_lat];

	%% 3. Convert PRISM lats and Lons so they're consistant with GCM
	PRISM_LONS = 360 + PRISM_LONS; % PRISM_LON assigns a lat value that's continuously counted up from the East of Prime Meridian
	%% Creating and Subsetting LATq and LONq
	[LATq,LONq] = ndgrid(PRISM_LATS,PRISM_LONS);
	LATq = LATq(boxLatLon(1):boxLatLon(2),boxLatLon(3):boxLatLon(4));
	LONq = LONq(boxLatLon(1):boxLatLon(2),boxLatLon(3):boxLatLon(4));
	%boxLatLon Counts from the top, but GCM counts from the bottom
	LATq = flipud(LATq);
	
	%% 4. Create ngrid from GCM data
	%% IMPORTANT: Recenter GCM lats and lons
	[LATbase, LONbase] = ndgrid(lat,lon);

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%% SLICE INTERPOLATION // interpolate slice
	%% For each time slice:
	%% 1. Query the gridded interpolant at PRISM's LATq and LONq @ row slice,
	%% 	and load each into interpolatedSlice.

	interpolatedSlice = [];
	for i = 1:size(stack,3)
		%% 1. Interpolate Month Stack
		%% Query interpolant in the latitude idx of the GCM, then flip back to match Obs Idx
		dummy = stack(:,:,i); %% stack is a global variable
		interpolatedSlice(:,:,i) = flipud(interp2(LONbase,LATbase,dummy',LONq,LATq,'spline'));
	end

	%Flip LATq back and return this
	%LATq = flipud(LATq);

end
