clear;
clc;

% data=read_mixed_csv('R_output_full_interpolated_newdata.csv', ',');
data=read_mixed_csv('output_final_data_new.csv', ',');

time=datetime(data(2:end,1));
power=str2double(data(2:end,2));

stime=data(2:end,1);
spower=data(2:end,2);

m = length(time);
%Finding day of the week
day_num = weekday(time);

%Separating the weeks and the values of each weekday into a 
%vector

init_day = time(1);
day_changed = 0;
no_of_weeks = 0;
sun = []; mon = []; tue = []; wed = []; thu = []; fri = []; sat = [];
for i=1:m    
    if i~=1
        if day_num(i)~=day_num(i-1)
            %day has changed
            day_changed = 1;
        end
        
        %Checking if week has changed
        if day_changed
            offset_hours = hours(time(i)-init_day);
            %fprintf('%f\n', offset_hours);
            if offset_hours>=168
            
                %If the week has changed we add an entry with power value of
                %-1 and any random timestamp
                sun = [sun; [stime(i) num2str(-1)]];
                mon = [mon; [stime(i) num2str(-1)]];
                tue = [tue; [stime(i) num2str(-1)]];
                wed = [wed; [stime(i) num2str(-1)]];
                thu = [thu; [stime(i) num2str(-1)]];
                fri = [fri; [stime(i) num2str(-1)]];
                sat = [sat; [stime(i) num2str(-1)]];
                
                no_of_weeks = no_of_weeks + 1;
                init_day = init_day+7;
            end
            day_changed = 0;
        end
    end
            
    
    
    if(day_num(i)==1)
        sun = [sun; [stime(i) spower(i)]];
    elseif(day_num(i)==2)
        mon = [mon; [stime(i) spower(i)]];
    elseif(day_num(i)==3)
        tue = [tue; [stime(i) spower(i)]];
    elseif(day_num(i)==4)
        wed = [wed; [stime(i) spower(i)]];
    elseif(day_num(i)==5)
       thu = [thu; [stime(i) spower(i)]];
    elseif(day_num(i)==6)
        fri = [fri; [stime(i) spower(i)]];
    elseif(day_num(i)==7)
        sat = [sat; [stime(i) spower(i)]];
    end
    
end

% Now we have seven matrices corresponding to the weekdays. a power
% value of -1 in the matrices imply that the week has changed

%Finding the location of -1
sun_change = find(str2double(sun(:, 2))==-1);
mon_change = find(str2double(mon(:, 2))==-1);
tue_change = find(str2double(tue(:, 2))==-1);
wed_change = find(str2double(wed(:, 2))==-1);
thu_change = find(str2double(thu(:, 2))==-1);
fri_change = find(str2double(fri(:, 2))==-1);
sat_change = find(str2double(sat(:, 2))==-1);

sun_init = 0;
mon_init = 0;
tue_init = 0;
wed_init = 0;
thu_init = 0;
fri_init = 0;
sat_init = 0;


for i=1:no_of_weeks
    
%     subplot(no_of_weeks, 1, i);
    figure;
    legend_list = [];
    
    x_sun = datetime(sun(sun_init+1:sun_change(i)-1, 1));
    y_sun = str2double(sun(sun_init+1:sun_change(i)-1, 2));
    
    x_sun = datestr(x_sun, 'HH:MM');
    len_sun = length(x_sun);
    disp(len_sun);
    %tsun = timeseries(y_sun, x_sun);
    if len_sun==96
        tsun = timeseries(y_sun, 1:96);

        tsun.Name = 'Daily Count';
        tsun.TimeInfo.Units = 'minutes';
        tsun.TimeInfo.StartDate = '00:00';     
        tsun.TimeInfo.Format = 'HH:MM';  
        tsun.TimeInfo.Increment = 15;
        tsun.Time = tsun.Time - tsun.Time(1);
        
        legend_list = [legend_list; {'Sun'}];

        plot(tsun);
        xlabel('Time (HH:MM)');
        ylabel('Active Power (kW)');
        title(strcat('Week ', num2str(i)));
        hold on;
    end
    
    x_mon = datetime(mon(mon_init+1:mon_change(i)-1, 1));
    y_mon = str2double(mon(mon_init+1:mon_change(i)-1, 2));

    x_mon = datestr(x_mon, 'HH:MM');
    len_mon = length(x_mon);
    disp(len_mon);
    %tmon = timeseries(y_mon, x_mon);
    if len_mon==96
        tmon = timeseries(y_mon, 1:96);

        tmon.Name = 'Daily Count';
        tmon.TimeInfo.Units = 'minutes';
        tmon.TimeInfo.StartDate = '00:00';     
        tmon.TimeInfo.Format = 'HH:MM';  
        tmon.TimeInfo.Increment = 15;
        tmon.Time = tmon.Time - tmon.Time(1);
        
        legend_list = [legend_list; {'Mon'}];

        plot(tmon);
        xlabel('Time (HH:MM)');
        ylabel('Active Power (kW)');
        title(strcat('Week ', num2str(i)));
        hold on;
    end
    
    x_tue = datetime(tue(tue_init+1:tue_change(i)-1, 1));
    y_tue = str2double(tue(tue_init+1:tue_change(i)-1, 2));

    x_tue = datestr(x_tue, 'HH:MM');
    len_tue = length(x_tue);
    disp(len_tue);
    %ttue = timeseries(y_tue, x_tue);
    if len_tue==96
        ttue = timeseries(y_tue, 1:96);

        ttue.Name = 'Daily Count';
        ttue.TimeInfo.Units = 'minutes';
        ttue.TimeInfo.StartDate = '00:00';     
        ttue.TimeInfo.Format = 'HH:MM';  
        ttue.TimeInfo.Increment = 15;
        ttue.Time = ttue.Time - ttue.Time(1);
        
        legend_list = [legend_list; {'Tue'}];

        plot(ttue);
        xlabel('Time (HH:MM)');
        ylabel('Active Power (kW)');
        title(strcat('Week ', num2str(i)));
        hold on;
    end
    
    x_wed = datetime(wed(wed_init+1:wed_change(i)-1, 1));
    y_wed = str2double(wed(wed_init+1:wed_change(i)-1, 2));

    x_wed = datestr(x_wed, 'HH:MM');
    len_wed = length(x_wed);
    disp(len_wed);
    %twed = timeseries(y_wed, x_wed);
    if len_wed==96
        twed = timeseries(y_wed, 1:96);

        twed.Name = 'Daily Count';
        twed.TimeInfo.Units = 'minutes';
        twed.TimeInfo.StartDate = '00:00';     
        twed.TimeInfo.Format = 'HH:MM';  
        twed.TimeInfo.Increment = 15;
        twed.Time = twed.Time - twed.Time(1);
        
        legend_list = [legend_list; {'Wed'}];

        plot(twed);
        xlabel('Time (HH:MM)');
        ylabel('Active Power (kW)');
        title(strcat('Week ', num2str(i)));
        hold on;
    end
    
    x_thu = datetime(thu(thu_init+1:thu_change(i)-1, 1));
    y_thu = str2double(thu(thu_init+1:thu_change(i)-1, 2));

    x_thu = datestr(x_thu, 'HH:MM');
    len_thu = length(x_thu);
    disp(len_thu);
    %tthu = timeseries(y_thu, x_thu);
    if len_thu==96
        tthu = timeseries(y_thu, 1:96);

        tthu.Name = 'Daily Count';
        tthu.TimeInfo.Units = 'minutes';
        tthu.TimeInfo.StartDate = '00:00';     
        tthu.TimeInfo.Format = 'HH:MM';  
        tthu.TimeInfo.Increment = 15;
        tthu.Time = tthu.Time - tthu.Time(1);
        
        legend_list = [legend_list; {'Thu'}];

        plot(tthu);
        xlabel('Time (HH:MM)');
        ylabel('Active Power (kW)');
        title(strcat('Week ', num2str(i)));
        hold on;
    end
    
    x_fri = datetime(fri(fri_init+1:fri_change(i)-1, 1));
    y_fri = str2double(fri(fri_init+1:fri_change(i)-1, 2));

    x_fri = datestr(x_fri, 'HH:MM');
    len_fri = length(x_fri);
    disp(len_fri);
    %tfri = timeseries(y_fri, x_fri);
    if len_fri==96
        tfri = timeseries(y_fri, 1:96);

        tfri.Name = 'Daily Count';
        tfri.TimeInfo.Units = 'minutes';
        tfri.TimeInfo.StartDate = '00:00';     
        tfri.TimeInfo.Format = 'HH:MM';  
        tfri.TimeInfo.Increment = 15;
        tfri.Time = tfri.Time - tfri.Time(1);
        
        legend_list = [legend_list; {'Fri'}];

        plot(tfri);
        xlabel('Time (HH:MM)');
        ylabel('Active Power (kW)');
        title(strcat('Week ', num2str(i)));
        hold on;
    end

    x_sat = datetime(sat(sat_init+1:sat_change(i)-1, 1));
    y_sat = str2double(sat(sat_init+1:sat_change(i)-1, 2));

    x_sat = datestr(x_sat, 'HH:MM');
    len_sat = length(x_sat);
    disp(len_sat);
    %tsat = timeseries(y_sat, x_sat);
    if len_sat==96
        tsat = timeseries(y_sat, 1:96);

        tsat.Name = 'Daily Count';
        tsat.TimeInfo.Units = 'minutes';
        tsat.TimeInfo.StartDate = '00:00';     
        tsat.TimeInfo.Format = 'HH:MM';  
        tsat.TimeInfo.Increment = 15;
        tsat.Time = tsat.Time - tsat.Time(1);
        
        legend_list = [legend_list; {'Sat'}];

        plot(tsat);
        xlabel('Time (HH:MM)');
        ylabel('Active Power (kW)');
        title(strcat('Week ', num2str(i)));
        hold off;
    end
    
    legend('String', legend_list);
    
    
    
    
    sun_init = sun_change(i);
    mon_init = mon_change(i);
    tue_init = tue_change(i);
    wed_init = wed_change(i);
    thu_init = thu_change(i);
    fri_init = fri_change(i);
    sat_init = sat_change(i);
    
    
end
    
    
    
    

        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    