
% We extract the dimensions of interest and form "mini-batches"
% We also scale the data.
% Certain joint angles are 1-2 DOF, so don't model constant zero cols


clear batchdata minibatchdata batchdataindex
batchsize = 100;        %size of minibatches

clear seqlengths;

%combine the data into a large batch
batchdata = cdata; %flatten it into a standard 2d array
numcases = size(batchdata,1);

%Normalize the data
data_mean = mean(batchdata,1);
data_std = std(batchdata);
batchdata =( batchdata - repmat(data_mean,numcases,1) ) ./ ...
  repmat( data_std, numcases,1);

%Index the valid cases (we don't want to mix sequences)
%This depends on the order of our model
for jj=1:length(cdata)/96
  seqlengths(jj) = 96;
  if jj==1 %first sequence
    batchdataindex = n1+1:seqlengths(jj);
  else
    batchdataindex = [batchdataindex batchdataindex(end)+n1+1: ...
      batchdataindex(end)+seqlengths(jj)];
  end
end

%Randomly permuting
permindex = batchdataindex(randperm(length(batchdataindex)));

numfullbatches = floor(length(permindex)/batchsize);

%fit all minibatches of size batchsize
%note that since reshape works in colums, we need to do a transpose here
minibatchindex = reshape(permindex(1: ...
  batchsize*numfullbatches),...
  batchsize,numfullbatches)';

minibatch = num2cell(minibatchindex,2);
%tack on the leftover frames (smaller last batch)
leftover = permindex(batchsize*numfullbatches+1:end);
minibatch = [minibatch;num2cell(leftover,2)];

