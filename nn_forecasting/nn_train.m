function [net] = nn_train(x_train, power_train)

    %Function to train a neural network
    
    x = x_train';
    t = power_train';

%     trainFcn = 'trainlm';  % Levenberg-Marquardt backpropagation.
    trainFcn = 'trainbr';
%     trainFcn = 'trainscg';

    % Number of hidden layers and fit network
    hiddenLayerSize = 10;
    net = fitnet(hiddenLayerSize,trainFcn);

    % Dada division for training, cross validation and testing sets
    net.divideParam.trainRatio = 70/100;
    net.divideParam.valRatio = 15/100;
    net.divideParam.testRatio = 15/100;

    % Train the Network
    [net,tr] = train(net,x,t);

    % Test the Network
    y = net(x);
%     e = gsubtract(t,y);
    performance = perform(net,t,y);

    %figure, plotperform(tr)
    %figure, plottrainstate(tr)
    %figure, ploterrhist(e)
    %figure, plotregression(t,y)
    %figure, plotfit(net,x,t)
end

