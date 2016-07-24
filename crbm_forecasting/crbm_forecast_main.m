clc;
clear all;

data = load('data.dat');

%Number of hidden, visible and history units

nu = 2;
nv = 1;
nh = 10;

x = data(:, 1:nu);
y = data(:, nu+1:nu+nv);

alpha = 0.001;
epochs = 200;

crbm(x, y, nu, nh, nv, alpha, epochs);




