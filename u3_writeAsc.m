%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% NAME: u3_writeAsc.m
%% PROJECT: MVZ Downscaling
%% AUTHOR: Yugarshi Mondal
%% DESCRIPTION: This function takes derived variables computed in u3_biovar.m and saves them
%%		to *.asc
%% INPUTS: varNum (derived variable number), stack (derived variable strcuct),
%%		writeIdx (should additional asc files be written)
%% OUTPUTS: - none -
%%
%% HISTORY:
%% YM 05/04/2014 -- Created

function writeAsc(varNum,stack,writeIdx)

	savePath = '/home/data/blockLoad/testData/CONUS/final/biovars/';

	arcgridwriteCustom(strcat(savePath,'P',sprintf('%2.2d',varNum), '_lgm.asc'),stack.lgm.val,[0 NaN NaN NaN NaN])
	arcgridwriteCustom(strcat(savePath,'P',sprintf('%2.2d',varNum), '_midH.asc'),stack.midH.val,[0 NaN NaN NaN NaN])
	arcgridwriteCustom(strcat(savePath,'P',sprintf('%2.2d',varNum), '_obs.asc'),stack.obs.val,[0 NaN NaN NaN NaN])

	if writeIdx == 1
	        arcgridwriteCustom(strcat(savePath,'P',sprintf('%2.2d',varNum), '_lgm_monthIdx.asc'),stack.lgm.idx,[0 NaN NaN NaN NaN])
        	arcgridwriteCustom(strcat(savePath,'P',sprintf('%2.2d',varNum), '_midH_monthIdx.asc'),stack.midH.idx,[0 NaN NaN NaN NaN])
        	arcgridwriteCustom(strcat(savePath,'P',sprintf('%2.2d',varNum), '_obs_monthIdx.asc'),stack.obs.idx,[0 NaN NaN NaN NaN])
	end

	zip(strcat(savePath,'P',sprintf('%2.2d',varNum),'.zip'),strcat(savePath,'P',sprintf('%2.2d',varNum),'*.asc'))
	system(['rm ' strcat(savePath,'P',sprintf('%2.2d',varNum),'*.asc')])

end
