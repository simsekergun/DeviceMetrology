clear;
%%%%%%%%%%%%%%%%%%%%%%%%%%
set(0,'defaultlinelinewidth',3)
set(0,'DefaultAxesFontSize',18)
set(0,'DefaultTextFontSize',18)

rng(1);

% no of measurement in each region
Ns = 25;  % HAS TO BE AN ODD NUMBER
Nhalf = 12;    
no_of_trials = 1000;


load ./files_mn_mat_big/SiNtraining_Dint_SM2_50.mat
Dint_Dataset = Dints_50;
[adsa, Nall] = size(Dint_Dataset);
xmax = max(max(abs(Dint_Dataset)));
XTrain = Dint_Dataset/xmax;
YTrain = dimensions*1e7;
m_values_train = m_values;
lambdas_train = final_lambdas;

load('./files_mn_mat_big/SiNtest_Dint_SM2_50.mat')
Dint_TestDataset = Dints_50;

XTest = Dint_TestDataset/xmax;
YTest = dimensions*1e7;
m_values_test = m_values;
lambdas_test = final_lambdas;

% Normalize input and output to [-1, 1] using mapminmax
[XTrainNorm, inputSettings] = mapminmax(XTrain', -1, 1); % Transpose for mapminmax
[YTrainNorm, outputSettings] = mapminmax(YTrain', -1, 1);

XTrainNorm = XTrainNorm'; % Transpose back
YTrainNorm = YTrainNorm';

% Normalize XTest and YTest using training settings
XTestNorm = mapminmax.apply(XTest', inputSettings)';
YTestNorm = mapminmax.apply(YTest', outputSettings)';


N1 = floor(Nall/3);
N2 = floor(2*Nall/3);


minerrorsW = zeros(length(Ns), no_of_trials);
maxerrorsW = zeros(length(Ns), no_of_trials);
meanerrorsW = zeros(length(Ns), no_of_trials);
minerrorsH = zeros(length(Ns), no_of_trials);
maxerrorsH = zeros(length(Ns), no_of_trials);
meanerrorsH = zeros(length(Ns), no_of_trials);

center1s= zeros(length(Ns), no_of_trials);
center2s= zeros(length(Ns), no_of_trials);
center3s= zeros(length(Ns), no_of_trials);

for iNs = 1:length(Ns)
    N = Ns(iNs);
    
    parfor trial_no = 1:no_of_trials
        disp([iNs, trial_no])

        center1 = randi([Nhalf+1, Nall-Nhalf-1],1,1);
        center1s(iNs,trial_no) = center1;

        samples = center1-Nhalf:center1+Nhalf;

        % Define network architecture
        % Create and configure the feedforward neural network
        hiddenLayerSize = 20;  % You can tune this
        net = fitnet(hiddenLayerSize, 'trainlm');  % Levenberg-Marquardt

        % Training options
        net.trainParam.epochs = 100;
        net.trainParam.goal = 1e-9;
        net.trainParam.min_grad = 1e-7;
        net.trainParam.showWindow = true;
        net.performFcn = 'mse';  % Mean squared error

        % Use all data for training (no internal division)
        net.divideParam.trainRatio = 1.0;
        net.divideParam.valRatio = 0.0;
        net.divideParam.testRatio = 0.0;

        % Train the network
        [net, tr] = train(net, XTrainNorm(:,samples)', YTrainNorm');

        % Predict on test data
        YPredNorm = net(XTestNorm(:,samples)');
        YPred = mapminmax.reverse(YPredNorm, outputSettings)';  % Convert back to original scale

        % plot actual vs predicted
        yt1 = 1e2*YTest(:,1);
        yt2 = 1e2*YTest(:,2);
        pred1 = 1e2*YPred(:,1);
        pred2 = 1e2*YPred(:,2);

        errors_percentile1 = 100*abs(yt1-pred1)./yt1;
        disp([min(errors_percentile1) mean(errors_percentile1) max(errors_percentile1)]);
        normal_errorsW = abs(yt1-pred1);
        normal_errorsH = abs(yt2-pred2);

        minerrorsW(iNs, trial_no) = min(normal_errorsW);
        maxerrorsW(iNs, trial_no) = max(normal_errorsW);
        meanerrorsW(iNs, trial_no) = mean(normal_errorsW);
        minerrorsH(iNs, trial_no) = min(normal_errorsH);
        maxerrorsH(iNs, trial_no) = max(normal_errorsH);
        meanerrorsH(iNs, trial_no) = mean(normal_errorsH);

    end
end

save ./files_mat_results/accuracy_vs_loc_SM2_noise50_25.mat minerrorsW maxerrorsW meanerrorsW minerrorsH maxerrorsH meanerrorsH Ns center1s


csizee = 50;

figure(56); clf;
plot(center1s, meanerrorsW,'o');
xlabel('Sampling Center Mode Number');
ylabel('Width Prediction Error (nm)');
grid on;
axis tight;
print -dpng figure_accuracy_vs_loc_SM2_noise50_25