
% This program runs the entire training set on the trained 1-hidden-layer
% network and saves the filtering distribution vectors in mini-batch format
% This is done before training a second CRBM on top of the first

% The program assumes that the following variables are set externally:
% n2    -- order of the next layer CRBM

batchsize = 100; %size of mini-batches

%take all valid examples (indexed by batchdataindex)
numcases = length(batchdataindex);

%Calculate contributions from directed visible-to-hidden connections
bjstar = zeros(numhid,numcases);
for hh = 1:n1
  bjstar = bjstar + B(:,:,hh)*batchdata(batchdataindex-hh,:)';
end

%Calculate "posterior" probability -- hidden state being on
%Note that it isn't a true posterior
bottomup = w*(batchdata(batchdataindex,:)./gsd)';

eta =  bottomup + ...                  %bottom-up connections
  repmat(bj, 1, numcases) + ...        %static biases on unit
  bjstar;                              %dynamic biases

filteringdist = 1./(1 + exp(-eta'));   %logistic

%Index the valid cases (we don't want to mix sequences)
%This depends on the order of the layers
for jj=1:length(cdata)/96
  if jj==1 %first sequence
    batchdataindex = n2+1:96-n1;
  else
    batchdataindex = [batchdataindex batchdataindex(end)+n2+1: ...
      batchdataindex(end)+96-n1];
  end
end

%now that we know all the valid starting frames, we can randomly permute
%the order, such that we have a balanced training set
permindex = batchdataindex(randperm(length(batchdataindex)));

%fit all minibatches of size batchsize
minibatchindex = reshape(permindex(1: ...
  batchsize*floor(length(permindex)/batchsize)),...
  floor(length(permindex)/batchsize),batchsize);
%Not all minibatches will be the same length ... 
%must use a cell array (the last batch is a different size)
minibatch = num2cell(minibatchindex,2);
%tack on the leftover frames (smaller last batch)
leftover = permindex(batchsize*...
  floor(length(permindex)/batchsize)+1:end);
minibatch = [minibatch;num2cell(leftover,2)];
