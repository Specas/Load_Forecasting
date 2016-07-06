x = ones(1, 23);
ts1 = timeseries(x,1:23);

ts1.Name = 'Daily Count';
ts1.TimeInfo.Units = 'hours';
ts1.TimeInfo.StartDate = '00:00';     % Set start date.
ts1.TimeInfo.Format = 'HH:MM';       % Set format for display on x-axis.

ts1.Time = ts1.Time - ts1.Time(1);        % Express time relative to the start date.

plot(ts1)