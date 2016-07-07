clear;
clc;

%Read pre-processed data
data=read_mixed_csv('R_output_full_interpolated_newdata.csv', ',');

%Extract datetime and power
time=datetime(data(2:end,1));
power=str2double(data(2:end,2));

stime=data(2:end,1);
spower=data(2:end,2);

m = length(time);

%Converting to date vector for neural network inputs
time_vec = datevec(time);
list_dates = [];

%Day of the week
day_num = weekday(time);
list_holidays = find_holidays(1000); %Energy threshold of 1000


%We get the list of all dates and set the time to 00:00:00
for i=1:m
    
    time_vec(i, 4) = 0;
    time_vec(i, 5) = 0;
    time_vec(i, 6) = 0;
    list_dates = [list_dates; datetime(time_vec(i, :))];
end

%removing duplicates so that one date only appears once
list_dates = unique(list_dates);
list_working = setdiff(list_dates, list_holidays);

%Splitting into training and testing data 60-40
train_len_hol = round(60*length(hol_dates)/100);
train_len_work = round(60*length(work_dates)/100);



% %Now we split x 60% 40% to make up the training and test data
% train_len = round(60*m/100);
% test_len = m - train_len;
% 
% %Taking 60% and 40% randomly
% train_index = sort(randsample(1:m, train_len)');
% test_index = setdiff(1:m, train_index)';
% 
% %Matrices to store the x and target values
% x_train = [];
% x_test = [];
% power_train = [];
% power_test = [];
% 
% 
% for i=1:m
%     
%     %Input features are day of week, hours, minutes and holiday flag
%     features = [day_num(i) time_vec(i, 4) time_vec(i, 5) hol_num(i)];
%     
%     if ismember(i, train_index)
%         x_train = [x_train; features];
%         power_train = [power_train; power(i)];
%     end
%     
%     if ismember(i, test_index)
%         x_test = [x_test; features];
%         power_test = [power_test; power(i)];
%     end
%     
% end
%         
% clear data day_num features hol_num i list_dates m power spower stime test_index test_len time time_vec train_index train_len     












