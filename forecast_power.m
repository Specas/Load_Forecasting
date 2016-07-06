function [predicted] = forecast_power(training)
    
    model = arima(1, 0, 0);
    estmodel = estimate(model, training);
    [predicted, y] = forecast(estmodel, 96);
end