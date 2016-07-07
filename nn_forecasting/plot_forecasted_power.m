function [] = plot_forecasted_power(y, yf, tstmp)
    

    tx1 = timeseries(y, 1:96);
    tx1.TimeInfo.Units = 'minutes';
    tx1.TimeInfo.StartDate = '00:00';     
    tx1.TimeInfo.Format = 'HH:MM';  
    tx1.TimeInfo.Increment = 15;
    tx1.Time = tx1.Time - tx1.Time(1);
    
    plot(tx1);
    hold on;
    
    tx2 = timeseries(yf, 1:96);
    tx2.TimeInfo.Units = 'minutes';
    tx2.TimeInfo.StartDate = '00:00';     
    tx2.TimeInfo.Format = 'HH:MM';  
    tx2.TimeInfo.Increment = 15;
    tx2.Time = tx2.Time - tx2.Time(1);
    
    plot(tx2);
    xlabel('Time (HH:MM)');
    ylabel('Active Power (kW)');
    title(datestr(tstmp, 'dd/mm/yyyy'));
    
    legend('Actual Power', 'Forecasted Power');
    
end