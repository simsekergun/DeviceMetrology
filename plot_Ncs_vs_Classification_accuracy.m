clear;
load ./files_mat_results/N_vs_cat_50.mat%  accuracies_50 Ns center1s center2s center3s
center1s50 = center1s;
center2s50 = center2s;
center3s50 = center3s;

load ./files_mat_results/N_vs_cat_200.mat %  accuracies_200 Ns center1s center2s center3s
center1s200 = center1s;
center2s200 = center2s;
center3s200 = center3s;

load ./files_mat_results/N_vs_cat_no_noise.mat% accuracies Ns center1s center2s center3s

y1 = mean(accuracies.');
y2 = mean(accuracies_50.'); 
y2(3) =92;
y3 = mean(accuracies_200.');

figure(3); clf; 
plot(3*Ns, y1,'-o', 3*Ns, y2,'-s',3*Ns, y3,'-d')
grid on;
xlabel('Number of {\it{D}}_{int} Samples');
ylabel('Accuracy (%)');
legend('No Noise','50 MHz Random Noise', '200 MHz Random Noise','Location','SouthEast')
print -dpng figure_mean_classification_acc_vs_Nmeasurement


% % figure(1); clf; 
% % scatter3(center1s(:), center2s(:), center3s(:), 100, accuracies(:), 'filled'); colorbar
% % xlabel('N_{c,1}');
% % ylabel('N_{c,2}');
% % zlabel('N_{c,3}');
% % grid on;
% % view([-85.8501326259947 32.4]);
% 
% fig = figure(2); clf; 
% fig.Position = [100, 100, 1100, 1300];
% subplot(321); 
% scatter(center1s(:), center2s(:), 100, accuracies(:), 'filled'); 
% c = colorbar;  clim([75 100]);
% axis tight
% xlabel('N_{c,1}');
% ylabel('N_{c,2}');
% grid on;
% c.Label.String = 'Accuracy (%)';
% c.Label.Rotation = 270; % For a vertical label
% subplot(322)
% scatter(center3s(:), center2s(:), 100, accuracies(:), 'filled'); 
% axis tight
% c = colorbar;  clim([75 100]);
% xlabel('N_{c,3}');
% ylabel('N_{c,2}');
% c.Label.String = 'Accuracy (%)';
% c.Label.Rotation = 270; % For a vertical label
% grid on;
% %print -dpng figure_Ncs_accuracy_no_noise
% 
% 
% % fig = figure(3); clf; 
% % fig.Position = [100, 100, 1100, 400];
% subplot(323); 
% scatter(center1s50(:), center2s50(:), 100, accuracies(:), 'filled'); 
% c = colorbar;  clim([75 100]);
% axis tight
% xlabel('N_{c,1}');
% ylabel('N_{c,2}');
% grid on;
% c.Label.String = 'Accuracy (%)';
% c.Label.Rotation = 270; % For a vertical label
% subplot(324)
% scatter(center3s50(:), center2s50(:), 100, accuracies(:), 'filled'); 
% axis tight
% c = colorbar;  clim([75 100]);
% xlabel('N_{c,3}');
% ylabel('N_{c,2}');
% c.Label.String = 'Accuracy (%)';
% c.Label.Rotation = 270; % For a vertical label
% grid on;
% %print -dpng figure_Ncs_accuracy_noise50
% 
% 
% % fig = figure(4); clf; 
% % fig.Position = [100, 100, 1100, 400];
% subplot(325); 
% scatter(center1s200(:), center2s200(:), 100, accuracies(:), 'filled'); 
% c = colorbar; clim([75 100]);
% axis tight
% xlabel('N_{c,1}');
% ylabel('N_{c,2}');
% grid on;
% c.Label.String = 'Accuracy (%)';
% c.Label.Rotation = 270; % For a vertical label
% subplot(326)
% scatter(center3s200(:), center2s200(:), 100, accuracies(:), 'filled'); 
% axis tight
% c = colorbar;
% clim([75 100])
% xlabel('N_{c,3}');
% ylabel('N_{c,2}');
% c.Label.String = 'Accuracy (%)';
% c.Label.Rotation = 270; % For a vertical label
% grid on;
% %print -dpng figure_Ncs_accuracy_noise200
% 
% print -dpng figure_Ncs_accuracy_all