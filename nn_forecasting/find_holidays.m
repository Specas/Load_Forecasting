function holidays = find_holidays(energy_threshold)

    %We first read the energy consumption of each day
    %If the energy consumption is less than a particular threshold value, 
    %We consider it to be a holiday

%     data=read_mixed_csv('output_mean_std_energy_bms.csv', ',');
    data=read_mixed_csv('output_mean_std_energy_newdata.csv', ',');

    time=datetime(data(2:end,1));
    energy=str2double(data(2:end,4));
    holidays = [];

    for i=1:length(time)

        if energy(i)<=energy_threshold
            %Appending to holidays list
            holidays = [holidays; time(i)];
        end
    end
    
end