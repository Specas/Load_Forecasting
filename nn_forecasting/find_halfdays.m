function halfdays = find_halfdays(energy_threshold1, energy_threshold2)

    %We first read the energy consumption of each day
    %If the energy consumption is less than a particular threshold value, 
    %We consider it to be a holiday

%     data=read_mixed_csv('output_mean_std_energy_bms.csv', ',');
    data=read_mixed_csv('output_mean_std_energy_newdata.csv', ',');

    time=datetime(data(2:end,1));
    energy=str2double(data(2:end,4));
    halfdays = [];

    for i=1:length(time)

        if energy(i)<=energy_threshold2 && energy(i)>energy_threshold1
            %Appending to holidays list
            halfdays = [halfdays; time(i)];
        end
    end
    
end