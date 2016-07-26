% This is the "main" demo
% It trains two CRBM models, one on top of the other, and then
% demonstrates data generation

clear all; close all;
more off;   %turn off paging
clc;

%initialize RAND,RANDN to a different state
rand('state',sum(100*clock))
randn('state',sum(100*clock))

%Our important Motion routines are in a subdirectory
addpath('./Process')

%Load the supplied training data
%Motion is a cell array containing 3 sequences of walking motion (120fps)
%skel is struct array which describes the person's joint hierarchy
load Data/crbm_data2.mat
cdata = crbm_data2;
cdata = cdata(:, 2:end);

fprintf(1,'Preprocessing data \n');

%how-many timesteps do we look back for directed connections
%this is what we call the "order" of the model 
n1 = 3; %first layer
n2 = 3; %second layer
        
%Preprocessing to create minibatches
preprocess2
numdims = size(batchdata,2); %data (visible) dimension

%save some frames of our pre-processed data for later
%we need an initialization to generate 
initdata = batchdata(1:length(cdata),:);

%Set network properties
numhid1 = 150; numhid2 = 150; numepochs=2000;
gsd=1;          %fixed standard deviation for Gaussian units
nt = n1;        %crbm "order"
numhid=numhid1;
fprintf(1,'Training Layer 1 CRBM, order %d: %d-%d \n',nt,numdims,numhid);
restart=1;      %initialize weights
gaussiancrbm;

%Plot a representation of the weights
hdl = figure(3); weightreport
set(hdl,'Name','Layer 1 CRBM weights');

w1 = w; bj1 = bj; bi1 = bi; A1 = A; B1 = B;
save Results/layer1test.mat w1 bj1 bi1 A1 B1

getfilteringdist;
numhid = numhid2; nt=n2;
batchdata = filteringdist;
numdims = size(batchdata,2); %data (visible) dimension
fprintf(1,'Training Layer 2 CRBM, order %d: %d-%d \n',nt,numdims,numhid);
restart=1;      %initialize weights
binarycrbm; 

w2 = w; bj2 = bj; bi2 = bi; A2 = A; B2 = B;
save Results/layer2test.mat w2 bj2 bi2 A2 B2

save Results/modeltest.mat n1 n2 initdata numdims numhid batchdata restart numhid1 numhid2 gsd

clear all;
%Now use the 2-layer CRBM to generate a sequence of data
numframes = 96; %how many frames to generate
fr = 1;         %pick a starting frame from initdata
                 %will use max(n1,n2) frames of initialization data
visible = gen2(numframes, fr);

%visible contains the forecasted output
disp(visible);





%Plot a representation of the weights
hdl = figure(4); weightreport
set(hdl,'Name','Layer 2 CRBM weights');
% 
% %Plot top
% layer activations
% figure(5); imagesc(hidden2'); colormap gray;
% title('Top hidden layer, activations'); ylabel('hidden units'); xlabel('frames')
% %Plot middle-layer probabilities
% figure(6); imagesc(hidden1'); colormap gray;
% title('First hidden layer, probabilities'); ylabel('hidden units'); xlabel('frames')
% 
% fprintf(1,'Playing generated sequence\n');
% figure(2); expPlayData(skel, newdata, 1/30)

