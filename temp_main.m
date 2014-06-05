%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% NAME: temp_main.m
%% PROJECT: Bias-Corrected Spatial Disaggregation
%% AUTHOR: Yugarshi Mondal
%% DESCRIPTION: This script bias corrects lgm and midHolocene GCM temperature records.
%% INPUTS: tas/tmin/tmaxStack (GCM stacks), boxBorder (region to interpolate), region (for savePath
%%		reference), inputDataPath (where to look for data), CONUSrun (runNumber)
%% OUTPUTS: - none -
%%
%% HISTORY:
%% YM 06/04/2013 -- Created

function temp_main(inputDataPath,boxBorder,tminStack,tmaxStack,tasStack,region)

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%% INTERPOLATE ALL SECTIONS
	%% 1. Check that the file being created doesn't already exist. It may if you
	%%	running spot clusters on EC2 and the file has already been created
	%% 2. Interpolate GCM on boxBorder region
	%% 	A. Interpolate Mask (depricated functionality)
	%%	B. Interpolate GCM data on boxBorder
	%%	C. Subset Observations to boxBorder

	%% 1. Check if file exists
	savePath = strcat(inputDataPath.save,'testData/',region,'/');
	fileName1 = strcat(savePath,'TEMPERATURE_',sprintf('%3.3d',boxBorder(3)/9),'_M',sprintf('%2.2d',tasStack.month),'.mat');
	d =  strcat('ls',{' '},fileName1,'&>/dev/null');
	if system(d{1}) == 0
		disp(strcat(fileName1,' already exists, moving on'))
		return
	end

	%% 2A. Interpolate Masks (depricated)
	%mask = interpMask(tasStack.lat,tasStack.lon,tasStack.glacierMask,boxBorder);

	%% 2B. Create Interpolated GCM on boxBorder region
	tas_histBlock = stackBlock(tasStack.lat,tasStack.lon,tasStack.hist,boxBorder);
	tas_lgmBlock = stackBlock(tasStack.lat,tasStack.lon,tasStack.lgm,boxBorder);
	tas_midHBlock = stackBlock(tasStack.lat,tasStack.lon,tasStack.midH,boxBorder);

	tasmin_histBlock = stackBlock(tminStack.lat,tminStack.lon,tminStack.hist,boxBorder);
	tasmin_lgmBlock = stackBlock(tminStack.lat,tminStack.lon,tminStack.lgm,boxBorder);
	tasmin_midHBlock = stackBlock(tminStack.lat,tminStack.lon,tminStack.midH,boxBorder);

	tasmax_histBlock = stackBlock(tmaxStack.lat,tmaxStack.lon,tmaxStack.hist,boxBorder);
	tasmax_lgmBlock = stackBlock(tmaxStack.lat,tmaxStack.lon,tmaxStack.lgm,boxBorder);
	tasmax_midHBlock = stackBlock(tmaxStack.lat,tmaxStack.lon,tmaxStack.midH,boxBorder);

	%% 2C. Subset observtions (PRISM) to boxBorder
	tmax_obsStack = obsLoad(strcat(inputDataPath.obs,'TMAX_345/'),boxBorder,tasStack.month);
	tmin_obsStack = obsLoad(strcat(inputDataPath.obs,'TMIN_345/'),boxBorder,tasStack.month);

	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%% QUANTILE MATCHING
	%% 1. Perform Quantile Matching on every grid point testStack.
	%% 2. Save

	allRows = boxBorder(1,3)-boxBorder(1,2)+1;

	tminPart = struct('lgm',[],'midH',[],'obs',[]);
	tminPart.lgm = struct('mean',[],'std',[]);
	tminPart.midH = struct('mean',[],'std',[]);
	tmaxPart = struct('lgm',[],'midH',[],'obs',[]);
	tmaxPart.lgm = struct('mean',[],'std',[]);
	tmaxPart.midH = struct('mean',[],'std',[]);
	tasPart = struct('lgm',[],'midH',[],'obs',[]);
	tasPart.lgm = struct('mean',[],'std',[]);
	tasPart.midH = struct('mean',[],'std',[]);

	%isMasked = struct('hist',[],'lgm',[],'midH',[]);


	for row = 1:allRows
		for col = 1:(boxBorder(1,5)-boxBorder(1,4)+1)

			%isMasked.lgm = mask.lgm(row,col); isMasked.hist = mask.hist(row,col); isMasked.midH = mask.midH(row,col);

			dummyTseries = (squeeze(tmin_obsStack(row,col,:)) + squeeze(tmax_obsStack(row,col,:)))./2;
			tasPart.obs(row,col) = mean(dummyTseries);

			[tasPart.lgm.mean(row,col), tasPart.midH.mean(row,col), tasPart.lgm.std(row,col), tasPart.midH.std(row,col), dummy, dummy] = ...
				 quantileMatch(dummyTseries,tas_histBlock(row,col,:), tas_lgmBlock(row,col,:),tas_midHBlock(row,col,:),[]);

			[tminPart.lgm.mean(row,col), tminPart.midH.mean(row,col), tminPart.lgm.std(row,col), tminPart.midH.std(row,col), dummy, dummy] = ... 
				quantileMatch(tmin_obsStack(row,col,:), tasmin_histBlock(row,col,:), tasmin_lgmBlock(row,col,:),tasmin_midHBlock(row,col,:),[]);

			[tmaxPart.lgm.mean(row,col), tmaxPart.midH.mean(row,col), tmaxPart.lgm.std(row,col), tmaxPart.midH.std(row,col), dummy, dummy] = ...
				 quantileMatch(tmax_obsStack(row,col,:), tasmax_histBlock(row,col,:), tasmax_lgmBlock(row,col,:),tasmax_midHBlock(row,col,:),[]);

		end
		
	end

	tminPart.obs = mean(tmin_obsStack,3);
	tmaxPart.obs = mean(tmax_obsStack,3);
	save(strcat(savePath,'TEMPERATURE_',sprintf('%3.3d',boxBorder(3)/9),'_M',sprintf('%2.2d',tasStack.month),'.mat'),'tasPart','tminPart','tmaxPart','boxBorder','inputDataPath')	

end
