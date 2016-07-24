function [del_wuh, del_wuv, del_wvh, del_a, del_b, err] = reconstruct(u, v, wuh, wuv, wvh, a, b, n)

    %We run the markov chain and reconstruct after running it n times
    
    %Storing initial states
    u0 = u;
    v0 = v;
    h0 = [];

    
    for i=1:n
        
        %First we find the probability of the hidden layer conditioned on
        %the other layers
        
        h = (sigmoid(u'*wuh + v'*wvh + b))';
        
        if i==1
            h0 = h;
        end
        
        v = wuv'*u + wvh*h + a';
%         v = normrnd(v, 1);

    end
    
    un = u;
    vn = v;
    hn = h;
    
    
    %Calculating weight update values (Contrastive divergence)
    del_wuh = u0*h0' - un*hn';
    del_wuv = u0*v0' - un*vn';
    del_wvh = v0*h0' - vn*hn';
    del_a = v0 - vn;
    del_b = h0 - hn;
    
    %Calculating error (MAE)
    err = mae(v0, vn);

    
end
        
        
        
        
        