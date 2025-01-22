function ThresholdImages(inputfolder,outputfolder,filenames,threshlevel,numFrames)

parfor j=1:numFrames
    filtered = imread(fullfile(inputfolder,filenames{j}));
    bwimage = filtered>threshlevel;
    closedimage = imclose(bwimage,strel('disk',1));
    imwrite(closedimage,fullfile(outputfolder,filenames{j}),'tif');
end