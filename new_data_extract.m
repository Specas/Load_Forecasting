clc;

data=read_mixed_csv('TestSite01FEB161.csv', ',');
[m, n]=size(data);

label = data(1, :);

col_name = char('vltgA', 'vltgB', 'vltgC', 'vltgGN', 'currA', 'currB', 'currC', 'currN', 'PFA', 'PFB', 'PFC', 'eventId', 'eventTime');

%Mapping labels
col_name = cellstr(col_name);
ind = zeros(length(col_name), 1);
for i=1:length(col_name)
    ind(i) = find(strcmp(label, col_name(i)));
end

%Extracting columns
va = str2double(data(2:end, ind(1)))./10;
vb = str2double(data(2:end, ind(2)))./10;
vc = str2double(data(2:end, ind(3)))./10;
vgn = str2double(data(2:end, ind(4)))./10;
ia = str2double(data(2:end, ind(5)))./10;
ib = str2double(data(2:end, ind(6)))./10;
ic = str2double(data(2:end, ind(7)))./10;
in = str2double(data(2:end, ind(8)))./10;
pfa = str2double(data(2:end, ind(9)))./100;
pfb = str2double(data(2:end, ind(10)))./100;
pfc = str2double(data(2:end, ind(11)))./100;
id = str2double(data(2:end, ind(12)));
tstmp = datetime(data(2:end, ind(13)),'InputFormat','M/dd/yyyy HH:mm');

%Variables to eliminate repetitions
done_5 = 0;
done_3 = 0;
repeat_3 = 0;
repeat_5 = 0;
change = 0;

curr_vec = [];
vec = [];

%mask to remove repeating id content
remove_mask = ones(length(tstmp), 1);

for i=1:length(tstmp)
    

    if i==1
        %Current vector for the first iteration
        curr_vec = datevec(tstmp(i));
        if id(i)==3
            done_3 = 1;
        end
        if id(i)==5
            done_5 = 1;
        end
    
    else
        %Compare date vector with previous
        vec = datevec(tstmp(i));
        res = vec==curr_vec;
        %Checking for equality
        if sum(res)~=6
            done_5 = 0;
            done_3 = 0;
            repeat_5 = 0;
            repeat_3 = 0;
        end
    
        if id(i)==3
            if done_3==1
                repeat_3 = 1;  

            end
            done_3 = 1;
        end
        
        if id(i)==5
            if done_5==1
                repeat_5 = 1;

            end
            done_5 = 1;
        end 
        
        %Repeating condition
        if sum(res)==6
            if (id(i)==3 && repeat_3)||(id(i)==5 && repeat_5)
                remove_mask(i) = 0;
            end
                
        end
        %updating current vector
        curr_vec = vec;
    end
    
end

new_data = data(1, :);
%New vector with deleted content based on the mask
for i=1:length(tstmp)
    if remove_mask(i)==1
        new_data = [new_data; data(i+1, :)];
    end
end

%New data is the data that consists of only one 3 and one 5 per timestamp            
        
   
 
        
        
            
        
    
    
    
    
    
    
    
    
    