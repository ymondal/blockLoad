load ccsm4_BCSD_metaAnomalies_F

%% midH
fig = figure()
set(fig,'Position',[0 0 1400 1900]);
d2 = metaAnoms.tas.midH(:,:,12) + metaAnoms.tas.midH(:,:,1) + metaAnoms.tas.midH(:,:,2); d2 = d2./3;
pcolor(flipud(d2)); shading flat; colorbar;
title('Winter midH (DJF)')
saveas(fig,'tas_midH_winter','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(metaAnoms.tas.midH(:,:,2:5),3))); shading flat; colorbar;
title('Spring midH (MAM)')
saveas(fig,'tas_midH_spring','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(metaAnoms.tas.midH(:,:,6:8),3))); shading flat; colorbar;
title('Summer midH (JJA)')
saveas(fig,'tas_midH_summer','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(metaAnoms.tas.midH(:,:,9:11),3))); shading flat; colorbar;
title('Autumn midH (SON)')
saveas(fig,'tas_midH_autumn','jpeg')
close all

%% lgm

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
d3 = metaAnoms.tas.lgm(:,:,12) + metaAnoms.tas.lgm(:,:,1) + metaAnoms.tas.lgm(:,:,2); d3 = d3./3;
pcolor(flipud(d3)); shading flat; colorbar;
title('Winter lgm (DJF)')
saveas(fig,'tas_lgm_winter','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(metaAnoms.tas.lgm(:,:,2:5),3))); shading flat; colorbar;
title('Spring lgm (MAM)')
saveas(fig,'tas_lgm_spring','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(metaAnoms.tas.lgm(:,:,6:8),3))); shading flat; colorbar;
title('Summer lgm (JJA)')
saveas(fig,'tas_lgm_summer','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(metaAnoms.tas.lgm(:,:,9:11),3))); shading flat; colorbar;
title('Autumn lgm (SON)')
saveas(fig,'tas_lgm_autumn','jpeg')
close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
d2 = metaAnoms.tmin.midH(:,:,12) + metaAnoms.tmin.midH(:,:,1) + metaAnoms.tmin.midH(:,:,2); d2 = d2./3;
pcolor(flipud(d2)); shading flat; colorbar;
title('Winter midH (DJF)')
saveas(fig,'tmin_midH_winter','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(metaAnoms.tmin.midH(:,:,2:5),3))); shading flat; colorbar;
title('Spring midH (MAM)')
saveas(fig,'tmin_midH_spring','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(metaAnoms.tmin.midH(:,:,6:8),3))); shading flat; colorbar;
title('Summer midH (JJA)')
saveas(fig,'tmin_midH_summer','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(metaAnoms.tmin.midH(:,:,9:11),3))); shading flat; colorbar;
title('Autumn midH (SON)')
saveas(fig,'tmin_midH_autumn','jpeg')
close all
%%

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
d3 = metaAnoms.tmin.lgm(:,:,12) + metaAnoms.tmin.lgm(:,:,1) + metaAnoms.tmin.lgm(:,:,2); d3 = d3./3;
pcolor(flipud(d3)); shading flat; colorbar;
title('Winter lgm (DJF)')
saveas(fig,'tmin_lgm_winter','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(metaAnoms.tmin.lgm(:,:,2:5),3))); shading flat; colorbar;
title('Spring lgm (MAM)')
saveas(fig,'tmin_lgm_spring','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(metaAnoms.tmin.lgm(:,:,6:8),3))); shading flat; colorbar;
title('Summer lgm (JJA)')
saveas(fig,'tmin_lgm_summer','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(metaAnoms.tmin.lgm(:,:,9:11),3))); shading flat; colorbar;
title('Autumn lgm (SON)')
saveas(fig,'tmin_lgm_autumn','jpeg')
close all


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure()
set(fig,'Position',[0 0 1400 1900]);
d2 = metaAnoms.tmax.midH(:,:,12) + metaAnoms.tmax.midH(:,:,1) + metaAnoms.tmax.midH(:,:,2); d2 = d2./3;
pcolor(flipud(d2)); shading flat; colorbar;
title('Winter midH (DJF)')
saveas(fig,'tmax_midH_winter','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(metaAnoms.tmax.midH(:,:,2:5),3))); shading flat; colorbar;
title('Spring midH (MAM)')
saveas(fig,'tmax_midH_spring','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(metaAnoms.tmax.midH(:,:,6:8),3))); shading flat; colorbar;
title('Summer midH (JJA)')
saveas(fig,'tmax_midH_summer','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(metaAnoms.tmax.midH(:,:,9:11),3))); shading flat; colorbar;
title('Autumn midH (SON)')
saveas(fig,'tas_midH_autumn','jpeg')
close all

%%

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
d3 = metaAnoms.tmax.lgm(:,:,12) + metaAnoms.tmax.lgm(:,:,1) + metaAnoms.tmax.lgm(:,:,2); d3 = d3./3;
pcolor(flipud(d3)); shading flat; colorbar;
title('Winter lgm (DJF)')
saveas(fig,'tmax_lgm_winter','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(metaAnoms.tmax.lgm(:,:,2:5),3))); shading flat; colorbar;
title('Spring lgm (MAM)')
saveas(fig,'tmax_lgm_spring','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(metaAnoms.tmax.lgm(:,:,6:8),3))); shading flat; colorbar;
title('Summer lgm (JJA)')
saveas(fig,'tmax_lgm_summer','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(metaAnoms.tmax.lgm(:,:,9:11),3))); shading flat; colorbar;
title('Autumn lgm (SON)')
saveas(fig,'tmax_lgm_autumn','jpeg')
close all


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
d2 = metaAnoms.precip.midH(:,:,12) + metaAnoms.precip.midH(:,:,1) + metaAnoms.precip.midH(:,:,2); d2 = d2./3;
pcolor(flipud(d2)); shading flat; colorbar;
title('Winter midH (DJF)')
saveas(fig,'precip_midH_winter','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(metaAnoms.precip.midH(:,:,2:5),3))); shading flat; colorbar;
title('Spring midH (MAM)')
saveas(fig,'precip_midH_spring','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(metaAnoms.precip.midH(:,:,6:8),3))); shading flat; colorbar;
title('Summer midH (JJA)')
saveas(fig,'precip_midH_summer','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(metaAnoms.precip.midH(:,:,9:11),3))); shading flat; colorbar;
title('Autumn midH (SON)')
saveas(fig,'precip_midH_autumn','jpeg')
close all

%%

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
d3 = metaAnoms.precip.lgm(:,:,12) + metaAnoms.precip.lgm(:,:,1) + metaAnoms.precip.lgm(:,:,2); d3 = d3./3;
pcolor(flipud(d3)); shading flat; colorbar;
title('Winter lgm (DJF)')
saveas(fig,'precip_lgm_winter','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(metaAnoms.precip.lgm(:,:,2:5),3))); shading flat; colorbar;
title('Spring lgm (MAM)')
saveas(fig,'precip_lgm_spring','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(metaAnoms.precip.lgm(:,:,6:8),3))); shading flat; colorbar;
title('Summer lgm (JJA)')
saveas(fig,'precip_lgm_summer','jpeg')
close all

fig = figure()
set(fig,'Position',[0 0 1400 1900]);
pcolor(flipud(mean(metaAnoms.precip.lgm(:,:,9:11),3))); shading flat; colorbar;
title('Autumn lgm (SON)')
saveas(fig,'precip_lgm_autumn','jpeg')
close all

