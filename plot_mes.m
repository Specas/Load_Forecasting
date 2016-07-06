clear;
clc;

data=read_mixed_csv('output_mean_energy_std.csv', ',');

time=datetime(data(2:end-1,1));
mean=str2double(data(2:end-1,2));
std = str2double(data(2:end-1, 3));
energy = str2double(data(2:end-1, 4));


figure;
subplot(3, 1, 1);
plot(time, mean, 'b');
title('Mean Plot');
xlabel('Day');
ylabel('Mean (kW)');

subplot(3, 1, 2);
plot(time, std, 'r');
title('Standard Deviation Plot');
xlabel('Day');
ylabel('Standard Deviation');

subplot(3, 1, 3);
plot(time, energy, 'g');
title('Energy Plot');
xlabel('Day');
ylabel('Energy (kWh)');




