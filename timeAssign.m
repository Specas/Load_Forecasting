function final_timestamp = timeAssign(timestmp)
m=size(timestmp,1);
for i=1:m
    date_vector=datevec(timestmp(i));
    min=date_vector(5);
    if(mod(min,15))
    k=floor(min/15);
    date_vector(5)=15*(k+1);
    timestmp(i)=datetime(date_vector);
    end  
final_timestamp=timestmp;
end
end
