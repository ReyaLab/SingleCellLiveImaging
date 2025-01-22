% histograms for all cell behaviors

outputfolder = '/Users/tklee/code/reya_image_analysis/code/';

lin = load(fullfile(outputfolder,'allCells.mat'));
kls = load(fullfile(outputfolder,'allCellsKLS.mat'));
cells = lin.cells;
numCells = length(cells);
%% plot a histogram of all the cell vascular distances
vascularDistance = [];
for j = 1:length(cells)
    vascularDistance = [vascularDistance;cells(j).vascularDist];
end
figure(1)
bins = linspace(0,170,100);
hist(vascularDistance,bins);
figure(100)
[n x] = hist(vascularDistance,bins);
BreakBar(x,n,2500,5000)
% h = findobj(gca,'Type','patch');
% set(h,'FaceColor','r','EdgeColor','w')
% xlabel('Distance to vasculature (microns)')
% ylabel('Number of points')
% axis([-5 155 0 6000])
axis([-5 155 0 3500])

osteoDistance = [];
for j = 1:length(cells)
    osteoDistance = [osteoDistance;cells(j).osteoDist];
end
figure(2)
bins = linspace(0,170,100);
hist(osteoDistance,bins);
h = findobj(gca,'Type','patch');
set(h,'FaceColor',[100 100 100]/255,'EdgeColor','w')
axis([-5 155 0 3500])

velocitiesneg = [];
for j = 14:length(cells)
    velocitiesneg = [velocitiesneg;cells(j).velocitySmooth(cells(j).runAvgWin/2:end-cells(j).runAvgWin/2)];
end
velocitiespos = [];
for j = 1:13
    velocitiespos = [velocitiespos;cells(j).velocitySmooth(cells(j).runAvgWin/2:end-cells(j).runAvgWin/2)];
end

figure(3)
bins = linspace(0,.1,100);
n_neg = hist(velocitiesneg,bins);
n_pos = hist(velocitiespos,bins);
bar(bins*3600,[n_neg./sum(n_neg);n_pos./sum(n_pos)]','histc')
axis([0 .04*3600 0 .12])
% xlabel('Velocity (microns/hour)')
% ylabel('Frequency')
legend('Lin-','Lin+')

%%
pos = [cells.lineage]==1;
neg = [cells.lineage]==-1;
numPos = sum(pos);
numNeg = sum(neg);
maxdisppos = zeros(numCells,1);
avgdisppos = zeros(numCells,1);
maxdispneg = zeros(numCells,1);
avgdispneg = zeros(numCells,1);

avgdisptimepos = zeros(numCells,1);
avgdisptimeneg = zeros(numCells,1);

for j = find(pos)
    maxdisppos(j) = max(cells(j).disp);
    avgdisppos(j) = mean(cells(j).disp);
    avgdisptimepos(j) = mean(cells(j).disp)./(cells(j).times(end)-...
        cells(j).times(1))*60;
end
for j = find(neg)
    maxdispneg(j) = max(cells(j).disp);
    avgdispneg(j) = mean(cells(j).disp);
    avgdisptimeneg(j) = mean(cells(j).disp)./(cells(j).times(end)-...
        cells(j).times(1))*60;
end
for j = 1:numel(kls.cells)
    maxdispkls(j) = max(kls.cells(j).disp);
    avgdispkls(j) = mean(kls.cells(j).disp);
    avgdisptimekls(j) = mean(kls.cells(j).disp)./(kls.cells(j).times(end)-...
        kls.cells(j).times(1))*60;
end

maxdisppos = maxdisppos(find(pos));
avgdisppos = avgdisppos(find(pos));
avgdisptimepos = avgdisptimepos(find(pos));

maxdispneg = maxdispneg(find(neg));
avgdispneg = avgdispneg(find(neg));
avgdisptimeneg = avgdisptimeneg(find(neg));


%%
figure(4)
bins = linspace(0,90,8);
n_pos = hist(maxdisppos,bins);
n_neg = hist(maxdispneg,bins);
n_kls = hist(maxdispkls,bins);
h4=bar(bins,[n_pos;n_neg;n_kls]','histc')
set(h4(1),'facecolor','red') % use color name
set(h4(2),'facecolor',[0 1 0]) % or use RGB triple
xlabel('Max Displacement (microns)')
ylabel('Number of Cells')
legend('Lin+','Lin-','KLS')
%%
figure(5)
bins = linspace(0,50,8);
n_pos = hist(avgdisppos,bins);
n_neg = hist(avgdispneg,bins);
n_kls = hist(avgdispkls,bins);
h5=bar(bins,[n_pos;n_neg;n_kls]','histc')
set(h5(1),'facecolor','k') % use color name
set(h5(1),'EdgeColor','none') % or use RGB triple
set(h5(2),'facecolor',[100 100 100]/255) % or use RGB triple
set(h5(2),'EdgeColor','none') % or use RGB triple
xlabel('Average Displacement (microns)')
ylabel('Number of Cells')
legend('Lin+','Lin-','KLS')
axis([-5 60 0 40])
%%
figure(6)
vascularDistancePos = [];
for j = find(pos)
    vascularDistancePos = [vascularDistancePos;cells(j).vascularDist];
end
bins = linspace(0,170,100);
hist(vascularDistancePos,bins);
h = findobj(gca,'Type','patch');
set(h,'FaceColor','r','EdgeColor','w')
% xlabel('Distance to vasculature (microns)')
% ylabel('Number of points')
axis([-5 155 0 2000])

%%
figure(7)
vascularDistanceNeg = [];
for j = find(neg)
    vascularDistanceNeg = [vascularDistanceNeg;cells(j).vascularDist];
end
bins = linspace(0,170,100);
hist(vascularDistanceNeg,bins);
h = findobj(gca,'Type','patch');
set(h,'FaceColor','r','EdgeColor','w')
% xlabel('Distance to vasculature (microns)')
% ylabel('Number of points')
axis([-5 155 0 5000])

%%
figure(8)
osteoDistancePos= [];
for j = find(pos)
    osteoDistancePos = [osteoDistancePos;cells(j).osteoDist];
end
bins = linspace(0,170,100);
hist(osteoDistancePos,bins);
h = findobj(gca,'Type','patch');
set(h,'FaceColor',[100 100 100]/255,'EdgeColor','w')
axis([-5 155 0 1000])


%%
figure(9)
osteoDistanceNeg= [];
for j = find(neg)
    osteoDistanceNeg = [osteoDistanceNeg;cells(j).osteoDist];
end
bins = linspace(0,170,100);
hist(osteoDistanceNeg,bins);
h = findobj(gca,'Type','patch');
set(h,'FaceColor',[100 100 100]/255,'EdgeColor','w')
axis([-5 155 0 1800])

%%
figure(10)
[N C] = hist3([osteoDistanceNeg vascularDistanceNeg],{0:5:150, 0:5:150});
[X,Y] = meshgrid(C{1},C{2});
surf(X,Y,N)
axis square
xlabel('Vascular Distance')
ylabel('Osteo Distance')
colormap('hot')
% axis([0 100 0 100 0 2000])

figure(11)
[N C] = hist3([osteoDistancePos vascularDistancePos],{0:5:150, 0:5:150});
[X,Y] = meshgrid(C{1},C{2});
surf(X,Y,N)
axis square
xlabel('Vascular Distance')
ylabel('Osteo Distance')
colormap('hot')
% axis([0 100 0 100 0 1000])

figure(12)
[N C] = hist3([osteoDistance vascularDistance],{0:5:150, 0:5:150});
[X,Y] = meshgrid(C{1},C{2});
surf(X,Y,N)
axis square
xlabel('Vascular Distance')
ylabel('Osteo Distance')
colormap('hot')
% axis([0 100 0 100 0 1000])


%%
figure(13)
bins = linspace(0,1,8);
n_pos = hist(avgdisptimepos,bins);
n_neg = hist(avgdisptimeneg,bins);
n_kls = hist(avgdisptimekls,bins);
h13=bar(bins,[n_pos;n_neg;n_kls]','histc')
set(h13(1),'facecolor','k') % use color name
set(h13(1),'EdgeColor','none') % or use RGB triple
set(h13(2),'facecolor',[0 0 200]/255) % or use RGB triple
set(h13(2),'EdgeColor','none') % or use RGB triple
set(h13(3),'facecolor',[100 0 0]/255) % or use RGB triple
set(h13(3),'EdgeColor','none') % or use RGB triple
xlabel('Average Displacement Over Time (microns/minute)')
ylabel('Number of Cells')
legend('Lin+','Lin-','KLS')
axis([-.1 1.1 0 25])



%% plot a histogram of all the cell vascular distances
vascularDistance = [];
for j = 1:length(cells)
    vascularDistance = [vascularDistance;cells(j).vascularDist];
end
for j = 1:length(kls.cells)
    vascularDistance = [vascularDistance;kls.cells(j).vascularDist];
end
figure(14)
bins = linspace(0,170,100);
[n x] = hist(vascularDistance,bins);
BreakBar(x,n,2500,5000)
% h = findobj(gca,'Type','patch');
% set(h,'FaceColor','r','EdgeColor','w')
% xlabel('Distance to vasculature (microns)')
% ylabel('Number of points')
% axis([-5 155 0 6000])
axis([-5 155 0 3500])

osteoDistance = [];
for j = 1:length(cells)
    osteoDistance = [osteoDistance;cells(j).osteoDist];
end
for j = 1:length(kls.cells)
    osteoDistance = [osteoDistance;kls.cells(j).osteoDist];
end
figure(15)
bins = linspace(0,170,100);
hist(osteoDistance,bins);
h = findobj(gca,'Type','patch');
set(h,'FaceColor',[100 100 100]/255,'EdgeColor','w')
axis([-5 155 0 3500])

velocitiesneg = [];
for j = 14:length(cells)
    velocitiesneg = [velocitiesneg;cells(j).velocitySmooth(cells(j).runAvgWin/2:end-cells(j).runAvgWin/2)];
end
velocitiespos = [];
for j = 1:13
    velocitiespos = [velocitiespos;cells(j).velocitySmooth(cells(j).runAvgWin/2:end-cells(j).runAvgWin/2)];
end

%%

% for j = 1:numel(lin.cells);
%     lin.cells(j).fV = sum(lin.cells(j).vascularContact|lin.cells(j).vascularProximal)/...
%         numel(lin.cells(j).frames);
%     lin.cells(j).fE = sum(lin.cells(j).osteoContact|lin.cells(j).osteoProximal)/...
%         numel(lin.cells(j).frames);
% end
% 
% for j = 1:numel(kls.cells);
%     kls.cells(j).fV = sum(kls.cells(j).vascularContact|kls.cells(j).vascularProximal)/...
%         numel(kls.cells(j).times);
%     kls.cells(j).fE = sum(kls.cells(j).osteoContact|kls.cells(j).osteoProximal)/...
%         numel(kls.cells(j).times);
% end
%%
for j = 1:numel(lin.cells);
    lin.cells(j).fV = sum(lin.cells(j).vascularContact)/...
        numel(lin.cells(j).frames);
    lin.cells(j).fE = sum(lin.cells(j).osteoContact)/...
        numel(lin.cells(j).frames);
end

for j = 1:numel(kls.cells);
    kls.cells(j).fV = sum(kls.cells(j).vascularContact)/...
        numel(kls.cells(j).times);
    kls.cells(j).fE = sum(kls.cells(j).osteoContact)/...
        numel(kls.cells(j).times);
end

%%
for j = 1:numel(lin.cells);
    vasCont = lin.cells(j).vascularContact|lin.cells(j).vascularProximal;
    ostCont = lin.cells(j).osteoContact|lin.cells(j).osteoProximal;
    vasVsost = lin.cells(j).vascularDistSmooth<lin.cells(j).osteoDistSmooth;
    lin.cells(j).fV = sum(vasCont(vasVsost))/numel(lin.cells(j).frames);
    lin.cells(j).fE = sum(ostCont(~vasVsost))/numel(lin.cells(j).frames);
end

for j = 1:numel(kls.cells);
    vasCont = kls.cells(j).vascularContact|kls.cells(j).vascularProximal;
    ostCont = kls.cells(j).osteoContact|kls.cells(j).osteoProximal;
    vasVsost = kls.cells(j).vascularDistSmooth<kls.cells(j).osteoDistSmooth;
    kls.cells(j).fV = sum(vasCont(vasVsost))/numel(kls.cells(j).times);
    kls.cells(j).fE = sum(ostCont(~vasVsost))/numel(kls.cells(j).times);
end


%%
figure(16)
hold off
pos = find([lin.cells.lineage]==1);
neg = find([lin.cells.lineage]==-1);
plot([lin.cells(pos).fV],[lin.cells(pos).fE],'d','MarkerSize',10,...
    'MarkerEdgeColor','k','MarkerFaceColor',[100 100 100]/255)
hold on
plot([lin.cells(neg).fV],[lin.cells(neg).fE],'s','MarkerSize',10,...
    'MarkerEdgeColor','k','MarkerFaceColor','k')
plot([kls.cells.fV],[kls.cells.fE],'o','MarkerSize',8,...
    'MarkerEdgeColor','k','MarkerFaceColor','w')

% four corners
% upper left
'upper left'
sum(([lin.cells(pos).fV]==0)&([lin.cells(pos).fE]==1))
sum(([lin.cells(neg).fV]==0)&([lin.cells(neg).fE]==1))
sum(([kls.cells.fV]==0)&([kls.cells.fE]==1))
% upper right
'upper right'
sum(([lin.cells(pos).fV]==1)&([lin.cells(pos).fE]==1))
sum(([lin.cells(neg).fV]==1)&([lin.cells(neg).fE]==1))
sum(([kls.cells.fV]==1)&([kls.cells.fE]==1))
% bottom left
'bot left'
sum(([lin.cells(pos).fV]==0)&([lin.cells(pos).fE]==0))
sum(([lin.cells(neg).fV]==0)&([lin.cells(neg).fE]==0))
sum(([kls.cells.fV]==0)&([kls.cells.fE]==0))
% bottom right
'bot right'
sum(([lin.cells(pos).fV]==1)&([lin.cells(pos).fE]==0))
sum(([lin.cells(neg).fV]==1)&([lin.cells(neg).fE]==0))
sum(([kls.cells.fV]==1)&([kls.cells.fE]==0))
% text(0.01,1.01,'(+:2,-:2,K:2)','VerticalAlignment','Bottom')
% % text(1.01,1.01,'(0,0,0)','VerticalAlignment','Bottom')
% text(0.01,0.01,'(2,6,2)','VerticalAlignment','Bottom')
% text(1.01,0.01,'(9,15,26)','VerticalAlignment','Bottom')
axis([0 1.2 0 1.2])
legend('Lin+','Lin-','KLS')


%%
figure(17)
hold off
pos = find([lin.cells.lineage]==1);
neg = find([lin.cells.lineage]==-1);
% plot([lin.cells(pos).fV],[lin.cells(pos).fE],'d','MarkerSize',10,...
%     'MarkerEdgeColor','k','MarkerFaceColor',[100 100 100]/255)

plot([lin.cells(neg).fV],[lin.cells(neg).fE],'d','MarkerSize',11,...
    'MarkerEdgeColor',[.7 .7 .7],'MarkerFaceColor',[.7 .7 .7])
hold on
plot([kls.cells.fV],[kls.cells.fE],'o','MarkerSize',8,...
    'MarkerEdgeColor','k','MarkerFaceColor','k')
axis([-0.05 1.05 -0.05 1.05])
axis square
legend('Lin-','KLS')