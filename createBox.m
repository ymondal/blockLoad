%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% NAME: createBox.m
%% PROJECT: MVZ Downscaling
%% AUTHOR: Yugarshi Mondal
%% DESCRIPTION: This script bias corrects lgm and midHolocene GCM preciptitation records.
%% INPUTS: Subsection to be run. - lat/lon bounds
%% OUTPUT: A matrix with the following parameters (all values default to -9999):
%%		boxBorder = [ testRun# (0-prod), top Row obs (total), bottom Row obs (total), left Col obs (total), right Col obs (total) 
%%			      start obsBlock # , top Row obs (start), bottom Row obs (start), left Col obs (start), right Col obs (start)
%%			      end obsBlock #   , top Row obs (end)  , bottom Row obs (end)  , left Col obs (end)  , right Col obs (end)    ]
%% HISTORY:
%% YM 08/08/2013 -- Created

function boxBorder = createBox(lonWest,lonEast,latNorth,latSouth,testRunNum)

	boxBorder = ones(3,5) * -9999;

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%% CREATE BLOCK 
	%% 1. Create block for long run
	%% 2. Create Test Block

	obsDef = loadObsDef();

	%% Debug:
	%% createBox(-119.5,-118.5,38.5,37.5) should give about
	%% boxBorder(1,:) = [1, 1378, 1499, 666, 787];

	if lonWest > obsDef.zero_lon && lonEast <= obsDef.last_lon && latNorth < obsDef.zero_lat && latSouth >= obsDef.last_lat

		%% 1. Compute rows and cols indexes for region of interst: these are appox +/- one row
		boxBorder(1,1) = testRunNum;
		boxBorder(1,2) = ceil((obsDef.first_lat - latNorth) / 0.0083);
		boxBorder(1,3) = ceil((obsDef.first_lat - latSouth) / 0.0083);
		boxBorder(:,4) = ceil((lonWest - obsDef.first_lon) / 0.0083);
		boxBorder(:,5) = ceil((lonEast - obsDef.first_lon) / 0.0083);

		%% 2. Compute obsBlocks to find these rows and cols: these are appox +/- one row
		boxBorder(2,1) = ceil(boxBorder(1,2)/9);
		boxBorder(2,2) = mod(boxBorder(1,2),9);
		if boxBorder(2,2) == 0
			boxBorder(2,2) = 9;
		end
		boxBorder(2,3) = 9;

		boxBorder(3,1) = ceil(boxBorder(1,3)/9);
		boxBorder(3,2) = 1;
		boxBorder(3,3) = mod(boxBorder(1,3),9);
		if boxBorder(3,3) == 0
			boxBorder(3,3) = 9;
		end

	end
end
