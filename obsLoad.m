%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% NAME: obsLoad.m
%% PROJECT: MVZ Downscaling
%% AUTHOR: Yugarshi Mondal
%% DESCRIPTION: Load observation data after its been preprocessed
%% INPUTS: filePath (where to find files), boxLatLon (bounding region), monthIdx (which months
%%		to fetch)
%% OUTPUTS: obsStack (the stack of observations for a given month)
%%
%% HISTORY:
%% YM 06/03/2013 -- Created

function obsStack = obsLoad(filePath,boxLatLon,monthIdx)

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%% BUILD OBS STACK
	%% 1. Initialize
	%% 2. Load Observations
	%% 3. Correct the Units

	%% 1. Initialize
	lockPath = '/home/data/blockLoad/fileLocker/';
	obsFileName = strcat(filePath,'*.mat');
	obsFileStruct = dir(obsFileName);
	obsStack = [];

	%% 2. Load Data
	getLock(lockPath,obsFileStruct(boxLatLon(3)/9).name)
	load(strcat(filePath,obsFileStruct(boxLatLon(3)/9).name))
	releaseLock(lockPath,obsFileStruct(boxLatLon(3)/9).name)
	obsStack = obsBlock;

	%% 3. Reform obsStack and modify units
	%% Units: Ppt in mm/month, Temp in Celcius -- both are divide by 100
	obsStack = obsStack/100;
	obsSize = size(obsStack);
	obsStack = reshape(obsStack,obsSize(1),obsSize(2),12,obsSize(3)/12);
	obsStack = squeeze(obsStack(:,:,monthIdx,:));
