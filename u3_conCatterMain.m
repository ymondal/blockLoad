%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% NAME: precip_main.m
%% PROJECT: Bias-Corrected Spatial Disaggregation
%% AUTHOR: Yugarshi Mondal
%% DESCRIPTION: This script bias corrects lgm and midHolocene GCM preciptitation records.
%% INPUTS: - none -
%% OUTPUTS: - none -
%%
%% HISTORY:
%% YM 06/04/2013 -- Created
%% 
function conCatterMain(isTemp)

	runNum = 10;
	monthsRun = 12; %2
	sectionStart = 1; %141
	sectionEnd = 345; %171

	dataPath.save = '/home/data/blockLoad/';
	%dataPath.save = '/Users/yoshi/Code/2013_keck/blockLoad/';

	%region = 'CONUS';
	region = 'CONUS/run_10';

	savePath = strcat(dataPath.save,'testData/CONUS/run_10/run_10_raw/');
	plotPath = strcat(dataPath.save,'pics/',region,'/');
	sectionTot = sectionEnd - sectionStart + 1;

	if isTemp == 1

		dirStruct = dir(strcat(savePath,'TEMPERATURE_*.mat'));
		dirStruct = reshape(dirStruct,monthsRun,sectionTot)';
		
		tmin = struct('lgm',[],'midH',[],'obs',[]);
		tmin.lgm = struct('mean',[],'std',[]);
		tmin.midH = struct('mean',[],'std',[]);
		tmax = struct('lgm',[],'midH',[],'obs',[]);
		tmax.lgm = struct('mean',[],'std',[]);
		tmax.midH = struct('mean',[],'std',[]);
		tas = struct('lgm',[],'midH',[],'obs',[]);
		tas.lgm = struct('mean',[],'std',[]);
		tas.midH = struct('mean',[],'std',[]);

		tminM = struct('lgm',[],'midH',[],'obs',[]);
		tminM.lgm = struct('mean',[],'std',[]);
		tminM.midH = struct('mean',[],'std',[]);
		tmaxM = struct('lgm',[],'midH',[],'obs',[]);
		tmaxM.lgm = struct('mean',[],'std',[]);
		tmaxM.midH = struct('mean',[],'std',[]);
		tasM = struct('lgm',[],'midH',[],'obs',[]);
		tasM.lgm = struct('mean',[],'std',[]);
		tasM.midH = struct('mean',[],'std',[]);
		
		for month = 1:monthsRun
			for i = 1:sectionTot
			
				load(strcat(savePath,dirStruct(i,month).name))
			
				tminM.lgm.mean = cat(1,tminM.lgm.mean,tminPart.lgm.mean);
				tminM.lgm.std = cat(1,tminM.lgm.std,tminPart.lgm.std);
				tminM.midH.mean = cat(1,tminM.midH.mean,tminPart.midH.mean);
				tminM.midH.std = cat(1,tminM.midH.std,tminPart.midH.std);
				tminM.obs = cat(1,tminM.obs,tminPart.obs);

				tmaxM.lgm.mean = cat(1,tmaxM.lgm.mean,tmaxPart.lgm.mean);
				tmaxM.lgm.std = cat(1,tmaxM.lgm.std,tmaxPart.lgm.std);
				tmaxM.midH.mean = cat(1,tmaxM.midH.mean,tmaxPart.midH.mean);
				tmaxM.midH.std = cat(1,tmaxM.midH.std,tmaxPart.midH.std);
				tmaxM.obs = cat(1,tmaxM.obs,tmaxPart.obs);

				tasM.lgm.mean = cat(1,tasM.lgm.mean,tasPart.lgm.mean);
				tasM.lgm.std = cat(1,tasM.lgm.std,tasPart.lgm.std);
				tasM.midH.mean = cat(1,tasM.midH.mean,tasPart.midH.mean);
				tasM.midH.std = cat(1,tasM.midH.std,tasPart.midH.std);
				tasM.obs = cat(1,tasM.obs,tasPart.obs);

			end
			
			tmin.lgm.mean = cat(3,tmin.lgm.mean,tminM.lgm.mean);
			tmin.lgm.std = cat(3,tmin.lgm.std,tminM.lgm.std);
			tmin.midH.mean = cat(3,tmin.midH.mean,tminM.midH.mean);
			tmin.midH.std = cat(3,tmin.midH.std,tminM.midH.std);
			tmin.obs = cat(3,tmin.obs,tminM.obs);

			tmax.lgm.mean = cat(3,tmax.lgm.mean,tmaxM.lgm.mean);
			tmax.lgm.std = cat(3,tmax.lgm.std,tmaxM.lgm.std);
			tmax.midH.mean = cat(3,tmax.midH.mean,tmaxM.midH.mean);
			tmax.midH.std = cat(3,tmax.midH.std,tmaxM.midH.std);
			tmax.obs = cat(3,tmax.obs,tmaxM.obs);

			tas.lgm.mean = cat(3,tas.lgm.mean,tasM.lgm.mean);
			tas.lgm.std = cat(3,tas.lgm.std,tasM.lgm.std);
			%tas.midH.mean = cat(3,tas.midH.mean,tasM.midH.mean);
			%tas.midH.std = cat(3,tas.midH.std,tasM.midH.std);
			tas.obs = cat(3,tas.obs,tasM.obs);

			arcgridwriteCustom(strcat(savePath,'tmin_lgm_mean_M',sprintf('%2.2d',month),'.asc'),tminM.lgm.mean,boxBorder)
			arcgridwriteCustom(strcat(savePath,'tmin_midH_mean_M',sprintf('%2.2d',month),'.asc'),tminM.midH.mean,boxBorder)
			arcgridwriteCustom(strcat(savePath,'tmin_obs_mean_M',sprintf('%2.2d',month),'.asc'),tminM.obs,boxBorder)
			arcgridwriteCustom(strcat(savePath,'tmax_lgm_mean_M',sprintf('%2.2d',month),'.asc'),tmaxM.lgm.mean,boxBorder)
			arcgridwriteCustom(strcat(savePath,'tmax_midH_mean_M',sprintf('%2.2d',month),'.asc'),tmaxM.midH.mean,boxBorder)
			arcgridwriteCustom(strcat(savePath,'tmax_obs_mean_M',sprintf('%2.2d',month),'.asc'),tmaxM.obs,boxBorder)
			arcgridwriteCustom(strcat(savePath,'tas_lgm_mean_M',sprintf('%2.2d',month),'.asc'),tasM.lgm.mean,boxBorder)
			arcgridwriteCustom(strcat(savePath,'tas_midH_mean_M',sprintf('%2.2d',month),'.asc'),tasM.midH.mean,boxBorder)
			arcgridwriteCustom(strcat(savePath,'tas_obs_mean_M',sprintf('%2.2d',month),'.asc'),tasM.obs,boxBorder)
			
			tminM = struct('lgm',[],'midH',[],'obs',[]);
			tminM.lgm = struct('mean',[],'std',[]);
			tminM.midH = struct('mean',[],'std',[]);
			tmaxM = struct('lgm',[],'midH',[],'obs',[]);
			tmaxM.lgm = struct('mean',[],'std',[]);
			tmaxM.midH = struct('mean',[],'std',[]);
			tasM = struct('lgm',[],'midH',[],'obs',[]);
			tasM.lgm = struct('mean',[],'std',[]);
			tasM.midH = struct('mean',[],'std',[]);

		end

		zip(strcat(savePath,'TEMPERATURE_',int2str(runNum),'.zip'),strcat(savePath,'*.asc'))
	%	system(['rm ' strcat(savePath,'*.asc')])
	%	save(strcat(savePath,'TEMPERATURE_',int2str(runNum),'.mat'),'tas','tmin','tmax','boxBorder','plotPath','region','-v7.3')
%		plotter(tmin.lgm.mean,tmin.midH.mean,tmin.obs,boxBorder,'TMIN',plotPath,region)
%		plotter(tmax.lgm.mean,tmax.midH.mean,tmax.obs,boxBorder,'TMAX',plotPath,region)
%		plotter(tas.lgm.mean,tas.midH.mean,tas.obs,boxBorder,'TAS',plotPath,region)
%		system(['rm ' strcat(savePath,'TEMPERATURE_*_M*')])
%		system(['rm /home/data/blockLoad/fileLocker/tempData.mat'])

	else

		dirStruct = dir(strcat(savePath,'PRECIP_*.mat'));
		dirStruct = reshape(dirStruct,monthsRun,sectionTot)';

		precip = struct('lgm',[],'midH',[],'obs',[]);
		precip.lgm = struct('mean',[],'std',[],'nanHandled',[]);
		precip.midH = struct('mean',[],'std',[],'nanHandled',[]);

		precipM = struct('lgm',[],'midH',[],'obs',[]);
		precipM.lgm = struct('mean',[],'std',[],'nanHandled',[]);
		precipM.midH = struct('mean',[],'std',[],'nanHandled',[]);
		
		for month = 1:monthsRun
			for i = 1:sectionTot
			
				load(strcat(savePath,dirStruct(i,month).name))
			
				precipM.lgm.mean = cat(1,precipM.lgm.mean,precipPart.lgm.mean);
				precipM.lgm.std = cat(1,precipM.lgm.std,precipPart.lgm.std);
%				precipM.lgm.nanHandled = cat(1,precipM.lgm.nanHandled,precipPart.lgm.nanHandled);
				precipM.midH.mean = cat(1,precipM.midH.mean,precipPart.midH.mean);
				precipM.midH.std = cat(1,precipM.midH.std,precipPart.midH.std);
%				precipM.midH.nanHandled = cat(1,precipM.midH.nanHandled,precipPart.midH.nanHandled);
				precipM.obs = cat(1,precipM.obs,precipPart.obs);

			end
			
			precip.lgm.mean = cat(3,precip.lgm.mean,precipM.lgm.mean);
			precip.lgm.std = cat(3,precip.lgm.std,precipM.lgm.std);
%			precip.lgm.nanHandled = cat(3,precip.lgm.nanHandled,precipM.lgm.nanHandled);
			precip.midH.mean = cat(3,precip.midH.mean,precipM.midH.mean);
			precip.midH.std = cat(3,precip.midH.std,precipM.midH.std);
%			precip.midH.nanHandled = cat(3,precip.midH.nanHandled,precipM.midH.nanHandled);
			precip.obs = cat(3,precip.obs,precipM.obs);

			arcgridwriteCustom(strcat(savePath,'precip_lgm_mean_M',sprintf('%2.2d',month),'.asc'),precipM.lgm.mean,boxBorder)
			arcgridwriteCustom(strcat(savePath,'precip_midH_mean_M',sprintf('%2.2d',month),'.asc'),precipM.midH.mean,boxBorder)
			arcgridwriteCustom(strcat(savePath,'precip_obs_mean_M',sprintf('%2.2d',month),'.asc'),precipM.obs,boxBorder)
%			arcgridwriteCustom(strcat(savePath,'precip_lgm_nanHandled_M',sprintf('%2.2d',month),'.asc'),precipM.lgm.nanHandled,boxBorder)
%                        arcgridwriteCustom(strcat(savePath,'precip_midH_nanHandled_M',sprintf('%2.2d',month),'.asc'),precipM.midH.nanHandled,boxBorder)
			
			precipM = struct('lgm',[],'midH',[],'obs',[]);
			precipM.lgm = struct('mean',[],'std',[],'nanHandled',[]);
			precipM.midH = struct('mean',[],'std',[],'nanHandled',[]);
		end

		zip(strcat(savePath,'PRECIP_',int2str(runNum),'.zip'),strcat(savePath,'*.asc'))
		%system(['rm ' strcat(savePath,'*.asc')])

		save(strcat(savePath,'PRECIP_',int2str(runNum),'.mat'),'precip','boxBorder','plotPath','region','-v7.3')
%		plotter(precip.lgm.mean,precip.midH.mean,precip.obs,boxBorder,'PPT',plotPath,region)
%		system(['rm ' strcat(savePath,'PRECIP_*_M*')])

	end
end
