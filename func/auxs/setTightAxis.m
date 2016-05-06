function setTightAxis(ax, margin)

if ~exist('margin','var')
    margin = 0;
else
    assert(margin<=0.5 && margin>=0, 'Margin has to be in [0,1]');
end

margin = margin / 2;

pos = get(ax,'position');
outerpos = get(ax,'OuterPosition');
ti = get(ax,'TightInset'); 
left = outerpos(1) + ti(1) + margin;
bottom = outerpos(2) + ti(2) + margin;
ax_width = outerpos(3) - ti(1) - ti(3) - margin*2;
ax_height = outerpos(4) - ti(2) - ti(4) - margin*2;
set(ax,'Position', [left bottom ax_width ax_height]);