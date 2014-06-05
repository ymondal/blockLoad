%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% NAME: obsBlockPreproc.m
%% PROJECT: MVZ Downscaling
%% AUTHOR: Yugarshi Mondal
%% DESCRIPTION: Preprocessing observations to speed up loading in main routine. This routine
%%		rebuilds observation data so that they are continous in time for a given point.
%%		The data is give is continous in space (all of US), for a given point in time.
%% INPUTS: - none -
%% OUTPUTS: - none -
%%
%% HISTORY:
%% YM 08/22/2013 -- Created

%% path descriptions
%% for ASC cutting (first loop): filePath is where the asc are / workingDir is where 345 cuts for asc are
%% for rebuild (second loop): workingDir is where the 345 cuts are / outPath is where rebuilt obs are

%%PPT%%
filePath = '/home/ubuntu/data/PPT/'
workingDir = '/home/ubuntu/files/PRISM_renamedAndImported/tempPPTrebuild/'
outPath = '/home/ubuntu/files/PRISM_345/PPT_345/'

%%TMIN%%
%filePath = '/home/ubuntu/temp/PRISM_800m/TMIN/'
%workingDir = '/home/ubuntu/files/PRISM_renamedAndImported/tempTMINrebuild/'
%outPath = '/home/ubuntu/files/PRISM_345/TMIN_345/'

%%TMAX%%
%filePath = '/home/ubuntu/temp/PRISM_800m/TMAX/';
%workingDir = '/home/ubuntu/files/PRISM_renamedAndImported/tempTMAXrebuild/'
%outPath = '/home/ubuntu/files/PRISM_345/TMAX_345/'

obsFileName = strcat(filePath,'*.asc');
obsFileStruct = dir(obsFileName);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% REFORM DATA
%% 1. Break each asc file into 345 part
%% 2. Build all 345 parts back up

%% 1. Break each asc file
for i = 1:length({obsFileStruct.name})

	tic
	tempLoad = arcgridread(strcat(filePath,obsFileStruct(i).name));

	for counter = 1:345
		dummy = tempLoad(1+(counter-1)*9:counter*9,1:end);
		save(strcat(workingDir,sprintf('%4.4d',i),'_',sprintf('%3.3d',count),'_temp.mat'),'dummy')
	end
	i
	toc
end

%% 2. Restack files that were just written so they're continous in time
for obsBlockNum = 1:345
        tic
        fileName = strcat(workingDir,'*_',sprintf('%3.3d',obsBlockNum),'_temp.mat')
        filesNameStruct = dir(fileName);

        for i = 1:length({filesNameStruct.name})
                load(strcat(workingDir,filesNameStruct(i).name))
                obsBlock(:,:,i) = dummy;
        end

        toc

        save(strcat(outPath,'PPT_',sprintf('%3.3d',obsBlockNum),'.mat'),'obsBlock')

end


