

%% plotting
for j = 18
    hf=figure('Color','w','visible','off','Position',[0 0 800 1000]);
    subplot(3,1,1)
    plot(cells(j).times/60,cells(j).osteoDistSmooth,'Color',[1 1 1]*100/255,'LineWidth',3)
    hold on
%     plot(cells(j).times,cells(j).proximalCutoff*cells(j).osteoProximal,'k')
%     plot(cells(j).times,cells(j).contactCutoff*cells(j).osteoContact,'k')
    set(gca,'YLim',[0 100])
    Xlim = get(gca,'XLim');
    subplot(3,1,2)
    plot(cells(j).times/60,cells(j).vascularDistSmooth,'r','LineWidth',3)
    hold on
%     plot(cells(j).times,cells(j).proximalCutoff*cells(j).vascularProximal,'k')
%     plot(cells(j).times,cells(j).contactCutoff*cells(j).vascularContact,'k')
    set(gca,'YLim',[0 60])
    set(gca,'XLim',Xlim)
    subplot(3,1,3)
    plot(cells(j).times(cells(j).runAvgWin/2:end-cells(j).runAvgWin/2)/60,...
        cells(j).velocitySmooth(cells(j).runAvgWin/2:end-cells(j).runAvgWin/2),'g','LineWidth',3)
    set(gca,'YLim',[0 .1])
    set(gca,'XLim',Xlim)
    saveas(hf,fullfile(outputfolder,'plots',[cells(j).expt, ' cell ',...
        num2str(cells(j).ID),'.png']),'png')
end