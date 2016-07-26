clear;
clc;

%Read pre-processed data
% data=read_mixed_csv('output_final_data_pretest.csv', ',');
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
list_halfdays = find_halfdays(1000, 1500); %Threshold for halfdays

%Thresholds for new data
% list_holidays = find_holidays(2000); %Energy threshold of 1000
% list_halfdays = find_halfdays(2000, 2500); %Threshold for halfdays

list_holidays = sort(list_holidays);
list_halfdays = sort(list_halfdays);



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
list_working = setdiff(list_working, list_halfdays);




% %Splitting into training and testing data 60-40
% train_len_hol = round(60*length(list_holidays)/100);
% train_len_work = round(60*length(list_working)/100);
% 
% %Picking 60% of the dates randomly
% train_hol = randsample(list_holidays, train_len_hol);
% train_work = randsample(list_working, train_len_work);
% 
% %Storing the other 40% 
% test_hol = setdiff(list_holidays, train_hol);
% test_work = setdiff(list_working, train_work);
% 
% train_work = sort(train_work);
% train_hol = sort(train_hol);
% test_work = sort(test_work);
% test_hol = sort(test_hol);




%For the other model, we use all but one data for training
train_work_single = randsample(list_working, length(list_working)-1);
train_hol_single = randsample(list_holidays, length(list_holidays)-1);

test_work_single = setdiff(list_working, train_work_single);
test_hol_single = setdiff(list_holidays, train_hol_single);

train_work_single = sort(train_work_single);
train_hol_single = sort(train_hol_single);
test_work_single = sort(test_work_single);
test_hol_single = sort(test_hol_single);

ind = 3;
test_work_single = list_working(ind);
%crbm parameters
numframes = 96;
fr = ind*96+1;

train_work_single = setdiff(list_working, test_work_single);

%Creating two lists of datetimes that contain only working and holidays
%respectively

htime = [];
j = 1;

for i=1:length(list_holidays)
    
    k = datevec(list_holidays(i));
    k = [k(1) k(2) k(3)];

    for ii=1:m

        ktime = datevec(time(ii));
        ktime = [ktime(1) ktime(2) ktime(3)];
        %Checking equality
        if sum(k==ktime)==3 %year, month and time are equal

            htime = [htime; time(ii)];   

        end
    end
end

wtime = setdiff(time, htime);

%For 60 40 forecast

% [xtrain_w, ytrain_w] = extract_time_power(time, power, wtime, train_work);
% [xtest_w, ytest_w] = extract_time_power(time, power, wtime, test_work);
% [xtrain_h, ytrain_h] = extract_time_power(time, power, htime, train_hol);
% [xtest_h, ytest_h] = extract_time_power(time, power, htime, test_hol);

%For single day forecast
[xtrain_w_single, ytrain_w_single] = extract_time_power(time, power, wtime, train_work_single);
[xtest_w_single, ytest_w_single] = extract_time_power(time, power, wtime, test_work_single);
[xtrain_h_single, ytrain_h_single] = extract_time_power(time, power, htime, train_hol_single);
[xtest_h_single, ytest_h_single] = extract_time_power(time, power, htime, test_hol_single);

[xw, yw] = extract_time_power(time, power, wtime, list_working);

%for crbm data
% [xtrain_w_all, ytrain_w_all] = extract_time_power(time, power, wtime, list_working);
% xtrain_w_allg = gen_features(xtrain_w_all);
% crbm_data2 = [xtrain_w_allg ytrain_w_all];
% save crbm_data2.mat crbm_data2

%Generating feature arrays
% xtrain_wg = gen_features(xtrain_w);
% xtest_wg = gen_features(xtest_w);
% xtrain_hg = gen_features(xtrain_h);
% xtest_hg = gen_features(xtest_h);

xtrain_w_singleg = gen_features(xtrain_w_single);
xtest_w_singleg = gen_features(xtest_w_single);

% xtrain_w_singleg = gen_features_week(xtrain_w_single);
% xtest_w_singleg = gen_features_week_test(xtest_w_single);

% xtrain_w_singleg = gen_features_week(xtrain_w_single, ytrain_w_single);
% xtest_w_singleg = gen_features_week_test(xtrain_w_single, ytrain_w_single, list_working, xtest_w_single);

xtrain_h_singleg = gen_features(xtrain_h_single);
xtest_h_singleg = gen_features(xtest_h_single);
 
%Clearing all other data
% clear data day_num htime i ii j k ktime list_dates list_holidays list_working m power spower stime test_hol test_hol_single test_work test_work_single time time_vec train_hol train_hol_single train_len_hol train_len_work train_work train_work_single wtime 

%Training neural network

% x = [xtrain_wg; xtest_wg];
% y = [ytrain_w; ytest_w];
% len = length(x);
% tr_len = round(60*len/100);
% te_len = len - tr_len;
% tr_index = randsample(1:len, tr_len)';
% te_index = setdiff(1:len, tr_index)';

%Another set of training data that doesnt distribute day 
%wise but all at once
% xtrain_w_rand = x(tr_index, :);
% ytrain_w_rand = y(tr_index, :);
% xtest_w = x(te_index, :);
% ytest_w = y(te_index, :);

figure();

% For Trees
% model = tree(xtrain_w_singleg, ytrain_w_single);
% yft = predict(model, xtest_w_singleg);
% err_tree = calculate_mape(ytest_w_single, yft);
% disp(err_tree);

plot_actual_power(ytest_w_single, test_work_single);

% plot_forecasted_power(yft, test_work_single);



%For NN
% net = nn_train(xtrain_w_singleg, ytrain_w_single);
% yfnn = net(xtest_w_singleg')';
% err_nn = calculate_mape(ytest_w_single, yfnn);
% disp(err_nn);



%For crbm
yfc = gen2(numframes, fr);
err_c = calculate_mape(ytest_w_single, yfc);
disp(err_c);

plot_forecasted_power(yfc, test_work_single);
legend('Actual', 'Forecasted');

% subplot(2, 1, 1);
% plot_forecasted_power(yfnn, test_work_single);
% legend('Actual Power', ['Trees' char(10) strcat('Error = ', num2str(err_tree))], ['Neural Networks' char(10) strcat('Error = ', num2str(err_nn))]);

% %Second subplot
% train_work_single = randsample(list_working, length(list_working)-1);
% train_hol_single = randsample(list_holidays, length(list_holidays)-1);
% 
% test_work_single = setdiff(list_working, train_work_single);
% test_hol_single = setdiff(list_holidays, train_hol_single);
% 
% train_work_single = sort(train_work_single);
% train_hol_single = sort(train_hol_single);
% test_work_single = sort(test_work_single);
% test_hol_single = sort(test_hol_single);
% 
% [xtrain_w_single, ytrain_w_single] = extract_time_power(time, power, wtime, train_work_single);
% [xtest_w_single, ytest_w_single] = extract_time_power(time, power, wtime, test_work_single);
% [xtrain_h_single, ytrain_h_single] = extract_time_power(time, power, htime, train_hol_single);
% [xtest_h_single, ytest_h_single] = extract_time_power(time, power, htime, test_hol_single);
% 
% xtrain_w_singleg = gen_features(xtrain_w_single);
% xtest_w_singleg = gen_features(xtest_w_single);
% xtrain_h_singleg = gen_features(xtrain_h_single);
% xtest_h_singleg = gen_features(xtest_h_single);
% 
% net = nn_train(xtrain_h_singleg, ytrain_h_single);
% yf = net(xtest_h_singleg')';
% disp(calculate_mape(ytest_h_single, yf));
% 
% 
% subplot(2, 1, 2);
% plot_forecasted_power(ytest_h_single, yf, test_hol_single);
% 
% savefig('Holidays.fig');