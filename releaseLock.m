        function releaseLock(lockPath,fName)
                d = strcat('rmdir',{' '},lockPath,fName,{' '},'2>/dev/null'); system(d{1});
        end
