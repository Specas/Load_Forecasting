clear();

data_output1=data_extract('BMSData_0.csv');
output_label = cellstr(char('Date Time', 'Active Power'))';
data_final_output = [output_label; data_output1];

data_output2=data_extract('BMSData_1.csv');
data_final_output = [data_final_output; data_output2];

%Saving of the output data in csv format.
fid = fopen('output.csv', 'wt');
fprintf(fid, '%s,', data_final_output{1,1});
fprintf(fid, '%s\n', data_final_output{1,2});
for i=2:(length(data_final_output))
    fprintf(fid, '%s,', data_final_output{i,1});
    tw=data_final_output(i,2);
    tw=tw{:};
    fprintf(fid, '%f\n', tw);
end;
fclose(fid);