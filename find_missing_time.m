function [all_time,missing_time,bad_day] =find_missing_time(time)

start_time=time(1);

i=2;
while(time(i)<time(end))
    vector_time = datevec(start_time);
    vector_time(5)= vector_time(5)+15;
    start_time=datetime(vector_time);
    all_time(i)=start_time;
    i=i+1;
end
j=1;
k=1;
for i=1:(size(time,1)-1)
    diff=(etime(datevec(time(i+1)),datevec(time(i))))/60;
    if(diff>15 && diff <150)
        n=0;
        temp_vec=datevec(time(i));
        while(n<(diff-15))            
            temp_vec(5)=temp_vec(5)+15;
            missing_time(j)=datetime(temp_vec);
            j=j+1;
            n=n+15;
        end
    else if(diff>150)
        temp_vec=datevec(time(i));
        temp_vec(5)=0;
        temp_vec(4)=0;
        bad_day(k)=datetime(temp_vec);
        k=k+1;
              
        end
    end
end
bad_day_t=datenum(bad_day(1:end));
offset_day=[0 bad_day_t];
temp_day=[bad_day_t 0];
diff_day=temp_day-offset_day;
diff_day=diff_day(1:end-1);
j=1;
for i=1:length(bad_day)
    if(diff_day(i)~=0)
        new_day(j)=bad_day(i);
        j=j+1;
    end
end
bad_day=new_day;
end
        
    