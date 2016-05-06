function met = getF1E(label, pred)
% Get F1-Event
%
% Input 
%   label   - binary ground turth label
%   pred    - prediction
%
% Output
%   met     - a structure of F1E metric

    if nargin < 2
        msg('Usage: met = ','getF1E(label, pred)');
        return
    end

    [gtSegs, nGtSeg] = getSegs( label );    % get gt segments
    [prSegs, nPrSeg] = getSegs( pred > 0 ); % get predicted segments

    gtFrm   = find(label > 0); % gt positive frames
    predFrm = find(pred  > 0); % predicted positive frames
    ths     = (0:.01:1)';      % overlap thresholds

    % Init
    nTh = numel(ths);
    TPP = zeros(nTh, 1); % TP for precision
    TPR = zeros(nTh, 1); % TP for recall

    % Compute overlap score for GT
    olScoreGt = zeros(nGtSeg, 1);
    for iSeg = 1:nGtSeg
        seg = gtSegs{iSeg};
        olScoreGt(iSeg) = numel(intersect(seg,predFrm)) / numel(seg);
    end

    % Compute overlap score for predicted segments
    olScorePr = zeros(nPrSeg, 1);
    for iSeg = 1:nPrSeg
        seg = prSegs{iSeg};
        olScorePr(iSeg) = numel(intersect(seg,gtFrm)) / numel(seg);
    end

    % Compute TP for recall and precision
    for iOl = 1:nTh
        TPR(iOl) = sum(olScoreGt >= ths(iOl));
        TPP(iOl) = sum(olScorePr >= ths(iOl));
    end
    ER = TPR / nGtSeg;
    EP = TPP / nPrSeg;

    % Compute f1-Event
    F1E_curve = 2 * ER .* EP ./ (ER + EP);

    % Compute AUC under the F1E curve
    x = [0; ths; 1];
    y = [1; F1E_curve; 0];
    auc = getAUC(x, y)
    if isnan(auc)
        warning('AUC is NaN (no true event exists)');
    end

    % Get Output
    met.f1EventCurve = F1E_curve;
    met.thresholds   = ths;
    met.TP_recall    = TPR;
    met.TP_precision = TPP;
    met.olScoreGt    = olScoreGt;
    met.olScorePr    = olScorePr;
    met.nGtSeg       = nGtSeg;
    met.nPrSeg       = nPrSeg;
    met.auc          = auc;
end

% Get segments from binary labels
function [segs, nSeg] = getSegs( labels )
    labels(labels~=1) = 0;

    comp = bwconncomp(labels);
    nSeg = comp.NumObjects;
    segs = comp.PixelIdxList;
end 
