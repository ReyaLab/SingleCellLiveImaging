function GetDistOsteoVascular(osteofile,vascularfile,trackmatfile,outfile,pixelsize)

load(trackmatfile)
numParticles = length(int_tracks);
int_tracks_osteovascular = cell(length(int_tracks),1);

osteo_all = [];
vascular_all = [];

osteoim = imread(osteofile);
vascularim = imread(vascularfile);
osteoInd = find(osteoim);
vascularInd = find(vascularim);

for k = 1:numParticles
    timepoints = length(int_tracks{k}(:,3));
    osteoDist = zeros(timepoints,1);
    vascularDist = zeros(timepoints,1);
    for j = 1:timepoints

        blank = false(size(osteoim));
        x = round(int_tracks{k}(j,1));
        y = round(int_tracks{k}(j,2));
        blank(y,x) = 1;
        D = bwdist(blank);
        osteoDist(j) = pixelsize*min(D(osteoInd));
        vascularDist(j) = pixelsize*min(D(vascularInd));
    end
    int_tracks_osteovascular{k} = [int_tracks{k},osteoDist,vascularDist];
    osteo_all = [osteo_all;osteoDist];
    vascular_all = [vascular_all;vascularDist];
end
int_tr_osteovascular = [int_tr,osteo_all,vascular_all];
save(outfile,'int_tracks_osteovascular','int_tr_osteovascular')