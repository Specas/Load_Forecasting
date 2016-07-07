function xx = gen_features(x)

    %The function generates features for the given timestamp vector
    %The features are year, month, day of week, hour, minutes
    
    d = weekday(x);
    dv = datevec(x);
    xx = [dv(:, 2) d dv(:, 4) dv(:, 5)];
    
end