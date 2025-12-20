clear;

load('COMSOL_Results.mat'); 

figure(1); clf; 
plot(mu_values, Dints_table/1e9);
xlabel('Relative Mode Index (\mu)');
ylabel('{\it{D}}_{int} (GHz)');
grid on;
axis tight;
