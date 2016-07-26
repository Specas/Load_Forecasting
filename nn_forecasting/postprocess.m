function v = postprocess(visible)

    %Loading std and mean to reconstruct from normalized data

    load Data/st1.mat
    load Data/me1.mat

    v = visible.*repmat(st, 96, 1) + repmat(me, 96, 1);
    
end