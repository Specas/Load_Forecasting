clear;
clc;

data=read_mixed_csv('output_final_data_new.csv', ',');

time=datetime(data(2:end,1));
power=str2double(data(2:end,2));

stime=data(2:end,1);
spower=data(2:end,2);

m = length(time);

time_vec = datevec(time);
list_dates = [];

%We get the list of all dates and set the time to 00:00:00
for i=1:m
    
    time_vec(i, 4) = 0;
    time_vec(i, 5) = 0;
    time_vec(i, 6) = 0;
    list_dates = [list_dates; datetime(time_vec(i, :))];
end

%removing duplicates so that one date only appears once
list_dates = unique(list_dates);
day_num = weekday(list_dates);

%Now we calculate the number of data points in each day. If it is not
%equal to 96, we remove that day
final_list_dates = [];
j = 1;

for i=1:length(list_dates)
    
    k = datevec(list_dates(i));
    k = [k(1) k(2) k(3)];
 
    no_of_entries = 0;
    
    while(true)
        
        ktime = datevec(time(j));
        ktime = [ktime(1) ktime(2) ktime(3)];
        %Checking equality
        if sum(k==ktime)==3 %year, month and time are equal

            no_of_entries = no_of_entries + 1;
            j = j + 1;
            if j>m
                break;
            end
        else 
            break
        end

    end
    
    if no_of_entries < 96
        disp(no_of_entries);
        disp(list_dates(i));
    end
    
    no_of_entries = 0;

end
        
        
        
        
    
    
    

%Two vectors to store the holidays and working days dates
% hol_dates = [];
% work_dates = [];
% 
% for i=1:length(day_num)
%     
%     if(day_num(i) == 1)%Sunday
%         hol_dates = [hol_dates; list_dates(i)];
%     else
%         work_dates = [work_dates; list_dates(i)];
%     end
% end
% 
% 
% 
% train_len_hol = round(60*length(hol_dates)/100);
% train_len_work = round(60*length(work_dates)/100);
% 
% %Picking 60% of the dates randomly
% train_hol_dates = randsample(hol_dates, train_len_hol);
% train_work_dates = randsample(work_dates, train_len_work);
% 
% %Storing the other 40% 
% test_hol_dates = setdiff(hol_dates, train_hol_dates);
% test_work_dates = setdiff(work_dates, train_work_dates);
% 
% 
% %Vectors to store the 60 and 40% data
% train_work_time = [];
% train_work_power = [];
% test_work_time = [];
% test_work_power = [];
% train_hol_time = [];
% train_hol_power = [];
% test_hol_time = [];
% test_hol_power = [];
% 
% 
% 
% for i=1:m
%     k = 0;
%     t = time_vec(i, 1:3);
%     tmp1 = datevec(train_work_dates);
%     tmp2 = datevec(test_work_dates);
%     tmp3 = datevec(train_hol_dates);
%     tmp4 = datevec(test_hol_dates);
%     
%     for j=1:length(train_work_dates)
%         if isequal((t==tmp1(j, 1:3)), [1 1 1])
%             k = 1;
%         end
%     end
%     
%     for j=1:length(test_work_dates)
%         if isequal((t==tmp2(j, 1:3)), [1 1 1])
%             k = 2;
%         end
%     end
%     
%     for j=1:length(train_hol_dates)
%         if isequal((t==tmp3(j, 1:3)), [1 1 1])
%             k = 3;
%         end
%     end
%     
%     for j=1:length(test_hol_dates)
%         if isequal((t==tmp4(j, 1:3)), [1 1 1])
%             k = 4;
%         end
%     end
%     
%     if k==1
%         train_work_time = [train_work_time; time(i)];
%         train_work_power = [train_work_power; power(i)];
%     elseif k==2
%         test_work_time = [test_work_time; time(i)];
%         test_work_power = [test_work_power; power(i)];
%     elseif k==3
%         train_hol_time = [train_hol_time; time(i)];
%         train_hol_power = [train_hol_power; power(i)];
%     elseif k==4
%         test_hol_time = [test_hol_time; time(i)];
%         test_hol_power = [test_hol_power; power(i)];
%     end
% end
% 
% predicted_power = forecast_power(train_work_power);
     
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    


