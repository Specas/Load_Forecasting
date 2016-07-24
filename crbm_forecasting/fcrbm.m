function [] = fcrbm(xx, yy, nu, nh, nv, ny, alpha, epochs)

    %Initializing weights
    
    wh = rand(nh, 1);
    wv = rand(nv, 1);
    wy = rand(ny, 1);
    
    au = rand(nu, 1);
    av = rand(nv, 1);
    ay = rand(ny, 1);
    
    by = rand(ny, 1);
    bu = rand(nu, 1);
    bh = rand(nh, 1);
    
    %Initialize style layer
    y = 1;
    
    %bias weights
    b = rand(nh, 1);
    a = rand(nv, 1);
    
    m = size(xx, 1);
    
    for j=1:epochs
        
        for i=1:m
            
            %Setting u and v
            u = xx(i, :)';
            v = yy(i, :)';
            
            [del_wh, del_wy, del_wv, del_au, del_av, del_ay, del_bu, del_bh, del_by, del_a, del_b, err] = reconstruct_fcrbm(u, v, wh, wv, wy, au, av, ay, by, bu, bh, a, b, y, 10000);
            
            %Updating weights
            wh = wh + alpha*del_wh;
            wy = wy + alpha*del_wy;
            wv = wv + alpha*del_wv;
            
            au = au + alpha*del_au;
            av = av + alpha*del_av;
            ay = ay + alpha*del_ay;
            
            bu = bu + alpha*del_bu;
            bh = bh + alpha*del_bh;
            by = by + alpha*del_by;
            
            a = a + alpha*del_a;
            b = b + alpha*del_b;
            
            %display error
            disp(err);
        end
    end
end
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    
    