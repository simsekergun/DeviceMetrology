clear;
%%%%%%%%%%%%%%%%%%%%%%%%%%
set(0,'defaultlinelinewidth',3)
set(0,'DefaultAxesFontSize',18)
set(0,'DefaultTextFontSize',18)

m_pump = 243;
Dnormalizer = 1e9;

load './files_mn_mat_big/SiNtrainingDintSM1.mat'; %  'Dints','dimensions','m_values','final_lambdas'
m_values1 = m_values-m_pump;
Dints1 = Dints/Dnormalizer;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load './files_mn_mat_big/SiNtrainingDintSM2.mat'; %  'Dints','dimensions','m_values','final_lambdas'
m_values2 = m_values-m_pump;
Dints2 = Dints/Dnormalizer;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load './files_mn_mat_big/SiNtrainingDintSM3.mat'; %  'Dints','dimensions','m_values','final_lambdas'
m_values3 = m_values-m_pump;
Dints3 = Dints/Dnormalizer;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load './files_mn_mat_big/SiNtrainingDintSM4.mat'; %  'Dints','dimensions','m_values','final_lambdas'
m_values4 = m_values-m_pump;
Dints4 = Dints/Dnormalizer;

fig = figure(1); 
fig.Position = [200 400 1000 700];
subplot(2,2,1); plot(m_values1, Dints1);
xlabel('Mode Number');
ylabel('{\it{D}}_{int}/2\pi (GHz)');
xlim([-89 112]);
text(-140, 325,'(a)','FontSize',21);
text(120, 325,'(b)','FontSize',21);
text(-140, -480,'(c)','FontSize',21);
text(120, -480,'(d)','FontSize',21);
text(10, -260,'SM1 (Gas Ratio 3:1)')

grid on;
subplot(2,2,2); plot(m_values2, Dints2);
xlabel('Mode Number');
ylabel('{\it{D}}_{int}/2\pi (GHz)');
xlim([-89 112]);
grid on;
text(10, -360,'SM2 (Gas Ratio 5:1)')

subplot(2,2,3); plot(m_values3, Dints3);
xlabel('Mode Number');
ylabel('{\it{D}}_{int}/2\pi (GHz)');
xlim([-89 112]);
grid on;
text(10, -370,'SM3 (Gas Ratio 7:1)')

subplot(2,2,4); plot(m_values4, Dints4);
xlabel('Mode Number');
ylabel('{\it{D}}_{int}/2\pi (GHz)');
xlim([-89 112]);
text(10, -550,'SM4 (Gas Ratio 15:1)')
grid on;
print -dpng figure_Dint_SMs


fig = figure(2); 
fig.Position = [200 400 700 700];
subplot(2,1,1); plot(m_values1, Dints1);
xlabel('Mode Number');
ylabel('{\it{D}}_{int}/2\pi (GHz)');
xlim([-89 112]);
text(-120, 315,'(a)','FontSize',21);
text(-120, -500,'(b)','FontSize',21);
text(50, -260,'SM1 (Gas Ratio 3:1)')
grid on;


subplot(2,1,2); plot(m_values4, Dints4);
xlabel('Mode Number');
ylabel('{\it{D}}_{int}/2\pi (GHz)');
xlim([-89 112]);
text(50, -550,'SM4 (Gas Ratio 15:1)')
grid on;
print -dpng figure_Dint_SM1and4
