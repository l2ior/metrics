function auc = getAUC(x,y)
% Compute Area Under the Curve (AUC) specified by coordinates 
% in vectors x anad y

[x, ind] = sort(x,'ascend');
y = y(ind);

xc = [eps; x(:); 1];
yc = [eps; y(:); 1];
xdiff = zeros(length(yc),1);
for i = 1:length(xdiff)-1
    xdiff(i) = xc(i+1)-xc(i);
end

auc = sum(xdiff.*yc);
