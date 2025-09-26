function [MAE, MSE, RMSE, MAPE, R2] = regression_metrics(true_values, predictions)
    true_values = true_values(:);
    predictions = predictions(:);
    
    errors = true_values - predictions;
    
    MAE = mean(abs(errors));
    MSE = mean(errors.^2);
    RMSE = sqrt(MSE);
    MAPE = mean(abs(errors) ./ abs(true_values)) * 100;
    
    SS_res = sum(errors.^2);
    SS_tot = sum((true_values - mean(true_values)).^2);
    R2 = 1 - SS_res/SS_tot;
end