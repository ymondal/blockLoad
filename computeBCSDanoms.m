%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% NAME: computeBCSDanoms.m
%% PROJECT: Bias-Corrected Spatial Disaggregation
%% AUTHOR: Yugarshi Mondal
%% DESCRIPTION: This script bias corrects lgm and midHolocene GCM preciptitation records.
%% INPUTS: - none -
%% OUTPUTS: - none -
%%
%% HISTORY:
%% YM 06/04/2013 -- Created

function bcsdAnoms = computeBCSDanoms(path)

        bcsdAnoms = struct('tas',[],'tmin',[],'tmax',[],'precip',[]);
        bcsdAnoms.tas = struct('lgm',[],'midH',[]);
        bcsdAnoms.tmin = bcsdAnoms.tas; bcsdAnoms.tmax = bcsdAnoms.tas; bcsdAnoms.precip = bcsdAnoms.tas;

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

        load(strcat(path,'run_5/PRECIP_5.mat'))
        bcsdAnoms.precip.lgm = precip.lgm.mean - precip.obs;
        bcsdAnoms.precip.midH = precip.midH.mean - precip.obs;
        clear precip
