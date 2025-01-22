function FindReferenceClass(inputfolder,outputfolder,reffilenames,...
    trackmatfile,outfile)

load(trackmatfile)
numParticles = length(int_tracks);
int_tracks_locations = cell(length(int_tracks),1);
loc_all = [];

for k = 1:numParticles
    timepoints = length(int_tracks{k}(:,3));
    locations = zeros(timepoints,1);
    for j = 1:timepoints % timepoints
        t = int_tracks{k}(j,3);
        refim = imread(fullfile(inputfolder,reffilenames{t}));
        x = round(int_tracks{k}(j,1));
        y = round(int_tracks{k}(j,2));
        locations(j) = refim(x,y);
    end
    int_tracks_locations{k} = [int_tracks{k},locations];
    loc_all = [loc_all;locations];
end
int_tr_loc = [int_tr,loc_all];
save(outfile,'int_tracks_locations','int_tr_loc')
    