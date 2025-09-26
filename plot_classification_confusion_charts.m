set(0,'defaultlinelinewidth',2)
set(0,'DefaultAxesFontSize',18)
set(0,'DefaultTextFontSize',18)


load ./files_mat_results/pred_vs_truth.mat % YTest YPred

set(0,'defaultlinelinewidth',3)
set(0,'DefaultAxesFontSize',18)
set(0,'DefaultTextFontSize',18)

fig = figure(4); clf;
fig.Position = [200 200 400 350]
cm = confusionchart(YTest, YPred);
cm.FontSize = 14;
title('No Noise');
print -dpng figure_confusion_chart_no_noise



load ./files_mat_results/pred_vs_truth_50.mat % YTest YPred
fig = figure(5); clf;
fig.Position = [300 300 400 350]
cm = confusionchart(YTest, YPred);
cm.FontSize = 14;
title('\pm50 MHz Random Noise');
print -dpng figure_confusion_chart_50


load ./files_mat_results/pred_vs_truth_200.mat % YTest YPred
fig = figure(6); clf;
fig.Position = [400 400 400 350]
cm = confusionchart(YTest, YPred);
cm.FontSize = 14;
title('\pm200 MHz Random Noise');
print -dpng figure_confusion_chart_200
