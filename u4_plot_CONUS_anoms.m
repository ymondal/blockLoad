%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% NAME: u4_plot_CONUS_anoms.m
%% PROJECT: MVZ Downscaling
%% AUTHOR: Yugarshi Mondal
%% DESCRIPTION: This utility script plots fields and their anomalies after they've 
%%		been the results have been concatenated by u1_conCatterMain.m
%% INPUTS: - none -
%% OUTPUTS: - none -
%%
%% HISTORY:
%% YM 12/04/2013 -- Created

load TAS_F.mat

%%obs

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
d1 = tas.obs(:,:,12) + tas.obs(:,:,1) + tas.obs(:,:,2); d1 = d1./3;
pcolor(flipud(d1)); shading flat; colorbar;
title('Winter Historical (DJF)')
saveas(fig,'tas_hist_winter','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(tas.obs(:,:,2:5),3))); shading flat; colorbar;
title('Spring Historical (MAM)')
saveas(fig,'tas_hist_spring','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(tas.obs(:,:,6:8),3))); shading flat; colorbar;
title('Summer Historical (JJA)')
saveas(fig,'tas_hist_summer','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(tas.obs(:,:,9:11),3))); shading flat; colorbar;
title('Autumn Historical (SON)')
saveas(fig,'tas_hist_autumn','jpeg')
close all

%% midH
fig = figure()
set(fig,'Position',[0 0 1400 1900]);
d2 = tas.midH.mean(:,:,12) + tas.midH.mean(:,:,1) + tas.midH.mean(:,:,2); d2 = d2./3;
pcolor(flipud(d2)); shading flat; colorbar;
title('Winter midH (DJF)')
saveas(fig,'tas_midH_winter','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(tas.midH.mean(:,:,2:5),3))); shading flat; colorbar;
title('Spring midH (MAM)')
saveas(fig,'tas_midH_spring','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(tas.midH.mean(:,:,6:8),3))); shading flat; colorbar;
title('Summer midH (JJA)')
saveas(fig,'tas_midH_summer','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(tas.midH.mean(:,:,9:11),3))); shading flat; colorbar;
title('Autumn midH (SON)')
saveas(fig,'tas_midH_autumn','jpeg')
close all

%% lgm

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
d3 = tas.lgm.mean(:,:,12) + tas.lgm.mean(:,:,1) + tas.lgm.mean(:,:,2); d3 = d3./3;
pcolor(flipud(d3)); shading flat; colorbar;
title('Winter lgm (DJF)')
saveas(fig,'tas_lgm_winter','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(tas.lgm.mean(:,:,2:5),3))); shading flat; colorbar;
title('Spring lgm (MAM)')
saveas(fig,'tas_lgm_spring','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(tas.lgm.mean(:,:,6:8),3))); shading flat; colorbar;
title('Summer lgm (JJA)')
saveas(fig,'tas_lgm_summer','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(tas.lgm.mean(:,:,9:11),3))); shading flat; colorbar;
title('Autumn lgm (SON)')
saveas(fig,'tas_lgm_autumn','jpeg')
close all

%%% anoms

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(d3-d1)); shading flat; colorbar;
title('Winter lgm anoms (DJF)')
saveas(fig,'anoms_tas_lgm_winter','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(d2-d1)); shading flat; colorbar;
title('Winter midH anoms (DJF)')
saveas(fig,'anoms_tas_midH_winter','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(tas.lgm.mean(:,:,2:5),3)-mean(tas.obs(:,:,2:5),3))); shading flat; colorbar;
title('Spring lgm (MAM)')
saveas(fig,'anoms_tas_lgm_spring','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(tas.lgm.mean(:,:,6:8),3)-mean(tas.obs(:,:,6:8),3))); shading flat; colorbar;
title('Summer lgm (JJA)')
saveas(fig,'anoms_tas_lgm_summer','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(tas.lgm.mean(:,:,9:11),3)-mean(tas.obs(:,:,9:11),3))); shading flat; colorbar;
title('Autumn lgm (SON)')
saveas(fig,'anoms_tas_lgm_autumn','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(tas.midH.mean(:,:,2:5),3)-mean(tas.obs(:,:,2:5),3))); shading flat; colorbar;
title('Spring midH (MAM)')
saveas(fig,'anoms_tas_midH_spring','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(tas.midH.mean(:,:,6:8),3)-mean(tas.obs(:,:,6:8),3))); shading flat; colorbar;
title('Summer midH (JJA)')
saveas(fig,'anoms_tas_midH_summer','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(tas.midH.mean(:,:,9:11),3)-mean(tas.obs(:,:,9:11),3))); shading flat; colorbar;
title('Autumn midH (SON)')
saveas(fig,'anoms_tas_midH_autumn','jpeg')
close all

clear all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear tas
load TMIN_F.mat

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
d1 = tmin.obs(:,:,12) + tmin.obs(:,:,1) + tmin.obs(:,:,2); d1 = d1./3;
pcolor(flipud(d1)); shading flat; colorbar;
saveas(fig,'tmin_hist_winter','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(tmin.obs(:,:,2:5),3))); shading flat; colorbar;
title('Spring Historical (MAM)')
saveas(fig,'tmin_hist_spring','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(tmin.obs(:,:,6:8),3))); shading flat; colorbar;
title('Summer Historical (JJA)')
saveas(fig,'tmin_hist_summer','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(tmin.obs(:,:,9:11),3))); shading flat; colorbar;
title('Autumn Historical (SON)')
saveas(fig,'tas_hist_autumn','jpeg')
close all

%%
fig = figure()
set(fig,'Position',[0 0 1400 1900]);
d2 = tmin.midH.mean(:,:,12) + tmin.midH.mean(:,:,1) + tmin.midH.mean(:,:,2); d2 = d2./3;
pcolor(flipud(d2)); shading flat; colorbar;
title('Winter midH (DJF)')
saveas(fig,'tmin_midH_winter','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(tmin.midH.mean(:,:,2:5),3))); shading flat; colorbar;
title('Spring midH (MAM)')
saveas(fig,'tmin_midH_spring','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(tmin.midH.mean(:,:,6:8),3))); shading flat; colorbar;
title('Summer midH (JJA)')
saveas(fig,'tmin_midH_summer','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(tmin.midH.mean(:,:,9:11),3))); shading flat; colorbar;
title('Autumn midH (SON)')
saveas(fig,'tmin_midH_autumn','jpeg')
close all
%%

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
d3 = tmin.lgm.mean(:,:,12) + tmin.lgm.mean(:,:,1) + tmin.lgm.mean(:,:,2); d3 = d3./3;
pcolor(flipud(d3)); shading flat; colorbar;
title('Winter lgm (DJF)')
saveas(fig,'tmin_lgm_winter','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(tmin.lgm.mean(:,:,2:5),3))); shading flat; colorbar;
title('Spring lgm (MAM)')
saveas(fig,'tmin_lgm_spring','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(tmin.lgm.mean(:,:,6:8),3))); shading flat; colorbar;
title('Summer lgm (JJA)')
saveas(fig,'tmin_lgm_summer','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(tmin.lgm.mean(:,:,9:11),3))); shading flat; colorbar;
title('Autumn lgm (SON)')
saveas(fig,'tmin_lgm_autumn','jpeg')
close all

%%% anoms

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(d3-d1)); shading flat; colorbar;
title('Winter lgm anoms (DJF)')
saveas(fig,'anoms_tmin_lgm_winter','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(d2-d1)); shading flat; colorbar;
title('Winter midH anoms (DJF)')
saveas(fig,'anoms_tmin_midH_winter','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(tmin.lgm.mean(:,:,2:5),3)-mean(tmin.obs(:,:,2:5),3))); shading flat; colorbar;
title('Spring lgm (MAM)')
saveas(fig,'anoms_tmin_lgm_spring','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(tmin.lgm.mean(:,:,6:8),3)-mean(tmin.obs(:,:,6:8),3))); shading flat; colorbar;
title('Summer lgm (JJA)')
saveas(fig,'anoms_tmin_lgm_summer','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(tmin.lgm.mean(:,:,9:11),3)-mean(tmin.obs(:,:,9:11),3))); shading flat; colorbar;
title('Autumn lgm (SON)')
saveas(fig,'anoms_tmin_lgm_autumn','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(tmin.midH.mean(:,:,2:5),3)-mean(tmin.obs(:,:,2:5),3))); shading flat; colorbar;
title('Spring midH (MAM)')
saveas(fig,'anoms_tmin_midH_spring','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(tmin.midH.mean(:,:,6:8),3)-mean(tmin.obs(:,:,6:8),3))); shading flat; colorbar;
title('Summer midH (JJA)')
saveas(fig,'anoms_tmin_midH_summer','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(tmin.midH.mean(:,:,9:11),3)-mean(tmin.obs(:,:,9:11),3))); shading flat; colorbar;
title('Autumn midH (SON)')
saveas(fig,'anoms_tmin_midH_autumn','jpeg')
close all

clear all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear tmin
load TMAX_F.mat

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
d1 = tmax.obs(:,:,12) + tmax.obs(:,:,1) + tmax.obs(:,:,2); d1 = d1./3;
pcolor(flipud(d1)); shading flat; colorbar;
title('Winter Historical (DJF)')
saveas(fig,'tmax_hist_winter','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(tmax.obs(:,:,2:5),3))); shading flat; colorbar;
title('Spring Historical (MAM)')
saveas(fig,'tmax_hist_spring','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(tmax.obs(:,:,6:8),3))); shading flat; colorbar;
title('Summer Historical (JJA)')
saveas(fig,'tmax_hist_summer','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(tmax.obs(:,:,9:11),3))); shading flat; colorbar;
title('Autumn Historical (SON)')
saveas(fig,'tmax_hist_autumn','jpeg')
close all

%%
fig = figure()
set(fig,'Position',[0 0 1400 1900]);
d2 = tmax.midH.mean(:,:,12) + tmax.midH.mean(:,:,1) + tmax.midH.mean(:,:,2); d2 = d2./3;
pcolor(flipud(d2)); shading flat; colorbar;
title('Winter midH (DJF)')
saveas(fig,'tmax_midH_winter','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(tmax.midH.mean(:,:,2:5),3))); shading flat; colorbar;
title('Spring midH (MAM)')
saveas(fig,'tmax_midH_spring','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(tmax.midH.mean(:,:,6:8),3))); shading flat; colorbar;
title('Summer midH (JJA)')
saveas(fig,'tmax_midH_summer','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(tmax.midH.mean(:,:,9:11),3))); shading flat; colorbar;
title('Autumn midH (SON)')
saveas(fig,'tas_midH_autumn','jpeg')
close all

%%

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
d3 = tmax.lgm.mean(:,:,12) + tmax.lgm.mean(:,:,1) + tmax.lgm.mean(:,:,2); d3 = d3./3;
pcolor(flipud(d3)); shading flat; colorbar;
title('Winter lgm (DJF)')
saveas(fig,'tmax_lgm_winter','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(tmax.lgm.mean(:,:,2:5),3))); shading flat; colorbar;
title('Spring lgm (MAM)')
saveas(fig,'tmax_lgm_spring','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(tmax.lgm.mean(:,:,6:8),3))); shading flat; colorbar;
title('Summer lgm (JJA)')
saveas(fig,'tmax_lgm_summer','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(tmax.lgm.mean(:,:,9:11),3))); shading flat; colorbar;
title('Autumn lgm (SON)')
saveas(fig,'tmax_lgm_autumn','jpeg')
close all

%%% anoms

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(d3-d1)); shading flat; colorbar;
title('Winter lgm anoms (DJF)')
saveas(fig,'anoms_tmax_lgm_winter','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(d2-d1)); shading flat; colorbar;
title('Winter midH anoms (DJF)')
saveas(fig,'anoms_tmax_midH_winter','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(tmax.lgm.mean(:,:,2:5),3)-mean(tmax.obs(:,:,2:5),3))); shading flat; colorbar;
title('Spring lgm (MAM)')
saveas(fig,'anoms_tmax_lgm_spring','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(tmax.lgm.mean(:,:,6:8),3)-mean(tmax.obs(:,:,6:8),3))); shading flat; colorbar;
title('Summer lgm (JJA)')
saveas(fig,'anoms_tmax_lgm_summer','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(tmax.lgm.mean(:,:,9:11),3)-mean(tmax.obs(:,:,9:11),3))); shading flat; colorbar;
title('Autumn lgm (SON)')
saveas(fig,'anoms_tmax_lgm_autumn','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(tmax.midH.mean(:,:,2:5),3)-mean(tmax.obs(:,:,2:5),3))); shading flat; colorbar;
title('Spring midH (MAM)')
saveas(fig,'anoms_tmax_midH_spring','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(tmax.midH.mean(:,:,6:8),3)-mean(tmax.obs(:,:,6:8),3))); shading flat; colorbar;
title('Summer midH (JJA)')
saveas(fig,'anoms_tmax_midH_summer','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(tmax.midH.mean(:,:,9:11),3)-mean(tmax.obs(:,:,9:11),3))); shading flat; colorbar;
title('Autumn midH (SON)')
saveas(fig,'anoms_tmax_midH_autumn','jpeg')
close all

clear all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear tmax
load PRECIP_F.mat

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
d1 = precip.obs(:,:,12) + precip.obs(:,:,1) + precip.obs(:,:,2); d1 = d1./3;
pcolor(flipud(d1)); shading flat; colorbar;
title('Winter Historical (DJF)')
saveas(fig,'precip_hist_winter','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(precip.obs(:,:,2:5),3))); shading flat; colorbar;
title('Spring Historical (MAM)')
saveas(fig,'precip_hist_spring','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(precip.obs(:,:,6:8),3))); shading flat; colorbar;
title('Summer Historical (JJA)')
saveas(fig,'precip_hist_summer','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(precip.obs(:,:,9:11),3))); shading flat; colorbar;
title('Autumn Historical (SON)')
saveas(fig,'precip_hist_autumn','jpeg')
close all

%%
fig = figure()
set(fig,'Position',[0 0 1400 1900]);
d2 = precip.midH.mean(:,:,12) + precip.midH.mean(:,:,1) + precip.midH.mean(:,:,2); d2 = d2./3;
pcolor(flipud(d2)); shading flat; colorbar;
title('Winter midH (DJF)')
saveas(fig,'precip_midH_winter','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(precip.midH.mean(:,:,2:5),3))); shading flat; colorbar;
title('Spring midH (MAM)')
saveas(fig,'precip_midH_spring','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(precip.midH.mean(:,:,6:8),3))); shading flat; colorbar;
title('Summer midH (JJA)')
saveas(fig,'precip_midH_summer','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(precip.midH.mean(:,:,9:11),3))); shading flat; colorbar;
title('Autumn midH (SON)')
saveas(fig,'precip_midH_autumn','jpeg')
close all

%%

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
d3 = precip.lgm.mean(:,:,12) + precip.lgm.mean(:,:,1) + precip.lgm.mean(:,:,2); d3 = d3./3;
pcolor(flipud(d3)); shading flat; colorbar;
title('Winter lgm (DJF)')
saveas(fig,'precip_lgm_winter','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(precip.lgm.mean(:,:,2:5),3))); shading flat; colorbar;
title('Spring lgm (MAM)')
saveas(fig,'precip_lgm_spring','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(precip.lgm.mean(:,:,6:8),3))); shading flat; colorbar;
title('Summer lgm (JJA)')
saveas(fig,'precip_lgm_summer','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(precip.lgm.mean(:,:,9:11),3))); shading flat; colorbar;
title('Autumn lgm (SON)')
saveas(fig,'precip_lgm_autumn','jpeg')
close all

%%% anoms

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(d3-d1)); shading flat; colorbar;
title('Winter lgm anoms (DJF)')
saveas(fig,'anoms_precip_lgm_winter','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(d2-d1)); shading flat; colorbar;
title('Winter midH anoms (DJF)')
saveas(fig,'anoms_precip_midH_winter','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(precip.lgm.mean(:,:,2:5),3)-mean(precip.obs(:,:,2:5),3))); shading flat; colorbar;
title('Spring lgm (MAM)')
saveas(fig,'anoms_precip_lgm_spring','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(precip.lgm.mean(:,:,6:8),3)-mean(precip.obs(:,:,6:8),3))); shading flat; colorbar;
title('Summer lgm (JJA)')
saveas(fig,'anoms_precip_lgm_summer','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(precip.lgm.mean(:,:,9:11),3)-mean(precip.obs(:,:,9:11),3))); shading flat; colorbar;
title('Autumn lgm (SON)')
saveas(fig,'anoms_precip_lgm_autumn','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(precip.midH.mean(:,:,2:5),3)-mean(precip.obs(:,:,2:5),3))); shading flat; colorbar;
title('Spring midH (MAM)')
saveas(fig,'anoms_precip_midH_spring','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(precip.midH.mean(:,:,6:8),3)-mean(precip.obs(:,:,6:8),3))); shading flat; colorbar;
title('Summer midH (JJA)')
saveas(fig,'anoms_precip_midH_summer','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(precip.midH.mean(:,:,9:11),3)-mean(precip.obs(:,:,9:11),3))); shading flat; colorbar;
title('Autumn midH (SON)')
saveas(fig,'anoms_precip_midH_autumn','jpeg')
close all

clear all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

