function [] = nn_params(x, y, xt, yt)

    %This function trains the network for hidden layers from 5 to 25 in
    %steps of 2 and finds the best hidden layer node size
    
    for i=5:2:25
        
        me = 0;
        min = 100;
        
        fprintf('Hidden Layer Size %d: ', i);
        
        for j=1:5
            
            net = nn_train(x, y, i);
            yf = net(xt')';
            
            m = calculate_mape(yt, yf);
            if m<min
                min = m;
            end
            me = me + m;
            
        end
        
        me = me/5; %Mean mape for 3 trials
        fprintf('MINIMUM MAPE IS %0.3f\n', min);
        fprintf('AVERAGE MAPE IS %0.3f\n\n', me);
        
    end
    
end
            
        
        