%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% NAME: main.m
%% PROJECT: MVZ Downscaling
%% AUTHOR: Yugarshi Mondal
%% DESCRIPTION: This script is meant to be run a cluster of 5 c3.xlarge EC2 machines. A compiled
%%		version of this script runs on each node -- one for each month. 4 months are run
%%		at once. Each node runs 30 threads -- 3 versions of this code run on different parts
%%		of the US.
%% INPUTS: month -- month to downscale, parStart -- section to start with [1-345],
%%		parEnd -- section toend with [1-345]
%% OUTPUTS: Bias Corrected Precip and Temperature on subsections on CONUS.
%% NOTES: THIS SCRIPT ASSUMES OBSERVATIONS HAVE BEEN PREPROCESSED TO INTO 345 BLOCKS.
%%
%% HISTORY:
%% YM 07/15/2013 -- Created

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MAIN SHELL-ROUTINE // This routine calls others to do its work
%% 1. Define Region of Interest: Call createBox, the parameters in this routine
%%	are shared amongst many routines. The define the region of interest.
%% 2. Run BCSD on Region

function main(month,parStart,parEnd)

	parStart = str2num(parStart)
	parEnd = str2num(parEnd)
	monthLoop = str2num(month)

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%% 1. Define Region
	%% createBox(lonWest,lonEast,latNorth,latSouth,testRunNum)
	%% runNum = 0; boxBorder = createBox(-124.7,-111.14,49.23,31.34,runNum); region = 'CONUStest'
	runNum = 10; region = 'CONUS' % Full Computation over some rows
	%% runNum = 0; parStart = 1; parEnd = 345; region = 'CONUS' % Full Computation
	%% runNum = 1; boxBorder = createBox(-119.5,-118.5,38.5,37.5,runNum); region = 'monoLakeCA' %% - mono lake (38°N, 119°W)
	%% runNum = 1; boxBorder = createBox(-124.7,-123.7,48.5,47.5,runNum); region = 'forksWA' %% forks, WA (48°N,124.4°W)
	%% runNum = 1; boxBorder = createBox(-119.4,-117.4,38.36,36.36,runNum); region = 'bishopCA' %% - bishop, CA (37.36N,118.39W)
	%% runNum = 7; boxBorder = createBox(-118.39,-117.38,37.67,37.36,runNum); region = 'monoLakeCA_sub' %% - mono lake (38°N, 119°W)
	%% runNum = 1; boxBorder = createBox(-113.5,-112.5,46,45,runNum); region = 'AnacondaMO' %% ice sheet test
	%% runNum = 1; boxBorder = createBox(-106.2, -105.2,38,37,runNum); region = 'AlamosaCO' %% dry test
	%% runNum = 1; boxBorder = createBox(-121,-119,36,34,runNum); region = 'SantaMariaCA' %% dry test
	%% runNum = 1; boxBorder = createBox(-91.5,-90.5,31,30,runNum); region = 'BatonRougeLA' %% wet test
	%% runNum = 2; boxBorder = createBox(-89.25,-88.25,41,40,runNum); region = 'BloomingtonIL' %% ice sheet test
	%% runNum = 3; boxBorder = createBox(-122.7586,-121.7586, 37.5881, 36.5881,runNum); region = 'NorthSantaCruz'; %% for Alicia

	if monthLoop >= 1 && monthLoop <= 4
		nodeLag = 1;
	elseif monthLoop >= 5 && monthLoop <= 8
		nodeLag = -3;
	else
		nodeLag = -7;
	end

	parDiff = parEnd - parStart;
	boxBorder = [runNum, 9*(parStart-1) + 1, 9*parEnd,1,7025];

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%% 2. Define Path Struct
	global dataPath
	dataPath = struct('obs','/home/data/obs/PRISM_345/','gcm','/home/data/gcm/ccsm4/', ...
	'save','/home/data/blockLoad/','main','/home/ubuntu/files/code/bcsd/blockLoad/testData/CONUS/', ...
	'matlabRoot','/home/matlabFiles'); %% bigCrunch

	%% dataPath = struct('obs','/Users/yoshi/PRISM_345/','gcm','/Volumes/data/data/GCM/CCSM4/','save','/Users/yoshi/Code/2013_keck/blockLoad/'); %% home

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%% 3. BCSD

	global prStack
	prStack = fileLoader('pr',dataPath,monthLoop)
	%% Percip in mm/month (sec => mins => hours => days/month)
	dayPerMonth = [31,28,31,30,31,30,31,31,30,31,30,31];
    	prStack.hist = prStack.hist * 24 * 60 * 60 * dayPerMonth(monthLoop); prStack.lgm = prStack.lgm * 24 * 60 * 60 * dayPerMonth(monthLoop);
	prStack.midH = prStack.midH * 24 * 60 * 60 * dayPerMonth(monthLoop);

	clusterDirectives(monthLoop,boxBorder,dataPath,parDiff,runNum,nodeLag);

	% clear boxBorder so it can be loaded by threads
	clear boxBorder

	%% PRECIPITATION
        disp('Full Computation: Starting Preciptation BCSD')

        matlabpool open local 10

	parfor i = parStart:parEnd
        	tic
                boxBorder = [0, 9*(i-1) + 1, 9*i,1,7025];
		precip_main(prStack,boxBorder,region,dataPath,runNum)
                toc
        end

        matlabpool close

	%% TEMPERATURE
	clear prStack
	global tminStack tasStack tmaxStack
	tminStack = fileLoader('tasmin',dataPath,monthLoop)
	tasStack = fileLoader('tas',dataPath,monthLoop)
	tmaxStack = fileLoader('tasmax',dataPath,monthLoop)
	tminStack.hist = tminStack.hist - 273.15; tminStack.lgm = tminStack.lgm - 273.15; tminStack.midH = tminStack.midH - 273.15;
	tasStack.hist = tasStack.hist - 273.15; tasStack.lgm = tasStack.lgm - 273.15; tasStack.midH = tasStack.midH - 273.15;
	tmaxStack.hist = tmaxStack.hist - 273.15; tmaxStack.lgm = tmaxStack.lgm - 273.15; tmaxStack.midH = tmaxStack.midH - 273.15;

	disp('Full Computation: Starting Temperature BCSD')
	matlabpool open local 10

	parfor i = parStart:parEnd
		tic
		boxBorder = [0, 9*(i-1) + 1, 9*i,1,7025];
		temp_main(dataPath,boxBorder,tminStack,tmaxStack,tasStack,region)
		toc
	end

	matlabpool close

	disp('Month complete')
	monthLoop

	function clusterDirectives(monthLoop,boxBorder,dataPath,parDiff,runNum,nodeLag)
		% This recusrively calls main and runs it on other nodes
		% It assumes that starcluster manages the cluster and so uses its naming convection
		clusterSubmit = strcat('qsub -q all.q@node0',sprintf('%2.2d',monthLoop+nodeLag),{' '},dataPath.save,'compiledCode/run_main_mod.sh',{' '},dataPath.matlabRoot,...
			{' '},int2str(monthLoop+1),{' '},int2str(parStart),{' '},int2str(parEnd))
		system(clusterSubmit{1});

	end

end
