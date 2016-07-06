clear();
data=read_mixed_csv('BMSData_0.csv',',');
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
end;


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
tstmp = data(2:end, ind(13));

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


%Now we calculate the power matrix
power = va5.*ia5.*pfa5 + vb5.*ib5.*pfb5 + vc5.*ic5.*pfc5;
power = power./1000; %In kW
%We convert power to cell type for the output
power = num2cell(power);

%Now we save it in a file with the column labels
output = [tstmp5_updated power];
output_label = cellstr(char('Date Time', 'Active Power'))';
output = [output_label; output]

fid = fopen('output.csv', 'wt');
for i=1:(length(id5)+1)
    fprintf(fid, '%s,', output{i,1});
    fprintf(fid, '%s\n', output{i,2});
end;
fclose(fid);
    




