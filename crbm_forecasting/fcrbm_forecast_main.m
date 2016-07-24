clc;
clear all;

data = load('data.dat');

%Number of hidden, visible and history units

nu = 2;
nv = 1;
nh = 10;
ny = 1;

x = data(:, 1:nu);
y = data(:, nu+1:nu+nv);

alpha = 0.001;
epochs = 2000;

fcrbm(x, y, nu, nh, nv, ny, alpha, epochs);