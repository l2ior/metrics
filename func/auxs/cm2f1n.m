function [f1n,pn,rn,ncm,s] = cm2f1n(cm)
% Compute skew-normalized f1 score from confusion matrix
%
% Input
%   cm    -  confusion matrix
%
% Output
%   f1n   -  skew-normalized f1 score
%   pn    -  skew-normalized precision
%   rn    -  skew-normalized recall
%   ncm   -  skew-normalized confusion matrix
%   s     -  the skewness factor

if nargin < 1
    msg('Usage: [f1n,pn,rn,ncm,s]','= cm2f1n(cm)');
    return
end

[ncm, s] = normcm(cm);

f1n = 0;
pn  = 0;
rn  = 0;
if ncm(1) > 0 % TP has to be >0
  pn  = ncm(1) / sum(ncm(:,1));
  rn  = ncm(1) / sum(ncm(1,:));
  f1n = 2*pn*rn / (pn+rn);
end


function [ncm,skew] = normcm(cm)
% Compute skew-normalized confusion matrix 

nPos = sum(cm(:,1));
nNeg = sum(cm(:,2));

if nPos == 0
    ncm = zeros(2,2);
    [~,fname] = fileparts(mfilename('fullpath'));
    warning(['In ', fname, ': no positive samples found']);
    return;
end

skew = nNeg/nPos;
ncm  = [cm(:,1),cm(:,2)/skew];

