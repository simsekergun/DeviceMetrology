clear;
% SM2 No Noise Dataset
% Prediction: 746.2434      649.3889 nm
% True Dimensions: 752  647 nm
% Errors: 5.7566      2.3888 nm
% SM2 50 MHz Random Noise Dataset
% Prediction: 752.0729      646.5977 nm
% True Dimensions: 752  647 nm
% Errors: 0.072954     0.40233 nm
% SM2 200 MHz Random Noise Dataset
% Prediction: 751.4733      652.3425 nm
% True Dimensions: 752  647 nm
% Errors: 0.52667      5.3425 nm
%%%%%%%%%%%%%%%%%%%%%%%%%%
set(0,'defaultlinelinewidth',3)
set(0,'DefaultAxesFontSize',18)
set(0,'DefaultTextFontSize',18)

rng(3);

Dmax = 3.16e11;  % to normalize Dint values something between -1 and 1
m_pump = 243;    % m value nearest the pump
l_alpha = 0.5;  %  leaky ReLu alpha

% Experimental data
b = csvread('RW752p5_H647_RR23.csv', 1);
test_index = 1:45;                         %  use all the m values
m_values_test = b(test_index ,2);  % 2nd column has the m values
XTest = b(test_index ,4).';   % 4th column has the Dint measurement values
% note that this  has to be multiplied with 1e3/2pi to determine GHz
% Dint/2pi
YTest = [7.52 6.47];            % ring dimensions nm/100

for cases = 1:3
    if cases ==1
        % no noise training dataset
        load ./files_mn_mat_big/SiNtraining_Dint_SM2.mat
        Dint_Dataset = Dints;

    elseif cases ==2
        % 50 MHz random noise dataset
        load ./files_mn_mat_big/SiNtraining_Dint_SM2_50.mat
        Dint_Dataset = Dints_50;

    else
        % 200 MHz random noise dataset
        load ./files_mn_mat_big/SiNtraining_Dint_SM2_200.mat
        Dint_Dataset = Dints_200;
    end

    XTrain_all = Dint_Dataset/Dmax;
    YTrain = dimensions*1e7;             % convert m to nm/100
    m_values_train_all = m_values-m_pump;

    [Lia, Locb] = ismember(m_values_train_all, m_values_test);

    XTrain = XTrain_all(:,Lia==1);
    m_values_train = m_values(Lia==1)-m_pump;
    lambdas_train = final_lambdas;

    if cases ==1
        figure(2); clf;    
        plot(m_values_train_all,XTrain_all(106,:)/2/pi*1e3,m_values_test,XTest/2/pi*1e3,'ro');
        xlabel('Mode Number')
        xlim([-65 50])
        ylabel('{\it{D}}_{int}/2\pi (GHz)')
        grid on;
        legend('Simulation (W = 750 nm, H = 645 nm)','Experiment (W = 752 nm, H = 647 nm)','Location','SouthEast')
        print -dpng figure_Luke_vs_Sim_all
    end

    % Normalize output to [-1, 1] using mapminmax
    [YTrainNorm, outputSettings] = mapminmax(YTrain', -1, 1);
    YTrainNorm = YTrainNorm';
    YTestNorm = mapminmax.apply(YTest', outputSettings)';

    if cases ==1
        % Display dataset information
        fprintf('Dataset Information:\n');
        fprintf('Training data: %d samples, %d features\n', size(XTrain, 1), size(XTrain, 2));
        fprintf('Training targets: %d samples, %d outputs\n', size(YTrainNorm, 1), size(YTrainNorm, 2));
        fprintf('Testing data: %d samples, %d features\n', size(XTest, 1), size(XTest, 2));
        fprintf('Testing targets: %d samples, %d outputs\n', size(YTestNorm, 1), size(YTestNorm, 2));
        fprintf('_____________________________________\n');
    end

    % Neural Network Architecture
    inputSize = size(XTrain, 2);
    outputSize = size(YTrainNorm, 2);

    % Network architecture
    layers = [
        featureInputLayer(inputSize, 'Name', 'input')

        fullyConnectedLayer(64, 'Name', 'fc1')
        leakyReluLayer(l_alpha, 'Name', 'leakyRelu1')  % Leaky ReLU with alpha = l_alpha

        fullyConnectedLayer(16, 'Name', 'fc3')
        leakyReluLayer(l_alpha, 'Name', 'leakyRelu3')  % Leaky ReLU with alpha = l_alpha

        fullyConnectedLayer(outputSize, 'Name', 'output')
        regressionLayer('Name', 'regressionOutput')
        ];

    % Training options
    options = trainingOptions('adam', ...
        'MaxEpochs', 200, ...
        'MiniBatchSize', 12, ...
        'InitialLearnRate', 0.001, ...
        'LearnRateSchedule', 'piecewise', ...
        'LearnRateDropFactor', 0.2, ...
        'LearnRateDropPeriod', 50, ...
        'Shuffle', 'every-epoch', ...
        'ValidationData', {XTest, YTestNorm}, ...
        'ValidationFrequency', 50, ...
        'Verbose', false, ...
        'Plots', 'none', ... % training-progress
        'ExecutionEnvironment', 'auto');

    % Train the network
    net = trainNetwork(XTrain, YTrainNorm, layers, options);

    % Make predictions
    YTrainPred = predict(net, XTrain);
    YTestPred = predict(net, XTest);

    YPred = mapminmax.reverse(YTestPred', outputSettings)';
    if cases ==1
        disp('SM2 No Noise Dataset')
    elseif cases ==2
        disp('SM2 50 MHz Random Noise Dataset')
    else
        disp('SM2 200 MHz Random Noise Dataset')
    end
    disp(['Prediction: ' num2str(YPred*100) ' nm'])
    disp(['True Dimensions: ' num2str(YTest*100) ' nm'])
    disp(['Errors: ' num2str(abs(YTest-YPred)*100) ' nm'])
end