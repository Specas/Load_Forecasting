function [] = crbm(x, y, nu, nh, nv, alpha, epochs)

    %Function to learn the crbm weights
    
    %First we initialize the weights. Bias weights are taken separately and
    %not as a part of the input data set.
    
    wuh = rand(nu, nh);
    wvh = rand(nv, nh);
    wuv = rand(nu, nv);

    
    %biases
    b = rand(1, nh);
    a = rand(1, nv);
    
    m = size(x, 1);
    
    for i=1:epochs
        
        for j=1:m
            
            %Setting history and visible layers
            u = x(j, :)';
            v = y(j, :)';
            
            %Now we run the markov chain and reconstruct
            [del_wuh, del_wuv, del_wvh, del_a, del_b, err] = reconstruct(u, v, wuh, wuv, wvh, a, b, 1000);
            
            %Updating weights
            wuh = wuh + alpha*del_wuh;
            wuv = wuv + alpha*del_wuv;
            wvh = wvh + alpha*del_wvh;
            a = a + alpha*del_a';
            b = b + alpha*del_b';
            
            %displaying error
            disp(err);
        end
    end   
end
    
    
            
            
            
    
    
    