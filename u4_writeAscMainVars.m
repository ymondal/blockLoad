function writeAscMainVars(type,stack)

        savePath = '/home/data/blockLoad/testData/CONUS/final/';

	for month = 1:12
	        arcgridwriteCustom(strcat(savePath,type,'_lgm_M',sprintf('%2.2d',month),'.asc'),squeeze(stack.lgm.mean(:,:,month)),[0 NaN NaN NaN NaN])
        	arcgridwriteCustom(strcat(savePath,type,'_midH_M',sprintf('%2.2d',month),'.asc'),squeeze(stack.midH.mean(:,:,month)),[0 NaN NaN NaN NaN])
		arcgridwriteCustom(strcat(savePath,type,'_obs_M',sprintf('%2.2d',month),'.asc'),squeeze(stack.obs(:,:,month)),[0 NaN NaN NaN NaN])       	
	end
	
%       zip(strcat(savePath,'P',sprintf('%2.2d',varNum),'.zip'),strcat(savePath,'P',sprintf('%2.2d',varNum),'*.asc'))
%       system(['rm ' strcat(savePath,'P',sprintf('%2.2d',varNum),'*.asc')])

end

