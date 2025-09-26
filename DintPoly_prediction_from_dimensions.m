clear;
% This code will try to predict the integrated dispersion of a ring from
% ring widht and height
%%%%%%%%%%%%%%%%%%%%%%%%%%
set(0,'defaultlinelinewidth',3)
set(0,'DefaultAxesFontSize',18)
set(0,'DefaultTextFontSize',18)

m_pump = 243;
b = csvread('Luke_RW752p5_H647_RR23.csv', 1);
test_index = 1:45;                         %  use all the m values
exp_m_values = b(test_index ,2);  % 2nd column has the m values
Exp_Result = b(test_index ,4).';   % 4th column has the Dint measurement values


load ./files_mn_mat_big/SiNtraining_Dint_SM2.mat
sim_m_values = m_values-m_pump;
rng(3);

Dmax = 3.16e11;  % to normalize Dint values something between -1 and 1
m_pump = 243;    % m value nearest the pump

XTrain = dimensions*1e7; % size: (441, 2), min = 6.2, max = 9.5
Dints_normalized = Dints/Dmax; % size: (441, 209), min =-1.0527, max = 0.5622
YTrain = zeros(441,7);
Dints_normalized_fitted = zeros(441,209);
for ii = 1:441   
    model =polyfit(sim_m_values, Dints_normalized(ii,:), 6);
    YTrain(ii,1:7) = model;
    Dints_normalized_fitted(ii,1:209) = polyval(model,sim_m_values);
end
Ynormalizer = max(abs(YTrain));
YTrain = YTrain./repmat(Ynormalizer,441,1);
Xsim = [7.5, 6.45];
XTest = [7.462, 6.494];

figure(4);
subplot(121); plot(sim_m_values,Dints_normalized)
subplot(122); plot(sim_m_values,Dints_normalized_fitted)


num_samples = 441;
num_features = 209;

% Normalize input features (dimensions)
X_mean = mean(XTrain);
X_std = std(XTrain);
XTrain_normalized = (XTrain - X_mean) ./ X_std/2;
XTest_normalized = (XTest - X_mean) ./ X_std/2;
Xsim_normalized = (Xsim - X_mean) ./ X_std/2;

% Split data into training and validation
cv = cvpartition(size(XTrain,1), 'HoldOut', 0.1);
idxTrain = training(cv);
idxVal = test(cv);

XTrain_final = XTrain_normalized(idxTrain,:);
YTrain_final = YTrain(idxTrain,:);
XVal = XTrain_normalized(idxVal,:);
YVal = YTrain(idxVal,:);

% the neural network architecture 
layers = [
    featureInputLayer(2, 'Name', 'input', 'Normalization', 'none')
    
    fullyConnectedLayer(64, 'Name', 'fc1')
    batchNormalizationLayer('Name', 'bn1')
    leakyReluLayer(0.5, 'Name', 'leakyRelu1')
    dropoutLayer(0.1, 'Name', 'dropout1') % Increased dropout
    
    fullyConnectedLayer(128, 'Name', 'fc2')
    batchNormalizationLayer('Name', 'bn2')
    leakyReluLayer(0.5, 'Name', 'leakyRelu2')
    dropoutLayer(0.2, 'Name', 'dropout2') % Increased dropout
    
    fullyConnectedLayer(128, 'Name', 'fc3')
    batchNormalizationLayer('Name', 'bn3')
    leakyReluLayer(0.5, 'Name', 'leakyRelu3')
    dropoutLayer(0.2, 'Name', 'dropout3') % Increased dropout
    
    fullyConnectedLayer(7, 'Name', 'output')   
    regressionLayer('Name', 'regression')
];

% Training options with more regularization and patience
options = trainingOptions('adam', ...
    'MaxEpochs', 300, ... % More epochs with early stopping
    'MiniBatchSize', 16, ... % Smaller batch size
    'InitialLearnRate', 0.001, ... % Lower learning rate
    'LearnRateSchedule', 'piecewise', ...
    'LearnRateDropFactor', 0.5, ...
    'LearnRateDropPeriod', 50, ...
    'L2Regularization', 0.001, ...
    'ValidationData', {XVal, YVal}, ...
    'ValidationFrequency', 20, ...
    'ValidationPatience', 30, ... % Early stopping
    'Shuffle', 'every-epoch', ...
    'Verbose', true, ...
    'Plots', 'training-progress', ...
    'ExecutionEnvironment', 'auto');

% Train the network
net = trainNetwork(XTrain_final, YTrain_final, layers, options);

% Predict on test data
YPred_model = predict(net, XTest_normalized).*Ynormalizer;
YPred = polyval(YPred_model,sim_m_values);

% Predict on simulation data
YsimPred_model = predict(net, Xsim_normalized).*Ynormalizer;
YsimPred = polyval(YsimPred_model,sim_m_values);

% Plot results
% figure('Position', [100, 100, 1200, 500]);
figure(18);clf;
plot(sim_m_values,Dints_normalized(106,:)*1e3/2/pi,sim_m_values, YsimPred*1e3/2/pi,'--',sim_m_values, YPred*1e3/2/pi, exp_m_values, Exp_Result*1e3/2/pi,'ko');
xlabel('Mode Number');
ylabel('D_{int}/2\pi (GHz)');
legend('Simulation (W=750 nm, H = 645 nm)','NN Prediction (W=750 nm, H = 645 nm)',...
    'NN Prediction (W=746.2 nm, H = 649.4 nm)','Measurement (W=752 nm, H = 647 nm)',...
     'Location','SouthEast');
xlim([-70 110]);
grid on;
print -dpng figure_Dint_Pred_w_NN

% Save the trained network
save('ring_dispersion_predictor_SM2.mat', 'net', 'X_mean', 'X_std', 'Dmax','Ynormalizer');

