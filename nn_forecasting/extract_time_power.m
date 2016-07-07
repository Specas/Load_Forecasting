function [x, y] = extract_time_power(time, power, wtime, list_dates)

    %This function extracts the time and corresponding power entries for
    %all the dates in list
    
    x = [];
    y = [];
    
    j = 1;
    m = length(wtime);
    
    %First we extract time
    
    for i=1:length(list_dates)
        
        k = datevec(list_dates(i));
        k = [k(1) k(2) k(3)];

        no_of_entries = 0;
        x_tmp = [];


        while(true)

            ktime = datevec(wtime(j));
            ktime = [ktime(1) ktime(2) ktime(3)];
            %Checking equality
            if sum(k==ktime)==3 %year, month and time are equal

                no_of_entries = no_of_entries + 1;
                x_tmp = [x_tmp; wtime(j)];
                
                j = j + 1;
                if j>m
                    break;
                end
            else 
                if wtime(j)<list_dates(i)
                    j = j+1;
                else
                    break
                end
            end

        end
        
%         disp(no_of_entries);
        if no_of_entries == 96
            x = [x; x_tmp];
        else
%             disp('Not 96. Missing values');
        end

        no_of_entries = 0;

    end
    

    %Now we use x to extract power
    
    j = 1;
    for i=1:length(x)
        
        k = datevec(x(i));
        
        
        while true
            
            ktime = datevec(time(j));
            
            if sum(k==ktime)==6 %equality
                
                y = [y; power(j)];
                j = j + 1;
                break;
            else
                j = j+1;
            end
        end
    end

        
    
    
end
        