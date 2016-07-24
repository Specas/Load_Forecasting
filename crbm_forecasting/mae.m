function err = mae(ycalc, yexp)

    %Finds mean absolute error
    sum_err = sum(abs(ycalc-yexp));
    err = sum_err/length(ycalc);
    
end