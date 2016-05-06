function met = getF1N(label, pred)
% Compute F1-Norm
%
% Input 
%   label   - binary ground turth label
%   pred    - prediction
%
% Output
%   met     - a structure of F1N metric

if nargin < 2
    msg('Usage: met = ','getF1N(label, pred)');
    return
end

label = reg(label);
pred  = reg(pred);

% Compute confusion mat and f1
cm                = confmat(label,pred);
[f1n,pn,rn,ncm,s] = cm2f1n(cm);

% packing
met.f1n  = f1n;
met.pn   = pn;
met.rn   = rn;
met.ncm  = ncm;
met.s    = s;
