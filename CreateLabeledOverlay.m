function CreateLabeledOverlay(imagefolder,outputfolder,filenames,...
    trackmatfile,numFrames,imlimits,imsize,osteofile,vascularfile,...
    output_name)

load(trackmatfile)
filenameNOEXT = cell(1,100);
for j = 1:numFrames
    [PATHSTR,NAME,EXT] = fileparts(filenames{j});
    filenameNOEXT{j} = NAME;
end
movie_name = fullfile(outputfolder,[output_name '.avi']);
vidObj=VideoWriter(movie_name);
vidObj.FrameRate=30;
vidObj.Quality=50;
open(vidObj);

osteooutline = imdilate(bwperim(imread(osteofile)),strel('disk',1));
vascularoutline = imdilate(bwperim(imread(vascularfile)),strel('disk',1));

% osteooutline = bwperim(imread(osteofile));
% vascularoutline = bwperim(imread(vascularfile));

for j = 1:numFrames
    hf = figure('visible','off','Position',[1, 1, imsize(2)/2, imsize(1)/2]);
%     hf = figure('visible','off','Position',[1, 1, imsize(2), imsize(1)]);   
    im = imread(fullfile(imagefolder,filenames{j}));
    ha = axes;
    set(ha, 'Position',[0 0 1 1]);
%     imshow(im,imlimits)
    green = imadjust(im,imlimits/255);
    im = zeros([imsize(1) imsize(2) 3],'uint8');
%     im(:,:,2) = green;
%     im(:,:,3) = 255*osteooutline;
%     im(:,:,1) = 255*vascularoutline;

    green(osteooutline) = 100;
    red = zeros(imsize,'uint8');
    red(osteooutline) = 100;
    red(vascularoutline) = 255;
    blue = zeros(imsize,'uint8');
    blue(osteooutline) = 100;
    im(:,:,1) = red;
    im(:,:,2) = green;
    im(:,:,3) = blue;
    imshow(im)
    hold on
    frame_pos = int_tr(:,3)==j;
    frame_id = find(frame_pos);
    for k = 1:sum(frame_pos)
        xcoord = int_tr(frame_id(k),1);
        ycoord = int_tr(frame_id(k),2);
        text(xcoord,ycoord,num2str(int_tr(frame_id(k),4)),'Color','w',...
            'VerticalAlignment','Cap','FontSize',12)
%                     'BackgroundColor','w', 'Color',cmap(tr(frame_id(k),4),:,:))
    end
    cdata = zbuffer_cdata(hf);
%     imwrite(cdata,fullfile(outputfolder,[filenameNOEXT{j},'.tif']),'tif')
    writeVideo(vidObj, cdata);
    close(hf)
end
close(vidObj);
