function xx = gen_features_week(x, y)

    %The function generates features for the given timestamp vector
    %The features are year, month, day of week, hour, minutes and previous
    %weeks power
    
    
    m = length(x);
    
    d = weekday(x);
    dv = datevec(x);

    p = [];
    
    %Divide into days
    sun = [];
    mon = [];
    tue = [];
    wed = [];
    thu = [];
    fri = [];
    sat = [];
    
    for i=1:m;
        
        if d(i) == 1
            sun = [y(i); sun];
        elseif d(i) == 2
            mon = [y(i); mon];
        elseif d(i) == 3
            tue = [y(i); tue];
        elseif d(i) == 4
            wed = [y(i); wed];
        elseif d(i) == 5
            thu = [y(i); thu];
        elseif d(i) == 6
            fri = [y(i); fri];
        elseif d(i) == 7
            sat = [y(i); sat];
        end
    end
    
    %pointers
    sunp = 1 + 96;
    monp = 1 + 96;
    tuep = 1 + 96;
    wedp = 1 + 96;
    thup = 1 + 96;
    frip = 1 + 96;
    satp = 1 + 96;
    
    for i=m:-1:1
        
        if d(i) == 1
            if sunp>length(sun)
                p = [y(i); p];
            else
                p = [sun(sunp); p];
                sunp = sunp + 1;
            end
            
        elseif d(i) == 2
            if monp>length(mon)
                p = [y(i); p];
            else
                p = [mon(monp); p];
                monp = monp + 1;
            end
            
        elseif d(i) == 3
            if tuep>length(tue)
                p = [y(i); p];
            else
                p = [tue(tuep); p];
                tuep = tuep + 1;
            end
            
        elseif d(i) == 4
            if wedp>length(wed)
                p = [y(i); p];
            else
                p = [wed(wedp); p];
                wedp = wedp + 1;
            end
            
        elseif d(i) == 5
            if thup>length(thu)
                p = [y(i); p];
            else
                p = [thu(thup); p];
                thup = thup + 1;
            end
            
        elseif d(i) == 6
            if frip>length(fri)
                p = [y(i); p];
            else
                p = [fri(frip); p];
                frip = frip + 1;
            end
            
        elseif d(i) == 7
            if satp>length(sat)
                p = [y(i); p];
            else
                p = [sat(satp); p];
                satp = satp + 1;
            end
            
        end
    end
    
    
    xx = [dv(:, 1) dv(:, 2) d dv(:, 4) dv(:, 5), p];
    
end