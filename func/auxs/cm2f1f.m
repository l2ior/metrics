function [f1f,p,r] = cm2f1f(cm)
% Compute frame-based f1 score from confusion matrix
%
% Input
%   cm    -  a 2 x a confusion matrix
%
% Output
%   f1f   -  frame-based f1
%   p     -  precision
%   r     -  recall

if nargin < 1
    msg('Usage: [f1f,p,r] =','cm2f1f(cm)');
    return
end

% assert(cm(1)~=0, 'TP=0')

f1f = nan;
p   = 0;
r   = 0;
if cm(1) > 0 % TP has to be >0, otherwise just return 0
    p   = cm(1) / sum(cm(:,1));
    r   = cm(1) / sum(cm(1,:));
    f1f = 2*p*r / (p+r);
else
    [~,fname] = fileparts(mfilename('fullpath'));
    warning(['In ', fname, '.m: TP==0']);
end
