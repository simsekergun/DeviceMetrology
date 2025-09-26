clear;
% mean_meanerrorsW45 =    6.2011    7.5337    7.1268
% mean_meanerrorsW21 =    8.6398   36.1693    7.7093


load ./files_mat_results/accuracy_vs_loc_SM2_noise50_45.mat % minerrorsW maxerrorsW meanerrorsW minerrorsH maxerrorsH meanerrorsH Ns center1s
center1s45 = center1s;
meanerrorsW45 = meanerrorsW;
mean_meanerrorsW45 = [mean(meanerrorsW(center1s<70)) mean(meanerrorsW(center1s<100 & center1s>80)) mean(meanerrorsW(center1s>130))]

load ./files_mat_results/accuracy_vs_loc_SM2_noise50_25.mat minerrorsW maxerrorsW meanerrorsW minerrorsH maxerrorsH meanerrorsH Ns center1s
mean_meanerrorsW21 = [mean(meanerrorsW(center1s<70)) mean(meanerrorsW(center1s<100 & center1s>80)) mean(meanerrorsW(center1s>130))]

csizee = 50;

fig = figure(56); clf;
fig.Position = [200 200 800 400]
s=scatter(center1s, meanerrorsW,'o', 'filled')%,center1s45, meanerrorsW45,'ro', 'filled'); 
s.MarkerFaceAlpha = 0.4;
s.MarkerEdgeAlpha = 0.4;
hold on
s= scatter(center1s45, meanerrorsW45,'o', 'filled')
s.MarkerFaceAlpha = 0.4;
s.MarkerEdgeAlpha = 0.4;
xlabel('Sampling Center Mode Number');
ylabel('Width Prediction Error (nm)');
ylim([0 60])
legend('25 {\it{D}}_{int} Samples','45 {\it{D}}_{int} Samples')
grid on;
axis tight;
print -dpng figure_accuracy_vs_loc_SM2_noise50_25_vs_45