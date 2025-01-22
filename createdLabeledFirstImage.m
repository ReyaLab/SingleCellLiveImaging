% create labeled images
clear all
inputfolder = 'C:\Users\tklee.WIN\research\reya_image_analysis_2010\output\';
outputfolder = 'C:\Users\tklee.WIN\research\reya_image_analysis_2010\output\finaltracks';
datafolder = 'C:\Users\tklee.WIN\research\reya_image_analysis_2010';
load('allCells.mat')


experiments = {...
    'Lin Pos 101007',...
    'Exports Lin neg GFP 2',...
    'Osteosense 650 TPs 100927',...
    'F480 1 100910',...
    'f480 2 645 tps 100927',...
    'Osteosense Exports',...
    'VE Cadherin Exports',...
    'Orig Long Full',...
    'VEcad 100917'...
    };

displayLimits = [...
    0 60;
    0 25;
    20 100;
    0 50;
    0 40;
    0 100;
    0 50;
    0 50;
    0 50];

% loop over experiments
for j = 1:length(experiments)
    % find all the cells for a given experiment
    c = strcmp({cells.expt},experiments{j});
    % find the first image
    filelisting = dir(fullfile(datafolder,experiments{j},'*ch00*'));
    filenames = {filelisting.name};
    filelisting = dir(fullfile(datafolder,experiments{j},'*ch01*'));
    red = {filelisting.name};
    a = imread(fullfile(datafolder,experiments{j},filenames{1}));
    imsize = size(a);
    hf = figure('visible','off','Position',[1, 1, imsize(2), imsize(1)]);
    ha = axes;
    blah = zeros([imsize 3],'uint8');
    blah(:,:,2) = imadjust(a,displayLimits(j,:)/255,[0 1]);
    blah(:,:,1) = imread(fullfile(datafolder,experiments{j},red{1}));
    imshow(blah,[0 10])
    
    set(ha, 'Position',[0 0 1 1]);
    for k = find(c)
        text(cells(k).x(1),cells(k).y(1),num2str(cells(k).ID),'Color','w',...
            'VerticalAlignment','Cap')
    end
    cdata = zbuffer_cdata(hf);
    imwrite(cdata,fullfile(outputfolder,[experiments{j},'.png']),'PNG')
    close(hf)
    
end



% use later
% filelisting = dir(fullfile(inputfolder,filebase));
% filenames = {filelisting.name};