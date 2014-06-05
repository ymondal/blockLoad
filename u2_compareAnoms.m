%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% NAME: u2_compareAnoms
%% PROJECT: MVZ Downscaling
%% AUTHOR: Yugarshi Mondal
%% DESCRIPTION: compares the anomalies of adjusted model projected and model projected fields
%% 		(ie creates metaAnomalies)
%% INPUTS: - none -
%% OUTPUTS: - none -
%%
%% HISTORY:
%% YM 06/04/2013 -- Created

function compareAnoms

	dataPath = struct('obs','/home/data/obs/PRISM_345/','gcm','/home/data/gcm/ccsm4/', 'save','/home/data/blockLoad/');
	boxBorder = [0,1,3105,1,7025];

	prClimatology = struct('hist',[],'lgm',[],'midH',[],'lat',[],'lon',[]);
	tmaxClimatology = prClimatology; tminClimatology = prClimatology; tasClimatology = prClimatology;

	for monthLoop = 1:12		
		prStack = fileLoader('pr',dataPath,monthLoop)
		dayPerMonth = [31,28,31,30,31,30,31,31,30,31,30,31];
		prStack.hist = prStack.hist * 24 * 60 * 60 * dayPerMonth(monthLoop); prStack.lgm = prStack.lgm * 24 * 60 * 60 * dayPerMonth(monthLoop); prStack.midH = prStack.midH * 24 * 60 * 60 * dayPerMonth(monthLoop);
		prClimatology.hist = cat(3,prClimatology.hist,mean(prStack.hist,3));
		prClimatology.lgm = cat(3,prClimatology.lgm,mean(prStack.lgm,3));
		prClimatology.midH = cat(3,prClimatology.midH,mean(prStack.midH,3));
		prClimatology.lat = prStack.lat;
		prClimatology.lon = prStack.lon;
		clear prStack 
	
		tminStack = fileLoader('tasmin',dataPath,monthLoop)
		tasStack = fileLoader('tas',dataPath,monthLoop)
		tmaxStack = fileLoader('tasmax',dataPath,monthLoop)
		tminStack.hist = tminStack.hist - 273.15; tminStack.lgm = tminStack.lgm - 273.15; tminStack.midH = tminStack.midH - 273.15;
		tasStack.hist = tasStack.hist - 273.15; tasStack.lgm = tasStack.lgm - 273.15; tasStack.midH = tasStack.midH - 273.15;
		tmaxStack.hist = tmaxStack.hist - 273.15; tmaxStack.lgm = tmaxStack.lgm - 273.15; tmaxStack.midH = tmaxStack.midH - 273.15;

                tasClimatology.hist = cat(3,tasClimatology.hist,mean(tasStack.hist,3));
                tasClimatology.lgm = cat(3,tasClimatology.lgm,mean(tasStack.lgm,3));
                tasClimatology.midH = cat(3,tasClimatology.midH,mean(tasStack.midH,3));
		tasClimatology.lat = tasStack.lat; tasClimatology.lon = tasStack.lon;
	
                tmaxClimatology.hist = cat(3,tmaxClimatology.hist,mean(tmaxStack.hist,3));
                tmaxClimatology.lgm = cat(3,tmaxClimatology.lgm,mean(tmaxStack.lgm,3));
                tmaxClimatology.midH = cat(3,tmaxClimatology.midH,mean(tmaxStack.midH,3));
		tmaxClimatology.lat = tmaxStack.lat; tmaxClimatology.lon = tmaxStack.lon;

                tminClimatology.hist = cat(3,tminClimatology.hist,mean(tminStack.hist,3));
                tminClimatology.lgm = cat(3,tminClimatology.lgm,mean(tminStack.lgm,3));
                tminClimatology.midH = cat(3,tminClimatology.midH,mean(tminStack.midH,3));
		tminClimatology.lat = tminStack.lat; tminClimatology.lon = tminStack.lon;
	end

	tempAnoms = temp_comp(dataPath,boxBorder,tminClimatology,tmaxClimatology,tasClimatology);
	precipAnoms = precip_comp(prClimatology,boxBorder,dataPath);

	bcsdPath = strcat(dataPath.save,'testData/CONUS/');
	bcsdAnoms = u2_computeBCSDanoms(bcsdPath);

	tempAnomsFromGCM = tempAnoms; precipAnomsFromGCM = precipAnoms;
	save('/home/ubuntu/data/blockLoad/testData/CONUS/final/Anomalies_F.mat','tempAnomsFromGCM','precipAnomsFromGCM','bcsdAnoms','-v7.3');

        metaAnoms = struct('tas',[],'tmin',[],'tmax',[],'precip',[]);
        metaAnoms.tas = struct('lgm',[],'midH',[]);
        metaAnoms.tmin = metaAnoms.tas; metaAnoms.tmax = metaAnoms.tas;
	metaAnoms.precip = metaAnoms.tas;

	metaAnoms.tas.lgm = tempAnoms.tas.lgm - bcsdAnoms.tas.lgm;
        metaAnoms.tas.midH = tempAnoms.tas.midH - bcsdAnoms.tas.midH;
        metaAnoms.tmin.lgm = tempAnoms.tmin.lgm - bcsdAnoms.tmin.lgm;
        metaAnoms.tmin.midH = tempAnoms.tmin.midH - bcsdAnoms.tmin.midH;
        metaAnoms.tmax.lgm = tempAnoms.tmax.lgm - bcsdAnoms.tmax.lgm;
        metaAnoms.tmax.midH = tempAnoms.tmax.midH - bcsdAnoms.tmax.midH;
        metaAnoms.precip.lgm = precipAnoms.lgm - bcsdAnoms.precip.lgm;
        metaAnoms.precip.midH = precipAnoms.midH - bcsdAnoms.precip.midH;

	save('/home/ubuntu/data/blockLoad/testData/CONUS/final/MetaAnomalies_F.mat','metaAnoms','-v7.3');

	function [anomalies] = precip_comp(prStack,boxBorder,inputDataPath)

                anomalies = struct('lgm',[],'midH',[]);

		histBlock = stackBlock(prStack.lat,prStack.lon,prStack.hist,boxBorder);
		lgmBlock = stackBlock(prStack.lat,prStack.lon,prStack.lgm,boxBorder);
		midHBlock = stackBlock(prStack.lat,prStack.lon,prStack.midH,boxBorder);

		anomalies.lgm = lgmBlock - histBlock;
		anomalies.midH = midHBlock - histBlock;

	end

	function [anomalies] = temp_comp(inputDataPath,boxBorder,tminStack,tmaxStack,tasStack)

		anomalies = struct('tas',[],'tmin',[],'tmax',[]);
		anomalies.tas = struct('lgm',[],'midH',[]);
		anomalies.tmin = anomalies.tas; anomalies.tmax = anomalies.tas;

		tas_histBlock = stackBlock(tasStack.lat,tasStack.lon,tasStack.hist,boxBorder);
		tas_lgmBlock = stackBlock(tasStack.lat,tasStack.lon,tasStack.lgm,boxBorder);
		tas_midHBlock = stackBlock(tasStack.lat,tasStack.lon,tasStack.midH,boxBorder);

		tasmin_histBlock = stackBlock(tminStack.lat,tminStack.lon,tminStack.hist,boxBorder);
		tasmin_lgmBlock = stackBlock(tminStack.lat,tminStack.lon,tminStack.lgm,boxBorder);
		tasmin_midHBlock = stackBlock(tminStack.lat,tminStack.lon,tminStack.midH,boxBorder);

		tasmax_histBlock = stackBlock(tmaxStack.lat,tmaxStack.lon,tmaxStack.hist,boxBorder);
		tasmax_lgmBlock = stackBlock(tmaxStack.lat,tmaxStack.lon,tmaxStack.lgm,boxBorder);
		tasmax_midHBlock = stackBlock(tmaxStack.lat,tmaxStack.lon,tmaxStack.midH,boxBorder);

		anomalies.tas.lgm = tas_lgmBlock - tas_histBlock;
		anomalies.tas.midH = tas_midHBlock - tas_histBlock;
                anomalies.tmin.lgm = tasmin_lgmBlock - tasmin_histBlock;
                anomalies.tmin.midH = tasmin_midHBlock - tasmin_histBlock;
                anomalies.tmax.lgm = tasmax_lgmBlock - tasmax_histBlock;
                anomalies.tmax.midH = tasmax_midHBlock - tasmax_histBlock;

	end

end
