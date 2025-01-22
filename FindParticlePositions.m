function FindParticlePositions(inputfolder,outputfile,filenames,min_size,...
    numFrames,driftcorrfile)

load(driftcorrfile)

positions = [];
for j=1:numFrames
    bwimage = imread(fullfile(inputfolder,filenames{j}));
    labeled = bwlabel(bwimage);
    cleared = bwareaopen(labeled,min_size);
    props = regionprops(cleared,'Centroid');
    frame_pos = reshape([props.Centroid],2,length(props))';
    positions = [positions;[frame_pos,j*ones(length(props),1)]];
end

save(outputfile,'positions')