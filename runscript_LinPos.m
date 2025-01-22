% run LinPos
clear all
close all

%% specify these parameters
% folder names
inputfolder = 'C:\Users\tklee.WIN\research\reya_image_analysis_2010\Lin Pos 101007';
outputfolder = 'C:\Users\tklee.WIN\research\reya_image_analysis_2010\output\Lin Pos 101007';

% inputfolder = 'C:\Users\tklee\Documents\research\reya_image_analysis\Exports Lin neg GFP 2\';
% outputfolder = 'C:\Users\tklee\Documents\research\reya_image_analysis\ouputLinNegGFP';

% pattern for particle images
filebase = '*ch00.tif';

% pattern for reference background image
refbase = '*ch01.tif';

% osteo labeled
osteofile = 'C:\Users\tklee.WIN\research\reya_image_analysis_2010\annotations\cleaned annotations\101007 VeCad Lin+ Osteo.tif';

% vascular labeled
vascularfile = 'C:\Users\tklee.WIN\research\reya_image_analysis_2010\annotations\cleaned annotations\101007 VeCad Lin+ Vessels.tif';

% outputfilename
outputbase = 'LinPos';

% number of images to analyze
numFrames = 740;

% image parameters
pixelsize = .7215;
timestep = 10.24;

% tracking parameters
memory = 100;
min_good_length = 10;
suppress_msgs = 1;
dimension = 2;
max_dist_travel = 20;

% segmentation parameters
filtersize = 5;
threshlevel = 15;
min_size = 5;

refthreshlevel = 20;
smoothsize = 2;

% image display parameters
imlimits = [0 60];

 
%% load into parameters struct (no need to edit)
fileinfo.inputfolder = inputfolder;
fileinfo.filebase = filebase;
fileinfo.outputfolder = outputfolder;
fileinfo.refbase = refbase;
fileinfo.numFrames = numFrames;
fileinfo.outputbase = outputbase;
fileinfo.osteofile = osteofile;
fileinfo.vascularfile = vascularfile;
fileinfo.pixelsize = pixelsize;
fileinfo.timestep = timestep;

param.mem = memory;
param.good = min_good_length;
param.quiet = suppress_msgs;
param.dim = dimension;
param.dist = max_dist_travel;

param.filtersize = filtersize;
param.threshlevel = threshlevel;
param.min_size = min_size;
param.refthreshlevel = refthreshlevel;
param.smoothsize = smoothsize;
param.imlimits = imlimits;

% %% parallel computing
% matlabpool(4)

%% run the code
trackCells(fileinfo,param)

% %% parallel cmoputing
% matlabpool close

