%function [output] = data_extract(data_file_label)
%data=read_mixed_csv(data_file_label,',');
data=read_mixed_csv('BMSData_0.csv', ',');
[m, n]=size(data);

%Column labels
label = data(1, :);

%The input files are in different formats(columns are not always in 
% the same order). Hence we create a generic reading method which
% finds the indices of the columns that we require and loads data
% from those columns

%Finding the columns containing the required data
%Ind is a matrix that contain the indices of va, vb, vc, vgn, ia, 
% ib, ic, in, pfa, pfb, pfc, id, time in order
col_name = char('vltgA', 'vltgB', 'vltgC', 'vltgGN', 'currA', 'currB', 'currC', 'currN', 'PFA', 'PFB', 'PFC', 'eventId', 'eventTime');
%convert to cell matrix
col_name = cellstr(col_name);
ind = zeros(length(col_name), 1);
for i=1:length(col_name)
    ind(i) = find(strcmp(label, col_name(i)));
end


%Storing all data into individual vectors and scaling
va = str2double(data(2:end, ind(1)))./10;
vb = str2double(data(2:end, ind(2)))./10;
vc = str2double(data(2:end, ind(3)))./10;
vgn = str2double(data(2:end, ind(4)))./10;
ia = str2double(data(2:end, ind(5)))./10;
ib = str2double(data(2:end, ind(6)))./10;
ic = str2double(data(2:end, ind(7)))./10;
in = str2double(data(2:end, ind(8)))./10;
pfa = str2double(data(2:end, ind(9)))./100;
pfb = str2double(data(2:end, ind(10)))./100;
pfc = str2double(data(2:end, ind(11)))./100;
id = str2double(data(2:end, ind(12)));
tstmp = datetime(data(2:end, ind(13)),'InputFormat','M/dd/yyyy HH:mm');

%Storing all values with event ID 5 into separate vectors
mask = (id==5);
va5 = va(mask==1);
vb5 = vb(mask==1);
vc5 = vc(mask==1);
vgn5 = vgn(mask==1);
ia5 = ia(mask==1);
ib5 = ib(mask==1);
ic5 = ic(mask==1);
in5 = in(mask==1);

id5 = id(mask==1);
tstmp5 = tstmp(mask==1);

% We find the updated timestamp values by calling the function timeAssign
tstmp5_updated = timeAssign(tstmp5);
% We find the newly assigned values of power factor
pf5_updated = pfAssign(pfa, pfb, pfc, id);
pfa5 = pf5_updated(:, 1);
pfb5 = pf5_updated(:, 2);
pfc5 = pf5_updated(:, 3);

%Storing all the vectors in a single matrix. 
data_matrix=[va5 vb5 vc5 ia5 ib5 ic5 pfa5 pfb5 pfc5];
new_matrix=interpolate(data_matrix);
va5=new_matrix(:,1);
vb5=new_matrix(:,2);
vc5=new_matrix(:,3);
ia5=new_matrix(:,4);
ib5=new_matrix(:,5);
ic5=new_matrix(:,6);
pfa5=new_matrix(:,7);
pfb5=new_matrix(:,8);
pfc5=new_matrix(:,9);

%Now we calculate the power matrix
power = va5.*ia5.*pfa5 + vb5.*ib5.*pfb5 + vc5.*ic5.*pfc5;
power = power./1000; %In kW

%We need to interpolate the time and corresponding power values
[all_t,missing_t,bad_d]=find_missing_time(tstmp5_updated(1:end));
missing_p=interp1(datenum(tstmp5_updated),power,datenum(missing_t(1:end)));
tstmp5_updated_n=[tstmp5_updated ;missing_t'];

power=[power; missing_p'];


%We convert power to cell type for the output
power_final = num2cell(power(1:end));
%tstmp5_prefinal=datestr(tstmp5_updated_n(1:end-1));
%whos tstmp5_prefinal
tstmp5_final=cellstr(tstmp5_updated_n(1:end));
%Now we save it in a file with the column labels

output(:,1) = tstmp5_final;
output(:,2)= power_final;
output=sortrows(output,1);
tstmp_final=datetime(output(:,1));
power_final=cell2mat(output(:,2));
k=1;

disp(bad_d);
date_vec = datevec(tstmp_final);
date_final_vec = [date_vec(:, 1) date_vec(:, 2) date_vec(:, 3)];
aa = date_final_vec;
bad_vec = datevec(bad_d);
bad_final_vec = [bad_vec(:, 1) bad_vec(:, 2) bad_vec(:, 3)];
bb = bad_final_vec;
i=1;
j=1;
while(i<=size(bad_final_vec, 1))
    all_date = date_final_vec(j, :);
    rem_date = bad_final_vec(i, :);
    greater = 0;
    if(rem_date(2)>all_date(2))
        greater = 1;
    elseif(rem_date(2)<all_date(2))
        greater = -1;
    else
        if(rem_date(3)>all_date(3))
            greater = 1;
        elseif(rem_date(3)<all_date(3))
            greater = -1;
        else
            greater = 0;
        end
    end
    
    if greater == 1
        j=j+1;
    elseif greater == -1
        i=i+1;
    else
        power_final(j) = -1;
        j=j+1;
    end
end

power_final = num2cell(power_final);
tstmp_final = cellstr(tstmp_final);

output(:,1) = tstmp_final;
output(:,2)= power_final;
    
        
        




%end   

