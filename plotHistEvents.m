close all
clear all

outputfolder = '.';

load(fullfile(outputfolder,'events.mat'))

eventDurations = [events.duration];
bins = linspace(0,300,25);
%% vascular event lengths
figure(1)
vascularEvents = find(strcmp({events.region},'vascular'));
vascularEventDuration = eventDurations(vascularEvents)/60; % change to minutes
hist(vascularEventDuration,bins)
h = findobj(gca,'Type','patch');
set(h,'FaceColor','r','EdgeColor','w','LineWidth',0.1)
axis([-20 320 0 14])

%% osteo event lengths
figure(2)
osteoEvents = find(strcmp({events.region},'osteo'));
osteoEventDuration = eventDurations(osteoEvents)/60;
hist(osteoEventDuration,bins)
h = findobj(gca,'Type','patch');
set(h,'FaceColor','b','EdgeColor','w','LineWidth',0.1)
axis([-20 320 0 6])

%% lin positive
linPos = [events.lineage]==1;
%% lin negative
linNeg = [events.lineage]==-1;

% pos neg
% colums, types 1 2 3 4 5
linInteractions = zeros(5,2);
eventsType = [events.eventType];
for j = 1:5
    linInteractions(j,1) = sum(eventsType(linPos)==j);
end
for j = 1:5
    linInteractions(j,2) = sum(eventsType(linNeg)==j);
end

% short long
% colums, types 1 2 3 4 5
lsInteractions = zeros(4,2);
eventsType = [events.eventType];
% positive vascular, long
lsInteractions(1,1) = sum(strcmp({events(linPos).region},...
    'vascular')&([events(linPos).duration]>(60*60)));
% positive vascular, short
lsInteractions(2,1) = sum(strcmp({events(linPos).region},...
    'vascular')&([events(linPos).duration]<=(60*60)));
% positive endosteal, long
lsInteractions(3,1) = sum(strcmp({events(linPos).region},...
    'osteo')&([events(linPos).duration]>(60*60)));
% positive endosteal, short
lsInteractions(4,1) = sum(strcmp({events(linPos).region},...
    'osteo')&([events(linPos).duration]<=(60*60)));
% neg vascular, long
lsInteractions(1,2) = sum(strcmp({events(linNeg).region},...
    'vascular')&([events(linNeg).duration]>(60*60)));
% neg vascular, short
lsInteractions(2,2) = sum(strcmp({events(linNeg).region},...
    'vascular')&([events(linNeg).duration]<=(60*60)));
% neg endosteal, long
lsInteractions(3,2) = sum(strcmp({events(linNeg).region},...
    'osteo')&([events(linNeg).duration]>(60*60)));
% neg endosteal, short
lsInteractions(4,2) = sum(strcmp({events(linNeg).region},...
    'osteo')&([events(linNeg).duration]<=(60*60)));


maxVels = [events.maxVelocity];
maxVelLinPos = maxVels(linPos);
maxVelLinNeg = maxVels(linNeg);
figure(3)
bins = linspace(0,.25,10);
n_neg = hist(maxVelLinNeg,bins);
n_pos = hist(maxVelLinPos,bins);
bar(bins*3600,[n_neg;n_pos]','hist') % microns per hour
legend('Lin-','Lin+')
axis([0 .25*3600 0 25])


avgVels = [events.avgVelocity];
avgVelLinPos = avgVels(linPos);
avgVelLinNeg = avgVels(linNeg);
figure(4)
bins = linspace(0,.05,10);
n_neg = hist(avgVelLinNeg,bins);
n_pos = hist(avgVelLinPos,bins);
bar(bins*3600,[n_neg;n_pos]','hist') % microns per hour
legend('Lin-','Lin+')
axis([0 .05*3600 0 25])
xlabel('Average Velocity (\mum/hr)')
ylabel('Number of Cells')

eventDurations = [events.duration];
bins = linspace(0,350,150);
figure(5)
hist(eventDurations/60,bins)
h = findobj(gca,'Type','patch');
set(h,'FaceColor','k','EdgeColor','w','LineWidth',0.01)
xlabel('Length of Interaction (minutes)')
ylabel('Number of Interactions')
axis([-20 320 0 6])
