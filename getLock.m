        function getLock(lockPath,fName)
                d = strcat('mkdir',{' '},lockPath,fName,{' '},'2>/dev/null');
                while system(d{1})
                        e = strcat(fName,{' '},'is locked...waiting 10 seconds'); disp(e{1})
                        pause(10)
                end
        end
