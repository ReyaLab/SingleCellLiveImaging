function FindDrift(inputfolder,outputfolder,filenames,...
    filenames2,driftcorrfile,numFrames)

driftCoordinates = zeros(numFrames,2);
parfor j = 2:numFrames
    im1name = fullfile(inputfolder,filenames{1});
    im2name = fullfile(inputfolder,filenames{j});
    driftCoordinates(j,:) = FindShiftFFT(im1name,im2name);
end

parfor j = 1:numFrames
    shifted = FourierShift2D(double(imread(fullfile(inputfolder,filenames{j}))),...
        -driftCoordinates(j,:));
    imwrite(uint8(shifted),fullfile(outputfolder,filenames{j}))
end


parfor j = 1:numFrames
    shifted = FourierShift2D(double(imread(fullfile(inputfolder,filenames2{j}))),...
        -driftCoordinates(j,:));
    imwrite(uint8(shifted),fullfile(outputfolder,filenames2{j}))
end

save(driftcorrfile,'driftCoordinates')