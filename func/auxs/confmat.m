function cm = confmat(label,pred)
% cm = confmat(label,pred)
%
% Compute confusion matrix:
%   cm = | TP FP |
%        | FN TN |
%
% Input 
%   label   - ground truth label
%   pred    - prediction

if nargin <= 0
    msg('Usage: cm =','confmat(label,pred)');
    return
end

pred = reshape(reg(pred), size(label));

TP = sum( (pred==1) & (label==1) );
TN = sum( (pred~=1) & (label~=1) );
FP = sum( (pred==1) & (label~=1) );
FN = sum( (pred~=1) & (label==1) );

cm = [TP,FN; FP,TN];
