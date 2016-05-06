function met = getF1F(label, pred)
% Compute F1-Frame
%
% Input 
%   label   - binary ground turth label
%   pred    - prediction
%
% Output
%   met     - a structure of F1F metric

if nargin < 2
    msg('Usage: met = ','getF1F(label, pred)');
    return
end

label = reg(label);
pred  = reg(pred);

% Compute confusion mat and f1
cm        = confmat(label,pred);
[f1f,p,r] = cm2f1f(cm);

% packing
met.f1f = f1f;
met.p   = p;
met.r   = r;
met.cm  = cm;
