% This a demo script for using the F1-event and other scores 
% reported in the paper.  Current metric is designed for binary
% classification only.
%
%    "Facial action unit event detection by cascade of tasks", ICCV 2013.
%
% Wen-Sheng Chu (wschu@cmu.edu)

addpath(genpath('func'));

% Load label and decision value
load('test.mat');
ind = label == 0;
label(ind) = [];
decV(ind)  = [];

%% Compute ROC
metR = getROC(label, decV)

%% Compute f1-frame
metF = getF1F(label, decV)

%% Compute f1-norm
metN = getF1N(label, decV)

%% Compute f1-event
metE = getF1E(label, decV)

%% Plots
% Plot inputs
figure(1); clf;
plot(label, 'linewidth', 3); hold on; plot(decV, 'r');
line([1, numel(decV)], [0, 0], 'linestyle', ':', 'color', 'k');
set(gcf,'position',[80,80,1000,500]); axis tight;
legend('label', 'decV', 'location', 'best');
title('Input signals'); setTightAxis(gca, 0.1);
xlabel('Frame index'); ylabel('Decision value');

% plot curves
figure(2); clf; 
subplot(121); plot(metR.rocx, metR.rocy, 'b', 'linewidth', 5);
title(sprintf('ROC curve (AUC=%.2f%%)', metR.auc*100)); grid on;
xlabel('False positive rate'); ylabel('True positive rate');

subplot(122); plot(metE.thresholds, metE.f1EventCurve, 'r', 'linewidth', 5); 
title(sprintf('F1-event curve (AUC=%.2f%%)', metE.auc*100)); grid on;
xlabel('Overlap threshold'); ylabel('F1-Event');
set(gcf,'position',[120,120,1200,500]);