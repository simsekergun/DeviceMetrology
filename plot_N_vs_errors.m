clear;
load ./files_mat_results/N_vs_w_h_error_SM1_50.mat; % minerrorsW maxerrorsW meanerrorsW minerrorsH maxerrorsH meanerrorsH Ns
meanerrorsW_SM1_50 = meanerrorsW;
meanerrorsH_SM1_50 = meanerrorsH;
errorsW_SM1_50 = max(meanerrorsW.')-min(meanerrorsW.');
errorsH_SM1_50 = max(meanerrorsH.')-min(meanerrorsH.');

load ./files_mat_results/N_vs_w_h_error_SM2_50.mat;
meanerrorsW_SM2_50 = meanerrorsW;
meanerrorsH_SM2_50 = meanerrorsH;
errorsW_SM2_50 = max(meanerrorsW.')-min(meanerrorsW.');
errorsH_SM2_50 = max(meanerrorsH.')-min(meanerrorsH.');

load ./files_mat_results/N_vs_w_h_error_SM3_50.mat;
meanerrorsW_SM3_50 = meanerrorsW;
meanerrorsH_SM3_50 = meanerrorsH;
errorsW_SM3_50 = max(meanerrorsW.')-min(meanerrorsW.');
errorsH_SM3_50 = max(meanerrorsH.')-min(meanerrorsH.');


load ./files_mat_results/N_vs_w_h_error_SM4_50.mat;
meanerrorsW_SM4_50 = meanerrorsW;
meanerrorsH_SM4_50 = meanerrorsH;
errorsW_SM4_50 = max(meanerrorsW.')-min(meanerrorsW.');
errorsH_SM4_50 = max(meanerrorsH.')-min(meanerrorsH.');


load ./files_mat_results/N_vs_w_h_error_SM1_200.mat; 
meanerrorsW_SM1_200 = meanerrorsW;
meanerrorsH_SM1_200 = meanerrorsH;
errorsW_SM1_200 = max(meanerrorsW.')-min(meanerrorsW.');
errorsH_SM1_200 = max(meanerrorsH.')-min(meanerrorsH.');


load ./files_mat_results/N_vs_w_h_error_SM2_200.mat;
meanerrorsW_SM2_200 = meanerrorsW;
meanerrorsH_SM2_200 = meanerrorsH;
errorsW_SM2_200 = max(meanerrorsW.')-min(meanerrorsW.');
errorsH_SM2_200 = max(meanerrorsH.')-min(meanerrorsH.');


load ./files_mat_results/N_vs_w_h_error_SM3_200.mat;
meanerrorsW_SM3_200 = meanerrorsW;
meanerrorsH_SM3_200 = meanerrorsH;
errorsW_SM3_200 = max(meanerrorsW.')-min(meanerrorsW.');
errorsH_SM3_200 = max(meanerrorsH.')-min(meanerrorsH.');


load ./files_mat_results/N_vs_w_h_error_SM4_200.mat;
meanerrorsW_SM4_200 = meanerrorsW;
meanerrorsH_SM4_200 = meanerrorsH;
errorsW_SM4_200 = max(meanerrorsW.')-min(meanerrorsW.');
errorsH_SM4_200 = max(meanerrorsH.')-min(meanerrorsH.');


load ./files_mat_results/N_vs_w_h_error_SM1.mat; % minerrorsW maxerrorsW meanerrorsW minerrorsH maxerrorsH meanerrorsH Ns
meanerrorsW_SM1 = meanerrorsW;
meanerrorsH_SM1 = meanerrorsH;
errorsW_SM1 = max(meanerrorsW.')-min(meanerrorsW.');
errorsH_SM1 = max(meanerrorsH.')-min(meanerrorsH.');


load ./files_mat_results/N_vs_w_h_error_SM2.mat;
meanerrorsW_SM2 = meanerrorsW;
meanerrorsH_SM2 = meanerrorsH;
errorsW_SM2 = max(meanerrorsW.')-min(meanerrorsW.');
errorsH_SM2 = max(meanerrorsH.')-min(meanerrorsH.');


load ./files_mat_results/N_vs_w_h_error_SM3.mat;
meanerrorsW_SM3 = meanerrorsW;
meanerrorsH_SM3 = meanerrorsH;
errorsW_SM3 = max(meanerrorsW.')-min(meanerrorsW.');
errorsH_SM3 = max(meanerrorsH.')-min(meanerrorsH.');


load ./files_mat_results/N_vs_w_h_error_SM4.mat;
meanerrorsW_SM4 = meanerrorsW;
meanerrorsH_SM4 = meanerrorsH;
errorsW_SM4 = max(meanerrorsW.')-min(meanerrorsW.');
errorsH_SM4 = max(meanerrorsH.')-min(meanerrorsH.');






FS = 24;

x1 = -12;
y1 = 4.2;
y2 = 1.55;

fig = figure(2); clf;
fig.Position = [200, 200, 1400, 800];
subplot(231);
plot(3*Ns, mean(meanerrorsW_SM1.'), 3*Ns, mean(meanerrorsW_SM2.'),...
    3*Ns, mean(meanerrorsW_SM3.'), 3*Ns, mean(meanerrorsW_SM4.')); hold on;
ylabel('Ave. Width Pred. Error (nm)');
xlabel('Number of {\it{D}}_{int} Samples');
ylim([0 4]);
grid on;
legend('SM_1','SM_2','SM_3', 'SM_4')
text(x1,y1,'(a)','FontSize',FS);

subplot(234);
plot(3*Ns, mean(meanerrorsH_SM1.'), 3*Ns, mean(meanerrorsH_SM2.'),...
    3*Ns, mean(meanerrorsH_SM3.'), 3*Ns, mean(meanerrorsH_SM4.'))
ylim([0 1.5]);
ylabel('Ave. Height Pred. Error (nm)');
xlabel('Number of {\it{D}}_{int} Samples');
grid on;
legend('SM_1','SM_2','SM_3', 'SM_4')
text(x1,y2,'(d)','FontSize',FS);

subplot(232);
plot(3*Ns, mean(meanerrorsW_SM1_50.'), 3*Ns, mean(meanerrorsW_SM2_50.'),...
    3*Ns, mean(meanerrorsW_SM3_50.'), 3*Ns, mean(meanerrorsW_SM4_50.'))
ylabel('Ave. Width Pred. Error (nm)');
xlabel('Number of {\it{D}}_{int} Samples');
ylim([0 8]);
grid on;
% legend('SM_1','SM_2','SM_3', 'SM_4')
text(x1,2*y1,'(b)','FontSize',FS);

subplot(235);
plot(3*Ns, mean(meanerrorsH_SM1_50.'), 3*Ns, mean(meanerrorsH_SM2_50.'),...
    3*Ns, mean(meanerrorsH_SM3_50.'), 3*Ns, mean(meanerrorsH_SM4_50.'))
ylabel('Ave. Height Pred. Error (nm)');
xlabel('Number of {\it{D}}_{int} Samples');
ylim([0 3]);
grid on;
% legend('SM_1','SM_2','SM_3', 'SM_4')
text(x1,2*y2,'(e)','FontSize',FS);

subplot(233);
plot(3*Ns, mean(meanerrorsW_SM1_200.'), 3*Ns, mean(meanerrorsW_SM2_200.'),...
    3*Ns, mean(meanerrorsW_SM3_200.'), 3*Ns, mean(meanerrorsW_SM4_200.'))
ylabel('Ave. Width Pred. Error (nm)');
ylim([0 16]);
xlabel('Number of {\it{D}}_{int} Samples');
grid on;
% legend('SM_1','SM_2','SM_3', 'SM_4')
text(x1,4*y1,'(c)','FontSize',FS);

subplot(236);
plot(3*Ns, mean(meanerrorsH_SM1_200.'), 3*Ns, mean(meanerrorsH_SM2_200.'),...
    3*Ns, mean(meanerrorsH_SM3_200.'), 3*Ns, mean(meanerrorsH_SM4_200.'))
ylabel('Ave. Height Pred. Error (nm)');
xlabel('Number of {\it{D}}_{int} Samples');
grid on;
ylim([0 6]);
% legend('SM_1','SM_2','SM_3', 'SM_4')
text(x1,4*y2,'(f)','FontSize',FS);

print -dpng figure_N_vs_errors_all_2x3






x1 = -2;
y1 = 4.2;
y2 = 1.55;

% 
% 
% 
% % 
fig = figure(1); clf;
fig.Position = [200, 200, 1000, 1200];
subplot(321);
plot(3*Ns, mean(meanerrorsW_SM1.'), 3*Ns, mean(meanerrorsW_SM2.'),...
    3*Ns, mean(meanerrorsW_SM3.'), 3*Ns, mean(meanerrorsW_SM4.'));
ylabel('Ave. Width Pred. Error (nm)');
xlim([8 48]);
ylim([0 4])
xlabel('Number of {\it{D}}_{int} Samples');
grid on;
legend('SM_1','SM_2','SM_3', 'SM_4')
text(x1,y1,'(a)','FontSize',FS);

subplot(322);
plot(3*Ns, mean(meanerrorsH_SM1.'), 3*Ns, mean(meanerrorsH_SM2.'),...
    3*Ns, mean(meanerrorsH_SM3.'), 3*Ns, mean(meanerrorsH_SM4.'))
ylabel('Ave. Height Pred. Error (nm)');
xlabel('Number of {\it{D}}_{int} Samples');
xlim([8 48]);
ylim([0 1.5])
grid on;
legend('SM_1','SM_2','SM_3', 'SM_4')
text(x1,y2,'(b)','FontSize',FS);

subplot(323);
plot(3*Ns, mean(meanerrorsW_SM1_50.'), 3*Ns, mean(meanerrorsW_SM2_50.'),...
    3*Ns, mean(meanerrorsW_SM3_50.'), 3*Ns, mean(meanerrorsW_SM4_50.'))
ylabel('Ave. Width Pred. Error (nm)');
xlabel('Number of {\it{D}}_{int} Samples');
xlim([8 48]);
text(x1,2*y1,'(c)','FontSize',FS);
grid on;
%legend('SM_1','SM_2','SM_3', 'SM_4')

subplot(324);
plot(3*Ns, mean(meanerrorsH_SM1_50.'), 3*Ns, mean(meanerrorsH_SM2_50.'),...
    3*Ns, mean(meanerrorsH_SM3_50.'), 3*Ns, mean(meanerrorsH_SM4_50.'))
ylabel('Ave. Height Pred. Error (nm)');
xlabel('Number of {\it{D}}_{int} Samples');
text(x1,2*y2,'(d)','FontSize',FS);
xlim([8 48]);
ylim([0 3])
grid on;
%legend('SM_1','SM_2','SM_3', 'SM_4')

subplot(325);
plot(3*Ns, mean(meanerrorsW_SM1_200.'), 3*Ns, mean(meanerrorsW_SM2_200.'),...
    3*Ns, mean(meanerrorsW_SM3_200.'), 3*Ns, mean(meanerrorsW_SM4_200.'))
ylabel('Ave. Width Pred. Error (nm)');
xlabel('Number of {\it{D}}_{int} Samples');
text(x1,15*y1/4,'(e)','FontSize',FS);
xlim([8 48]);
grid on;
%legend('SM_1','SM_2','SM_3', 'SM_4')

subplot(326);
plot(3*Ns, mean(meanerrorsH_SM1_200.'), 3*Ns, mean(meanerrorsH_SM2_200.'),...
    3*Ns, mean(meanerrorsH_SM3_200.'), 3*Ns, mean(meanerrorsH_SM4_200.'))
ylabel('Ave. Height Pred. Error (nm)');
text(x1,y2*5/1.5,'(f)','FontSize',FS);
xlim([8 48]);
ylim([0 5])
xlabel('Number of {\it{D}}_{int} Samples');
grid on;
%legend('SM_1','SM_2','SM_3', 'SM_4')

print -dpng figure_N_vs_errors_all_3x2

