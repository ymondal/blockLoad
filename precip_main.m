%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% NAME: precip_main.m
%% PROJECT: Bias-Corrected Spatial Disaggregation
%% AUTHOR: Yugarshi Mondal
%% DESCRIPTION: This script bias corrects lgm and midHolocene GCM precipitation records.
%% INPUTS: prStack (GCM stacks), boxBorder (region to interpolate), region (for savePath
%%		reference), inputDataPath (where to look for data), CONUSrun (runNumber)
%% OUTPUTS: - none -
%%
%% HISTORY:
%% YM 06/04/2013 -- Created

function precip_main(prStack,boxBorder,region,inputDataPath,CONUSrun)

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
	fileName1 = strcat(savePath,'PRECIP_',sprintf('%3.3d',boxBorder(3)/9),'_M',sprintf('%2.2d',prStack.month),'.mat');
	d = strcat('ls',{' '},fileName1,'&>/dev/null');
	if system(d{1}) == 0
		disp(strcat(fileName1,' already exists, moving on '))
		return
	end

	%% 2A. Interpolate Masks
	%% mask = interpMask(prStack.lat,prStack.lon,prStack.glacierMask,boxBorder);

	%% 2B. Create Interpolated GCM on boxBorder region
	histBlock = stackBlock(prStack.lat,prStack.lon,prStack.hist,boxBorder);
	lgmBlock = stackBlock(prStack.lat,prStack.lon,prStack.lgm,boxBorder);
	midHBlock = stackBlock(prStack.lat,prStack.lon,prStack.midH,boxBorder);

	%% 2C. Subset observtions (PRISM) to boxBorder
	obsStack = obsLoad(strcat(inputDataPath.obs,'PPT_345/'),boxBorder,prStack.month);

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%% QUANTILE MATCHING
	%% 1. Perform Quantile Matching on every grid point testStack.

	allRows = boxBorder(1,3)-boxBorder(1,2)+1;

	precipPart = struct('lgm',[],'midH',[],'obs',[]);
	precipPart.lgm = struct('mean',[],'std',[],'nanHandled',[]);
	precipPart.midH = struct('mean',[],'std',[],'nanHandled',[]);

	%isMasked = struct('hist',[],'lgm',[],'midH',[]);

	for row = 1:allRows
		for col = 1:(boxBorder(1,5)-boxBorder(1,4)+1)

			%isMasked.lgm = mask.lgm(row,col); isMasked.hist = mask.hist(row,col); isMasked.midH = mask.midH(row,col);

			[precipPart.lgm.mean(row,col), precipPart.midH.mean(row,col),precipPart.lgm.std(row,col),precipPart.midH.std(row,col),...
				precipPart.lgm.nanHandled(row,col),precipPart.midH.nanHandled(row,col)] = ... 
				quantileMatch(obsStack(row,col,:),histBlock(row,col,:),lgmBlock(row,col,:),midHBlock(row,col,:),5);

		end

	end

	precipPart.obs = mean(obsStack,3);
	save(strcat(savePath,'PRECIP_',sprintf('%3.3d',boxBorder(3)/9),'_M',sprintf('%2.2d',prStack.month),'.mat'),'precipPart','boxBorder','inputDataPath')

end
