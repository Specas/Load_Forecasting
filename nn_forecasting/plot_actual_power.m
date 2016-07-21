function [] = plot_actual_power(y, tstmp)
    

    tx1 = timeseries(y, 1:96);
    tx1.TimeInfo.Units = 'minutes';
    tx1.TimeInfo.StartDate = '00:00';     
    tx1.TimeInfo.Format = 'HH:MM';  
    tx1.TimeInfo.Increment = 15;
    tx1.Time = tx1.Time - tx1.Time(1);
    
    plot(tx1);
    xlabel('Time (HH:MM)');
    ylabel('Active Power (kW)');
    title(datestr(tstmp, 'dd/mm/yyyy'));
    
    
    hold on;
    
end