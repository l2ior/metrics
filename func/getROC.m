function met = getROC(label, pred)
% Compute the Receiver Operating Characteristics (ROC) curve
%
% Input 
%   label   - binary ground turth label
%   pred    - prediction
%
% Output
%   met     - a structure of roc metric

if nargin < 2
    msg('Usage: met =','getROC(label, pred)');
    return
end

pred  = pred(:);
label = label(:);

% Check if there is no ture positive
if sum(label) == 0
    warning('No ture positive found in groundturth\n');
    met.auc  = NaN;
    met.roc_x = [];
    met.roc_y = [];
    return;
end

% Check the size of pred and label
assert(numel(pred)==numel(label), 'pred and label size mismatch');

% Check if label contains only +1/-1
assert(numel(unique(label))<=2, 'label has to be binary for now');

% Compute ROC
vals = unique(pred);
roc  = zeros(length(vals),2);
POS  = label==1;
NEG  = label==-1;
for i = 1:length(vals)
    predpos = pred > vals(i);
    predneg = pred <=vals(i);

    TP = sum(POS & predpos);
    FP = sum(NEG & predpos);
    FN = sum(POS & predneg);
    TN = sum(NEG & predneg);

    TPR = 0;
    FPR = 0;
    if TP+FN ~= 0 
        TPR = TP/(TP+FN);
    end
    if TN+FP ~= 0
        FPR = FP/(TN+FP);
    end
    roc(i,:) = [TPR, FPR]; 
end

% Compute AUC
auc = getAUC(roc(:,2), roc(:,1));
if isnan(auc)
    error('AUC is NaN\n');
end

% Get output
met.auc     = auc;
met.rocx    = roc(:,2);
met.rocy    = roc(:,1);
met.confmat = confmat(label, pred);