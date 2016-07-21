function [xx] = gen_features_week_test(x, y, li, date_mat)

    
    m = length(x);
    
    date = date_mat(1); %We need only year, month and day
    
    k = datevec(date);
    k = [k(1) k(2) k(3)];
    kd = weekday(date);
    
    dv = datevec(date_mat);
    d = weekday(date_mat);
    
    
    pointer = 0;
    w_pointer = 0;
    
    %Finding the previous week's date on the same weekday
    
    for i=1:length(li)
        
        xvec = datevec(li(i));
        xvec = [xvec(1) xvec(2) xvec(3)];
        
        if isequal(k, xvec)
            pointer = i;
            w_pointer = weekday(li(i));
            break;
        end
    end
    

    pt = pointer - 1;
%     disp(pointer);
    
    bdate = 0;
    flag = 1;
    
    for i=pt:-1:1
        
        if weekday(li(i))==w_pointer
            bdate = li(i);
            flag = 0;
            break;
        end
    end
    
    %Previous day if same weekday not found in the previous week.
    if flag
        bdate = li(pointer-1);
    end
    
    
    k = datevec(bdate);
    k = [k(1) k(2) k(3)];
    
    power = [];
    
    for i=1:m
        
        xvec = datevec(x(i));
        xvec = [xvec(1) xvec(2) xvec(3)];
        
        if isequal(k, xvec)
            power = [power; y(i)];
        end
    end
    
    
    xx = [dv(:, 1) dv(:, 2) d dv(:, 4) dv(:, 5), power];
    
end

    
    
            
    
        
    
    
        
    
    
            
    
    