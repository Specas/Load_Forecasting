function [model] = tree(trainX,trainY,testX,testY)

%% Build the Load Forecasting Model
% The next few cells builds a Bagged Regression Trees model for day-ahead
% load forecasting given the training data. This model is then used on the
% test data to validate its accuracy. 

%% Build the Bootstrap Aggregated Regression Trees 
% The function TreeBagger is used to build the model, ie. a set of
% regression trees each with a different set of rules for performing the
% non-linear regression. We build an aggregate of 20 such trees, with a
% minimum leaf size of 20. The larger the leaf size the smaller the tree.
% This provides a control for overfitting and performance.

model = TreeBagger(50, trainX, trainY, 'method', 'regression', 'minleaf', 10) 


%simpleTree = prune(model.Trees{1}, 500);
%simpleTree = prune(simpleTree, simpleTree.prunelist(1)-10);
%view(simpleTree, 'names', labels);

%% Save Trained Model
% We can compact the model (to remove any stored training data) and save
% for later reuse

model = compact(model);
