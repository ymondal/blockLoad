%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% NAME: getLock.m
%% PROJECT: MVZ Downscaling
%% AUTHOR: Yugarshi Mondal
%% DESCRIPTION: This functions implements a rudimentary file locking mechanism. It's called
%%		before GCM and PRISM data is being loaded. This is done so that multiple threads
%%		aren't accessing the file at the same time. It utilizes the fact that mkdir in
%%		unix is an atomic operation.
%% INPUTS: lockPath (path to lock director), fName (name of file to Lock)
%% OUTPUTS: none
%%
%% HISTORY:
%% YM 02/12/2014 -- Created

function getLock(lockPath,fName)

	d = strcat('mkdir',{' '},lockPath,fName,{' '},'2>/dev/null');
       	while system(d{1})
              	e = strcat(fName,{' '},'is locked...waiting 10 seconds'); disp(e{1})
               	pause(10)
        end

end
