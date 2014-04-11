%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% NAME: fileLoader.m
%% PROJECT: Bias-Corrected Spatial Disaggregation
%% AUTHOR: Yugarshi Mondal
%% DESCRIPTION: This script loads uninterpolated model GCM files into memory
%% INPUTS: ncFilesToLoad (variable to fetch), Pwdz (paths struct), 
%%		monthIdx (what month to subset out)
%% OUTPUTS: files (struct with loaded GCM data)
%%
%% HISTORY:
%% YM 06/04/2013 -- Created

function files = fileLoader(ncFilesToLoad,Pwdz,monthIdx)

	lockPath = strcat(Pwdz.save,'fileLocker/');

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%% LOAD ALL DATA
	%% 1. Load GCM Historical Data
	%% 2. Load Lgm and MidH Data
	%% 3. Save lats and lons

	%% 1. Load historical Runs / Concatenate matrix
	ncFileStruct_hist = dir(strcat(Pwdz.gcm,ncFilesToLoad,'_*_historical_*.nc'));
	histStack = [];
	for i = 1:length(ncFileStruct_hist)
		getLock(lockPath,ncFileStruct_hist(i).name)
		tempStack = ncread(strcat(Pwdz.gcm,ncFileStruct_hist(i).name),ncFilesToLoad);
		releaseLock(lockPath,ncFileStruct_hist(i).name)
		tempStack = reshape(tempStack,size(tempStack,1),size(tempStack,2),12,size(tempStack,3)/12);
		tempStack = squeeze(tempStack(:,:,monthIdx,:));
		histStack = cat(3,histStack,tempStack);
	end

	%% 2. Find and load midH and lgm records
	midHStack = []; clear tempStack;
	ncFileStruct_midH = dir(strcat(Pwdz.gcm,ncFilesToLoad,'_*_midHolocene_*.nc'));
	for i = 1:length(ncFileStruct_midH)

             	getLock(lockPath,ncFileStruct_midH(i).name) 
		tempStack = ncread(strcat(Pwdz.gcm,ncFileStruct_midH(i).name),ncFilesToLoad);
		releaseLock(lockPath,ncFileStruct_midH(i).name)
		tempStack = reshape(tempStack,size(tempStack,1),size(tempStack,2),12,size(tempStack,3)/12);
		tempStack = squeeze(tempStack(:,:,monthIdx,:));
		midHStack = cat(3,midHStack,tempStack);
	end

	lgmStack = []; clear tempStack;
	ncFileStruct_lgm = dir(strcat(Pwdz.gcm,ncFilesToLoad,'_*_lgm_*.nc'));
	for i = 1:length(ncFileStruct_lgm)

		getLock(lockPath,ncFileStruct_lgm(i).name)
		tempStack = ncread(strcat(Pwdz.gcm,ncFileStruct_lgm(i).name),ncFilesToLoad);
                releaseLock(lockPath,ncFileStruct_lgm(i).name);
		tempStack = reshape(tempStack,size(tempStack,1),size(tempStack,2),12,size(tempStack,3)/12);
		tempStack = squeeze(tempStack(:,:,monthIdx,:));
		lgmStack = cat(3,lgmStack,tempStack);

	end
	

	%% 3. Save lat and lons	
	ncFileStruct_hist = dir(strcat(Pwdz.gcm,ncFilesToLoad,'_*_historical_*.nc'));
	getLock(lockPath,ncFileStruct_hist(1).name)
	gcm_lat = ncread(strcat(Pwdz.gcm,ncFileStruct_hist(1).name), 'lat');
	gcm_lon = ncread(strcat(Pwdz.gcm,ncFileStruct_hist(1).name), 'lon');
	releaseLock(lockPath,ncFileStruct_hist(1).name);

	%% 4. Load Glacier Masks (depricated functionality)
	%masks = struct('lgm',[],'midH',[],'hist',[]);
	%getLock(lockPath,'masks')
	%masks.hist = ncread(strcat(Pwdz.gcm,'sftgif_fx_CCSM4_historical_r0i0p0.nc'),'sftgif');
	%masks.lgm = ncread(strcat(Pwdz.gcm,'sftgif_fx_CCSM4_lgm_r0i0p0.nc'),'sftgif');
	%masks.midH = ncread(strcat(Pwdz.gcm,'sftgif_fx_CCSM4_midHolocene_r0i0p0.nc'),'sftgif');
	%releaseLock(lockPath,'masks')
	masks = 0;

	files = struct('hist',histStack,'lgm',lgmStack,'midH',midHStack,'lat',gcm_lat,'lon',gcm_lon,'glacierMask',masks,'month',monthIdx);


end
