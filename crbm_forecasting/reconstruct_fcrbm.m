function [del_wh, del_wy, del_wv, del_au, del_av, del_ay, del_bu, del_bh, del_by, del_a, del_b, err] = reconstruct_fcrbm(u, v, wh, wv, wy, au, av, ay, by, bu, bh, a, b, y, n)

    %We run the markov chain and reconstruct after running it n times
    
    %Storing initial states
    u0 = u;
    v0 = v;
    h0 = [];
    
    %Calculating a cap and b cap (dynamic weights)
    
    aa = a + av*(((u'*au).*(y'*ay))');
    bb = b + bh*(((u'*bu).*(y'*by))');

    
    for i=1:n
        
        %We run the Markov chain
        
        h = sigmoid(bb + wh*(((y'*wy).*(v'*wv))'));
        
        if i==1
            h0 = h;
        end
        
        v = aa + wv*(((y'*wy).*(h'*wh))');
%         v = normrnd(v, 1);

    end
    
    un = u;
    vn = v;
    hn = h;
    
    
    %Calculating weight update values
    
    del_wh = h0*((v0'*wv).*(y'*wy)) - hn*((vn'*wv).*(y'*wy));
    del_wy = y*((v0'*wv).*(h0'*wh)) - y*((vn'*wv).*(hn'*wh));
    del_wv = v0*((y'*wy).*(h0'*wh)) - vn*((y'*wy).*(hn'*wh));
    
    %Dynamic bias updates
    
    del_au = u0*((y'*ay).*(v0'*av)) - un*((y'*ay).*(vn'*av));
    del_av = v0*((y'*ay).*(u0'*au)) - vn*((y'*ay).*(un'*au));
    del_ay = y*((u0'*au).*(v0'*av)) - y*((un'*au).*(vn'*av));
    
    del_bu = u0*((y'*by).*(h0'*bh)) - un*((y'*by).*(hn'*bh));
    del_bh = h0*((y'*by).*(u0'*bu)) - hn*((y'*by).*(un'*bu));
    del_by = y*((u0'*bu).*(h0'*bh)) - y*((un'*bu).*(hn'*bh));
    
    del_a = v0 - vn;
    del_b = h0 - hn;
    

    %Calculating error (MAE)
    err = mae(v0, vn);

    
end
        
        
        
        
        