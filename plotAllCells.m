outputfolder = 'C:\Users\tklee.WIN\research\reya_image_analysis_2010\output';

load(fullfile(outputfolder,'allCells.mat'))

%% plotting
for j = 1:length(cells)
    hf = figure('Color','w','visible','off','Position',[0 0 800 1000]);
    subplot(4,1,1)
    plot(cells(j).times,cells(j).osteoDistSmooth,'b')
    hold on
    plot(cells(j).times,cells(j).proximalCutoff*cells(j).osteoProximal,'k')
    plot(cells(j).times,cells(j).contactCutoff*cells(j).osteoContact,'k')
    ylabel('microns')
    title([cells(j).expt, ' cell ',...
        num2str(cells(j).ID)])
    h1 = legend('Distance to Endosteal','Location','NorthOutside');
    set(h1,'FontSize',8)
    set(gca,'YLim',[0 60])
    Xlim = get(gca,'XLim');
    subplot(4,1,2)
    plot(cells(j).times,cells(j).vascularDistSmooth,'r')
    hold on
    plot(cells(j).times,cells(j).proximalCutoff*cells(j).vascularProximal,'k')
    plot(cells(j).times,cells(j).contactCutoff*cells(j).vascularContact,'k')
    set(gca,'YLim',[0 60])
    set(gca,'XLim',Xlim)
    ylabel('microns')
    h2 = legend('Distance to Vasculature','Location','NorthOutside');
    set(h2,'FontSize',8)
    subplot(4,1,3)
    plot(cells(j).times,cells(j).disp,'g')
    set(gca,'YLim',[0 60])
    set(gca,'XLim',Xlim)
    ylabel('microns')
    h3 = legend('Overall Displacement','Location','NorthOutside');
    set(h3,'FontSize',8)
    xlabel('seconds')
    subplot(4,1,4)
    plot(cells(j).times(cells(j).runAvgWin/2:end-cells(j).runAvgWin/2),...
        cells(j).velocitySmooth(cells(j).runAvgWin/2:end-cells(j).runAvgWin/2),'k')
    xlabel('seconds')
    ylabel('microns/second')
    h4 = legend('Velocity','Location','NorthOutside');
    set(h4,'FontSize',8)
    set(gca,'YLim',[0 .1])
    set(gca,'XLim',Xlim)
    saveas(hf,fullfile(outputfolder,'plots',[cells(j).expt, ' cell ',...
        num2str(cells(j).ID),'.png']),'png')
    close(hf)
end