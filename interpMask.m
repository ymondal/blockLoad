%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% NAME: interpMask.m
%% PROJECT: Bias-Corrected Spatial Disaggregation
%% AUTHOR: Yugarshi Mondal
%% DESCRIPTION: This function interpolates the GCM data to observational resolution. The 
%%		definitions for the resolution are hard coded from analysis -- so it is 
%%		specific to PRISM data. The data is then reshaped into a monthly climatology.
%% INPUTS: GCM lats, GCM lons, a x-y values of a field in time (hence 3d)
%% OUTPUTS: highResClim - An x-y stack interpolated to Obs resolution. This is 4D, the last
%%	    two dimentions are months and time-series for that month.
%%
%% HISTORY:
%% YM 05/22/2013 -- Created

function interpMask = interpMask(lat,lon,mask,boxLatLon)

	dummy = boxLatLon(1,2:5); %% Drop 1st col & last two rows of boxLatLon
	clear boxLatLon; boxLatLon = dummy;
	obsDef = loadObsDef();

	PRISM_LONS = [obsDef.first_lon:obsDef.delta_lon:obsDef.last_lon];
	PRISM_LATS = [obsDef.first_lat:obsDef.delta_lat:obsDef.last_lat];

	%% Conversions
	PRISM_LONS = 360 + PRISM_LONS; % PRISM_LON assigns a lat value that's continuously counted up from the East of Prime Meridian
	%% Creating and Subsetting LATq and LONq
	[LATq,LONq] = ndgrid(PRISM_LATS,PRISM_LONS);
	LATq = LATq(boxLatLon(1):boxLatLon(2),boxLatLon(3):boxLatLon(4));
	LONq = LONq(boxLatLon(1):boxLatLon(2),boxLatLon(3):boxLatLon(4));

	%boxLatLon Counts from the top, but GCM counts from the bottom
	LATq = flipud(LATq);
	
	%% 2. Create ngrid from GCM data
	%% IMPORTANT: Recenter GCM lats and lons
	[LATbase, LONbase] = ndgrid(lat,lon);

	interpMask = struct('lgm',[],'hist',[],'midH',[]);

	%% Mask Interpolation
	dummy = mask.hist;
	temp = flipud(interp2(LONbase,LATbase,dummy',LONq,LATq,'spline'));
	interpMask.hist = [temp > 50];

	dummy = mask.lgm;
	temp = flipud(interp2(LONbase,LATbase,dummy',LONq,LATq,'spline'));
	interpMask.lgm  = [temp > 50];

	dummy = mask.midH;
	temp = flipud(interp2(LONbase,LATbase,dummy',LONq,LATq,'spline'));
	interpMask.midH = [temp > 50];

end
