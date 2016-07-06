function [r_data] = remove_data(data, remove_list)
    clc;

    time=datetime(data(2:end,1));
    power=str2double(data(2:end,2));

    stime=data(2:end,1);
    spower=data(2:end,2);

    m = length(time);
    n = length(remove_list);

    
    time_vec = datevec(time);
    rem_vec = datevec(remove_list);
    i = 1;
    j = 1;
    
    %We exploit the fact that both the date lists are in ascending
    %order to come up with an algorithm that can find all the dates
    %in O(m+n) time
    while i<=m && j<=n
        
        %We get the month and day values of both the lists
        %using date vectors
        month_data = time_vec(i, 2);
        month_rem = rem_vec(j, 2);
        day_data = time_vec(i, 3);
        day_rem = rem_vec(j, 3);
        
        greater = 0;
        
        %We check if the day in the remove list is greater than
        %the day in the data
        %If it is greater, then the data pointer must be incremented
        %as a higher date is needed
        %If it is lesser, the remove list pointer is incremented
        %If it is equal, the corresponding power value is set to -1
        %which acts as a flag and is used to remove the data
        if month_rem>month_data
            greater = 1;
        elseif month_rem<month_data
            greater = 0;
        else
            if day_rem>day_data
                greater = 1;
            elseif day_rem<day_data
                greater = 0;
            else
                greater = -1;
            end
        end
        
        if greater==1
            i = i+1;
            
        elseif greater==0
            j = j+1;
            
        else
            power(i) = -1;
            i = i+1;
        end

        
    end
    
    % Now removing the dates with power as -1
    
    r_time = [];
    r_power = [];
    for i=1:m
        if power(i)~=-1
            r_time = [r_time; stime(i)];
            r_power = [r_power; spower(i)];
        end
    end
    
    r_data = [r_time, r_power];

    

    
    
end
        
        
            
        
            

            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
        
        