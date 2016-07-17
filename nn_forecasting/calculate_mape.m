function err = calculate_mape(actual, forecasted)

    %Finds the mean absolute percentage error for the actual and
    %forecasted errors
    
    err_vec = ((abs(actual - forecasted))./actual)*100;
    err = sum(err_vec)/length(err_vec);
    
end