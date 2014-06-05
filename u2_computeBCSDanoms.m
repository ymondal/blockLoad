%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% NAME: u2_computeBCSDanoms.m
%% PROJECT: MVZ Downscaling
%% AUTHOR: Yugarshi Mondal
%% DESCRIPTION: This function creates adjusted model-projected anomalies
%% INPUTS: path (path to data)
%% OUTPUTS: bcsdAnoms (struct of adjusted model-projected anomalies for all variables)
%%
%% HISTORY:
%% YM 06/04/2013 -- Created

function bcsdAnoms = computeBCSDanoms(path)

        bcsdAnoms = struct('tas',[],'tmin',[],'tmax',[],'precip',[]);
        bcsdAnoms.tas = struct('lgm',[],'midH',[]);
        bcsdAnoms.tmin = bcsdAnoms.tas; bcsdAnoms.tmax = bcsdAnoms.tas; bcsdAnoms.precip = bcsdAnoms.tas;

	load(strcat(path,'final/PRECIP_F.mat'))
        bcsdAnoms.precip.lgm = precip.lgm.mean - precip.obs;
        bcsdAnoms.precip.midH = precip.midH.mean - precip.obs;
        clear precip

	load(strcat(path,'final/TAS_F.mat'))
	bcsdAnoms.tas.lgm = tas.lgm.mean - tas.obs;
	bcsdAnoms.tas.midH = tas.midH.mean - tas.obs;
	clear tas

        load(strcat(path,'final/TMAX_F.mat'))
        bcsdAnoms.tmax.lgm = tmax.lgm.mean - tmax.obs;
        bcsdAnoms.tmax.midH = tmax.midH.mean - tmax.obs;
        clear tmax

        load(strcat(path,'final/TMIN_F.mat'))
        bcsdAnoms.tmin.lgm = tmin.lgm.mean - tmin.obs;
        bcsdAnoms.tmin.midH = tmin.midH.mean - tmin.obs;
        clear tmin
