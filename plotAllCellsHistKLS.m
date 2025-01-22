% histograms for all cell behaviors

outputfolder = '/Users/tklee/code/reya_image_analysis/code/';

load('/Users/tklee/code/reya_image_analysis/code/allCellsKLS.mat')

numCells = length(cells);
%% plot a histogram of all the cell vascular distances
vascularDistance = [];
for j = 1:length(cells)
    vascularDistance = [vascularDistance;cells(j).vascularDist];
end
figure(1)
bins = linspace(0,170,100);
hist(vascularDistance,bins);
h = findobj(gca,'Type','patch');
set(h,'FaceColor','r','EdgeColor','w')
% xlabel('Distance to vasculature (microns)')
% ylabel('Number of points')
axis([-5 155 0 1000])

osteoDistance = [];
for j = 1:length(cells)
    osteoDistance = [osteoDistance;cells(j).osteoDist];
end
figure(2)
bins = linspace(0,170,100);
hist(osteoDistance,bins);
h = findobj(gca,'Type','patch');
set(h,'FaceColor',[100 100 100]/255,'EdgeColor','w')
axis([-5 155 0 1000])

velocities = [];
for j = 1:length(cells)
    velocities = [velocities;cells(j).velocitySmooth(cells(j).runAvgWin/2:end-cells(j).runAvgWin/2)];
end
% 
% figure(3)
% bins = linspace(0,.1,100);
% n = hist(velocities,bins);
% bar(bins*3600,n./sum(n));
% % bar(bins*3600,[n_neg./sum(n_neg);n_pos./sum(n_pos)]','histc')
% axis([0 .04*3600 0 .15])
% xlabel('Velocity (microns/hour)')
% ylabel('Frequency')
% % legend('Lin-','Lin+')

avgdisp = zeros(numCells,1);
avgdisptime = zeros(numCells,1);

 
for j = 1:numCells
    avgdisp(j) = mean(cells(j).disp);
    avgdisptime(j) = mean(cells(j).disp)./(cells(j).times(end)-...
        cells(j).times(1))*60;
end

figure(3)
bins = linspace(0,1,8);
n = hist(avgdisptime,bins);
bar(bins,n,'k')
% n_pos = hist(avgdisptimepos,bins);
% n_neg = hist(avgdisptimeneg,bins);
% h13=bar(bins,[n_pos;n_neg]','histc')
% set(h13(1),'facecolor','k') % use color name
% set(h13(1),'EdgeColor','none') % or use RGB triple
% set(h13(2),'facecolor',[100 100 100]/255) % or use RGB triple
% set(h13(2),'EdgeColor','none') % or use RGB triple
xlabel('Average Displacement Over Time (microns/minute)')
ylabel('Number of Cells')
% legend('Lin+','Lin-')
axis([-.1 1.1 0 14])



% velocitiesneg = [];
% for j = 14:length(cells)
%     velocitiesneg = [velocitiesneg;cells(j).velocitySmooth(cells(j).runAvgWin/2:end-cells(j).runAvgWin/2)];
% end
% velocitiespos = [];
% for j = 1:13
%     velocitiespos = [velocitiespos;cells(j).velocitySmooth(cells(j).runAvgWin/2:end-cells(j).runAvgWin/2)];
% end
% 
% figure(3)
% bins = linspace(0,.1,100);
% n_neg = hist(velocitiesneg,bins);
% n_pos = hist(velocitiespos,bins);
% bar(bins*3600,[n_neg./sum(n_neg);n_pos./sum(n_pos)]','histc')
% axis([0 .04*3600 0 .12])
% % xlabel('Velocity (microns/hour)')
% % ylabel('Frequency')
% legend('Lin-','Lin+')
% 
% 
% pos = [cells.lineage]==1;
% neg = [cells.lineage]==-1;
% numPos = sum(pos);
% numNeg = sum(neg);
% maxdisppos = zeros(numCells,1);
% avgdisppos = zeros(numCells,1);
% maxdispneg = zeros(numCells,1);
% avgdispneg = zeros(numCells,1);
% 
% avgdisptimepos = zeros(numCells,1);
% avgdisptimeneg = zeros(numCells,1);
% 
% for j = find(pos)
%     maxdisppos(j) = max(cells(j).disp);
%     avgdisppos(j) = mean(cells(j).disp);
%     avgdisptimepos(j) = mean(cells(j).disp)./(cells(j).times(end)-...
%         cells(j).times(1))*60;
% end
% for j = find(neg)
%     maxdispneg(j) = max(cells(j).disp);
%     avgdispneg(j) = mean(cells(j).disp);
%     avgdisptimeneg(j) = mean(cells(j).disp)./(cells(j).times(end)-...
%         cells(j).times(1))*60;
% end
% 
% maxdisppos = maxdisppos(find(pos));
% avgdisppos = avgdisppos(find(pos));
% avgdisptimepos = avgdisptimepos(find(pos));
% 
% maxdispneg = maxdispneg(find(neg));
% avgdispneg = avgdispneg(find(neg));
% avgdisptimeneg = avgdisptimeneg(find(neg));
% 
% 
% 
% figure(4)
% bins = linspace(0,90,8);
% n_pos = hist(maxdisppos,bins);
% n_neg = hist(maxdispneg,bins);
% h4=bar(bins,[n_pos;n_neg]','histc')
% set(h4(1),'facecolor','red') % use color name
% set(h4(2),'facecolor',[0 1 0]) % or use RGB triple
% xlabel('Max Displacement (microns)')
% ylabel('Number of Cells')
% legend('Lin+','Lin-')
% 
% figure(5)
% bins = linspace(0,50,8);
% n_pos = hist(avgdisppos,bins);
% n_neg = hist(avgdispneg,bins);
% h5=bar(bins,[n_pos;n_neg]','histc')
% set(h5(1),'facecolor','k') % use color name
% set(h5(1),'EdgeColor','none') % or use RGB triple
% set(h5(2),'facecolor',[100 100 100]/255) % or use RGB triple
% set(h5(2),'EdgeColor','none') % or use RGB triple
% xlabel('Average Displacement (microns)')
% ylabel('Number of Cells')
% legend('Lin+','Lin-')
% axis([-5 60 0 40])
% %%
% figure(6)
% vascularDistancePos = [];
% for j = find(pos)
%     vascularDistancePos = [vascularDistancePos;cells(j).vascularDist];
% end
% bins = linspace(0,170,100);
% hist(vascularDistancePos,bins);
% h = findobj(gca,'Type','patch');
% set(h,'FaceColor','r','EdgeColor','w')
% % xlabel('Distance to vasculature (microns)')
% % ylabel('Number of points')
% axis([-5 155 0 2000])
% 
% %%
% figure(7)
% vascularDistanceNeg = [];
% for j = find(neg)
%     vascularDistanceNeg = [vascularDistanceNeg;cells(j).vascularDist];
% end
% bins = linspace(0,170,100);
% hist(vascularDistanceNeg,bins);
% h = findobj(gca,'Type','patch');
% set(h,'FaceColor','r','EdgeColor','w')
% % xlabel('Distance to vasculature (microns)')
% % ylabel('Number of points')
% axis([-5 155 0 5000])
% 
% %%
% figure(8)
% osteoDistancePos= [];
% for j = find(pos)
%     osteoDistancePos = [osteoDistancePos;cells(j).osteoDist];
% end
% bins = linspace(0,170,100);
% hist(osteoDistancePos,bins);
% h = findobj(gca,'Type','patch');
% set(h,'FaceColor',[100 100 100]/255,'EdgeColor','w')
% axis([-5 155 0 1000])
% 
% 
% %%
% figure(9)
% osteoDistanceNeg= [];
% for j = find(neg)
%     osteoDistanceNeg = [osteoDistanceNeg;cells(j).osteoDist];
% end
% bins = linspace(0,170,100);
% hist(osteoDistanceNeg,bins);
% h = findobj(gca,'Type','patch');
% set(h,'FaceColor',[100 100 100]/255,'EdgeColor','w')
% axis([-5 155 0 1800])
% 
% %%
% figure(10)
% [N C] = hist3([osteoDistanceNeg vascularDistanceNeg],{0:5:150, 0:5:150});
% [X,Y] = meshgrid(C{1},C{2});
% surf(X,Y,N)
% axis square
% xlabel('Vascular Distance')
% ylabel('Osteo Distance')
% colormap('hot')
% % axis([0 100 0 100 0 2000])
% 
% figure(11)
% [N C] = hist3([osteoDistancePos vascularDistancePos],{0:5:150, 0:5:150});
% [X,Y] = meshgrid(C{1},C{2});
% surf(X,Y,N)
% axis square
% xlabel('Vascular Distance')
% ylabel('Osteo Distance')
% colormap('hot')
% % axis([0 100 0 100 0 1000])
% 
% figure(12)
% [N C] = hist3([osteoDistance vascularDistance],{0:5:150, 0:5:150});
% [X,Y] = meshgrid(C{1},C{2});
% surf(X,Y,N)
% axis square
% xlabel('Vascular Distance')
% ylabel('Osteo Distance')
% colormap('hot')
% % axis([0 100 0 100 0 1000])
% 
% 
% %%
% figure(13)
% bins = linspace(0,1,8);
% n_pos = hist(avgdisptimepos,bins);
% n_neg = hist(avgdisptimeneg,bins);
% h13=bar(bins,[n_pos;n_neg]','histc')
% set(h13(1),'facecolor','k') % use color name
% set(h13(1),'EdgeColor','none') % or use RGB triple
% set(h13(2),'facecolor',[100 100 100]/255) % or use RGB triple
% set(h13(2),'EdgeColor','none') % or use RGB triple
% xlabel('Average Displacement Over Time (microns/minute)')
% ylabel('Number of Cells')
% legend('Lin+','Lin-')
% axis([-.1 1.1 0 14])

