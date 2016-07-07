clear;
label = 'output_final_data_new.csv';
data=read_mixed_csv(label,',');
time=datetime(data(2:end,1));
power=str2double(data(2:end,2));
time_vec=datevec(time(1:end));
%We get the day using the date vector
day = time_vec(:, 3);
start_day = day(1);
ind(1) = 1;
j=2;
%We calculate total minutes as we require it to calculate energy
min = time_vec(:, 4).*60 + time_vec(:, 5);
%We get the indices where the new day starts
for i=2:size(time,1)
    if(day(i)~=start_day)
        ind(j)=i;
        j=j+1;
    end
    start_day = day(i);
end

ind = ind';

%We iterate through these indices and find the Energy, mean and standard
%deviation

start_time = ind(1);
ind_time = time(ind(1));
for i=2:length(ind)
    %Vector containing all power values in a day.
    %It is obtained by taking the values from one 0:00 to the next
    power_day = power(start_time:ind(i)-1);
    min_day = min(start_time:ind(i)-1);
    start_time = ind(i);
    mean_power(i-1) = mean(power_day);
    std_power(i-1) = std(power_day);
    %Calculating energy in kWh
    E = 0;
    for j=1:length(power_day)
        
        %Our interpolated data is at intervals of 15
        E = E + power_day(j)*15;
    end
    E = E/60; %kWh
    energy(i-1) = E;
    ind_time = [ind_time; time(ind(i))];
    
    
end
mean_power = mean_power';
std_power = std_power';
energy = energy';
%Calculating the values for the remaining day duration
last_power_day = power(ind(end):end);
mean_last = mean(last_power_day);
std_last = mean(last_power_day);
E_last = 0;
for j=1:length(last_power_day)-1
        
    E_last = E_last + last_power_day(j)*15;
end
E_last = E_last/60; %kWh
mean_power = [mean_power; mean_last];
std_power = [std_power; std_last];
energy = [energy; E_last];


output_label = cellstr(char('Date Time', 'Mean', 'Standard Deviation', 'Energy'))';
time = cellstr(ind_time);
mean_final = num2cell(mean_power);
std_final = num2cell(std_power);
energy_final = num2cell(energy);
output_final = [time mean_final std_final energy_final];
output_final = [output_label; output_final];

%Saving of the output data in csv format.
fid = fopen('output_mean_std_energy_newdata.csv', 'wt');
fprintf(fid, '%s,', output_final{1,1});
fprintf(fid, '%s,', output_final{1,2});
fprintf(fid, '%s,', output_final{1,3});
fprintf(fid, '%s\n', output_final{1,4});


for i=2:(length(output_final))
    fprintf(fid, '%s,', output_final{i,1});
    m=output_final(i,2);
    m=m{:};
    fprintf(fid, '%f,', m);
    s=output_final(i,3);
    s=s{:};
    fprintf(fid, '%f,', s);
    e=output_final(i,4);
    e=e{:};
    fprintf(fid, '%f\n', e);
end;
fclose(fid);
