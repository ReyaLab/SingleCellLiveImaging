function trackCells(fileinfo,param)

%% unpack input
inputfolder = fileinfo.inputfolder;
filebase = fileinfo.filebase;
outputfolder = fileinfo.outputfolder;
refbase = fileinfo.refbase;
numFrames = fileinfo.numFrames;
outputbase = fileinfo.outputbase;
osteofile = fileinfo.osteofile;
vascularfile = fileinfo.vascularfile;
pixelsize = fileinfo.pixelsize;
timestep = fileinfo.timestep;

filtersize = param.filtersize;
threshlevel = param.threshlevel;
min_size = param.min_size;
refthreshlevel = param.refthreshlevel;
smoothsize = param.smoothsize;
imlimits = param.imlimits;

%% load filenames
filelisting = dir(fullfile(inputfolder,filebase));
filenames = {filelisting.name};

imsize = GetImageSize(fullfile(inputfolder,filenames{1}));

%% create output directories
filterfolder = fullfile(outputfolder,'filtered_images');
CheckExistMkDir(filterfolder)
thresholdfolder = fullfile(outputfolder,'thresholded_images');
CheckExistMkDir(thresholdfolder)
overlayfolder = fullfile(outputfolder,'overlay_images');
CheckExistMkDir(overlayfolder)
positionmatfile = fullfile(outputfolder,'particle_positions.mat');
trackmatfile = fullfile(outputfolder,'track_positions.mat');

% smoothreffolder = fullfile(outputfolder,'reference_images');
% CheckExistMkDir(smoothreffolder)
driftcorrfolder = fullfile(outputfolder,'drift_corrected');
driftcorrfile = fullfile(outputfolder,'drift_coordinates.mat');
CheckExistMkDir(driftcorrfolder)

tracklocationsmatfile = fullfile(outputfolder,'track_positions_locations');


excelfilename = fullfile(outputfolder,[outputbase,'.xls']);
trackimagefilename = fullfile(outputfolder,[outputbase,'.png']);

reffilelisting = dir(fullfile(inputfolder,refbase));
reffilenames = {reffilelisting.name};

%% drift correction
% FindDrift(inputfolder,driftcorrfolder,reffilenames,filenames,driftcorrfile,numFrames);

%% median filter images
% MedianFilter(driftcorrfolder,filterfolder,filenames,filtersize,numFrames)

%% threshold images
% ThresholdImages(filterfolder,thresholdfolder,filenames,threshlevel,numFrames)

%% find particle positions
% FindParticlePositions(thresholdfolder,positionmatfile,filenames,min_size,...
%     numFrames,driftcorrfile)

%% track particles
% TrackParticlePositions(positionmatfile,trackmatfile,param,pixelsize,timestep)

%% create overlayed figures
CreateLabeledOverlay(driftcorrfolder,overlayfolder,filenames,trackmatfile,...
    numFrames,imlimits,imsize,osteofile,vascularfile,outputbase)

% %% try to segment reference channel
% ThresholdSmoothRefImage(inputfolder,smoothreffolder,reffilenames,...
%     refthreshlevel,smoothsize,numFrames);
% 
% %% add particle locations to track
% FindReferenceClass(smoothreffolder,outputfolder,reffilenames,...
%     trackmatfile,tracklocationsmatfile)

%% get distance to closest osteo and vascular
GetDistOsteoVascular(osteofile,vascularfile,trackmatfile,tracklocationsmatfile,pixelsize)

%% assemble into an excel file
% load(tracklocationsmatfile)
% xlswrite(excelfilename,{'x','y','time','cell','vel (um/sec)','d_osteo','d_vascular'},'trackCellsLong','A1')
% xlswrite(excelfilename,int_tr_osteovascular,'trackCellsLong','A2')
% 
% % create a massive cell array
% numCells = length(int_tracks_osteovascular);
% data_array = NaN*ones(numFrames,numCells*6);
% avg_std_array = NaN*ones(2,numCells*6);
% labels_array = cell(1,numCells*6);
% cellNumber = cell(numCells,1);
% for j = 1:numCells
%     start0 = (j-1)*6;
%     labels_array{start0+1} = ['cell ',num2str(j),' x'];
%     labels_array{start0+2} = ['cell ',num2str(j),' y'];
%     labels_array{start0+3} = ['cell ',num2str(j),' disp'];
%     labels_array{start0+4} = ['cell ',num2str(j),' v'];
%     labels_array{start0+5} = ['cell ',num2str(j),' d_osteo'];
%     labels_array{start0+6} = ['cell ',num2str(j),' d_vascular'];
%     
%     data = int_tracks_osteovascular{j}(:,[1 2 4 5 6 7]);
%     data_array(round(int_tracks_osteovascular{j}(:,3)/timestep),start0+1:start0+6)=data;
%     avg_std_array(1,start0+1:start0+6) = mean(data,1);
%     avg_std_array(2,start0+1:start0+6) = std(data,[],1);
%     cellNumber{j} = ['cell ',num2str(j)];
% end
% 
% times = timestep*((1:numFrames)'-1);
% 
% numCols = size(data_array,2);
% numSheets = ceil(numCols/168);
% for j = 1:numSheets
%     start1 = (j-1)*168+1;
%     end1 = min([j*168 numCols]);
%     sheetName = ['trackCells',num2str(j)];
%     xlswrite(excelfilename,data_array(:,start1:end1),sheetName,'B4')
%     xlswrite(excelfilename,labels_array(:,start1:end1),sheetName,'B1')
%     xlswrite(excelfilename,avg_std_array(:,start1:end1),sheetName,'B2')
%     xlswrite(excelfilename,{'time'},sheetName,'A1')
%     xlswrite(excelfilename,{'avg'},sheetName,'A2')
%     xlswrite(excelfilename,{'std'},sheetName,'A3')
%     xlswrite(excelfilename,times,sheetName,'A4')
% end
% 
% avg_array = reshape(avg_std_array(1,:),6,numCells)';
% std_array = reshape(avg_std_array(2,:),6,numCells)';
% avg_std_array_stacked = [avg_array,std_array];
% 
% 
% xlswrite(excelfilename,{'time','x','y','disp','v','d_osteo','d_vascular','dx','dy',...
%     'ddisp','dv','dd_osteo','dd_vascular'},'summary','A1')
% xlswrite(excelfilename,{'avg';'std'},'summary','A2')
% 
% 
% xlswrite(excelfilename,cellNumber,'summary','A4')
% xlswrite(excelfilename,avg_std_array_stacked,'summary','B4')
% xlswrite(excelfilename,mean(avg_std_array_stacked,1),'summary','B2')
% xlswrite(excelfilename,std(avg_std_array_stacked,1),'summary','B3')

%% output a tracked image
hf = figure('visible','off','Position',[1, 1, imsize(2), imsize(1)]);
load(tracklocationsmatfile)
numCells = length(int_tracks_osteovascular);
cmap = jet(numCells);
ha = axes;
set(ha, 'Position',[0 0 1 1]);
set(ha, 'XTick', []);
set(ha, 'YTick', []);
axis([0 imsize(2) 0 imsize(1)])
axis on
for j = 1:numCells
    hold on
    x=int_tracks_osteovascular{j}(:,1);
    y=imsize(1)-int_tracks_osteovascular{j}(:,2);
    plot(x,y,'Color',cmap(j,:,:))
    text(x(1),y(1),num2str(j))
end
cdata = zbuffer_cdata(hf);
imwrite(cdata,trackimagefilename,'png')
close(hf)    


%% clean up
% rmdir(thresholdfolder,'s')
% rmdir(filterfolder,'s')


    