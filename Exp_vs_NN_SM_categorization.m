clear;
% This code tries to determine which Sellmeier model should be used to
% describe the material dispersion.
% According to this code, the ring used for Luke_RW752p5_H647_RR23.csv
% should be Sellmeier model 2
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

% no of measurement in each region
XTrain = [];
YTrain = [];

mmin = 154;
mmax = 355;

load ./files_mn_mat_big/SiNtraining_Dint_SM1.mat
m_values_train_all = m_values-m_pump;
[Lia, Locb] = ismember(m_values_train_all, m_values_test);
XTrain = [XTrain; Dints(:,Lia==1)];
YTrain = [YTrain; ones(length(Dints),1)];

load ./files_mn_mat_big/SiNtraining_Dint_SM2.mat
m_values_train_all = m_values-m_pump;
[Lia, Locb] = ismember(m_values_train_all, m_values_test);
XTrain = [XTrain; Dints(:,Lia==1)];
YTrain = [YTrain; 2*ones(length(Dints),1)];

load ./files_mn_mat_big/SiNtraining_Dint_SM3.mat
m_values_train_all = m_values-m_pump;
[Lia, Locb] = ismember(m_values_train_all, m_values_test);
XTrain = [XTrain; Dints(:,Lia==1)];
YTrain = [YTrain; 3*ones(length(Dints),1)];

load ./files_mn_mat_big/SiNtraining_Dint_SM4.mat
m_values_train_all = m_values-m_pump;
[Lia, Locb] = ismember(m_values_train_all, m_values_test);
XTrain = [XTrain; Dints(:,Lia==1)];
YTrain = [YTrain; 4*ones(length(Dints),1)];

XTrain = XTrain/Dmax;
YTrain = categorical(YTrain); % convert integer labels to categorical

% Define network architecture
layers = [
    featureInputLayer(length(test_index))              % input size = number of features
    fullyConnectedLayer(64)             % hidden layer 1
    tanhLayer                           % good for [-1,1] inputs
    fullyConnectedLayer(32)             % hidden layer 2
    reluLayer                           % mix of activations often helps
    fullyConnectedLayer(4)              % output layer = # of classes
    softmaxLayer                        % softmax for multi-class
    classificationLayer];

% Training options
options = trainingOptions('adam', ...
    'MaxEpochs', 200, ...
    'MiniBatchSize', 32, ...
    'Shuffle','every-epoch', ...
    'Verbose',false, ...
    'Plots','training-progress');

% Train the network
net = trainNetwork(XTrain, YTrain, layers, options);

% Evaluate on test set
YPred = classify(net, XTest)
