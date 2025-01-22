% make plots

outputdir = 'C:\Users\tklee.WIN\research\reya_image_analysis_2010\output';

listing = dir(outputdir);

choosedirs = [listing.isdir];
dirnames = {listing.name};
dirnames = dirnames(choosedirs);
validfolders = ~ismember(dirnames,{'.','..'});
dirnames = dirnames(validfolders);
close all


for j = 1:length(dirnames)
    load(fullfile(outputdir,dirnames{j},'track_positions_locations'))
    numCells = length(int_tracks_osteovascular);
    columns = 4;
    rows = ceil(numCells/4);
    h = figure('Color','w');
    
    for k = 1:numCells
        subplot(ceil(numCells/4.0),min([4,numCells]),k)
        plot(int_tracks_osteovascular{k}(:,3),...
            int_tracks_osteovascular{k}(:,4),'g')
        hold on
        plot(int_tracks_osteovascular{k}(:,3),...
            int_tracks_osteovascular{k}(:,5),'k')
        plot(int_tracks_osteovascular{k}(:,3),...
            int_tracks_osteovascular{k}(:,6),'b')
        plot(int_tracks_osteovascular{k}(:,3),...
            int_tracks_osteovascular{k}(:,7),'r')
        title(['Cell ',num2str(k)])
    end
    suptitle(dirnames{j})
    saveas(h,fullfile(outputdir,[dirnames{j},'.png']),'png')
    close(h)
end
