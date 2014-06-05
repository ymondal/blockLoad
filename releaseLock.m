%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% NAME: getLock.m
%% PROJECT: MVZ Downscaling
%% AUTHOR: Yugarshi Mondal
%% DESCRIPTION: This functions implements a rudimentary lock releasing mechanism. It's called
%%              after thread finishes using GCM and PRISM data. This is done so that multiple threads
%%              aren't accessing the file at the same time. It utilizes the fact that mkdir in 
%%              unix is an atomic operation.
%% INPUTS: lockPath (path to lock director), fName (name of file to Lock)
%% OUTPUTS: none
%%
%% HISTORY:
%% YM 02/12/2014 -- Created

function releaseLock(lockPath,fName)
	d = strcat('rmdir',{' '},lockPath,fName,{' '},'2>/dev/null'); system(d{1});
end
