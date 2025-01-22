% pull events from cells

outputfolder = '/Users/tklee/code/reya_image_analysis/code/';

load(fullfile(outputfolder,'allCellsKLS'))
cellsE = struct([]);
events = struct([]);
counter = 1;

for j = 1:length(cells)
    eventArray = getEvents(cells(j));
    eventBounds = find(abs(diff(eventArray)));
    eventBounds = [0 eventBounds length(eventArray)];
    for k = 1:(length(eventBounds)-1)
        eventType = eventArray(eventBounds(k)+1);
        events(counter).eventType = eventArray(eventBounds(k)+1);
        switch eventType
            case 1
                events(counter).desc = 'other';
                events(counter).region = 'other';
            case 2
                events(counter).desc = 'proximal';
                events(counter).region = 'osteo';
            case 3
                events(counter).desc = 'proximal';
                events(counter).region = 'vascular';
            case 4
                events(counter).desc = 'contact';
                events(counter).region = 'osteo';
            case 5
                events(counter).desc = 'contact';
                events(counter).region = 'vascular'; 
        end
        events(counter).expt = cells(j).expt;
        events(counter).ID = cells(j).ID;
%         events(counter).lineage = cells(j).lineage;
%         events(counter).frames = cells(j).frames(eventBounds(k)+1:eventBounds(k+1));
        events(counter).times = cells(j).times(eventBounds(k)+1:eventBounds(k+1));
        events(counter).duration = events(counter).times(end)-events(counter).times(1);
        events(counter).vascularDistSmooth = cells(j).vascularDistSmooth(eventBounds(k)+1:eventBounds(k+1));
        events(counter).osteoDistSmooth = cells(j).osteoDistSmooth(eventBounds(k)+1:eventBounds(k+1));
        events(counter).velocitySmooth = cells(j).velocitySmooth(eventBounds(k)+1:eventBounds(k+1));
        events(counter).maxVelocity = max(events(counter).velocitySmooth);
        events(counter).avgVelocity = mean(events(counter).velocitySmooth);
        counter = counter + 1;
    end
end

if ~exist(outputfolder)
    mkdir(outputfolder)
end

save(fullfile(outputfolder,'eventsKLS'),'events')
        