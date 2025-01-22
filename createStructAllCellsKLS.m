% assemble the cells into one structure array and plot

% outputfolder = 'C:\Users\tklee.WIN\research\reya_image_analysis_2010\output';
% list of files
% experiments = {...
%     'Lin Pos 101007',...
%     'Exports Lin neg GFP 2',...
%     'Osteosense 650 TPs 100927',...
%     'F480 1 100910',...
%     'F480 2',...
%     'Osteosense Exports',...
%     'VE Cadherin Exports',...
%     'Orig Long Full',...
%     'VEcad 100917'...
%     };

% matfiles = {'/Users/tklee/Desktop/KLS Area 1 + images/output_test/track_positions_locations.mat',...
%     '/Users/tklee/Desktop/KLS Area 2 + images/output_test/track_positions_locations.mat'};
matfiles = {
    '/Users/tklee/image_data_temp/reya lab/KLS Area 1/output/track_positions_locations.mat',...
    '/Users/tklee/image_data_temp/reya lab/KLS Area 3/output/track_positions_locations.mat',...
    '/Users/tklee/image_data_temp/reya lab/KLS Area 7/output/track_positions_locations.mat',...
    '/Users/tklee/image_data_temp/reya lab/KLS Area 8.3/output/track_positions_locations.mat'};
exptnames = {'KLS1','KLS3','KLS7','KLS8p3'};
% cellIDs = {[1 2 3 4 5 6 7 10 11 12 13 14],[2 5 6 7 8 9]};
cells = struct([]);
counter = 1;

for j = 1:length(matfiles)
    load(matfiles{j})
    numCells = length(int_tracks_osteovascular);
    for k = 1:numCells
        cells(counter).expt = exptnames{j};
        cells(counter).ID = k;
%         cells(counter).frames = int_tracks_osteovascular{k}(:,1);
        cells(counter).times = int_tracks_osteovascular{k}(:,3);
        cells(counter).x = int_tracks_osteovascular{k}(:,1);
        cells(counter).y = int_tracks_osteovascular{k}(:,2);
        cells(counter).disp = int_tracks_osteovascular{k}(:,4);
        cells(counter).velocity = int_tracks_osteovascular{k}(:,5);
        cells(counter).osteoDist = int_tracks_osteovascular{k}(:,6);
        cells(counter).vascularDist = int_tracks_osteovascular{k}(:,7);
%         if j == 1;
%             cells(counter).lineage = 1;
%         else
%             cells(counter).lineage = -1;
%         end
            
        
        counter = counter + 1;
    end
end

%%
runAvgWin = 30;
proximalCutoff = 25;
contactCutoff = 5;
mergeLength = 20;
for j = 1:length(cells)
    % additional features to calculate
    cells(j).osteoDistSmooth = smooth(cells(j).osteoDist,runAvgWin);
    cells(j).vascularDistSmooth = smooth(cells(j).vascularDist,runAvgWin);
    cells(j).xSmooth = smooth(cells(j).x,runAvgWin);
    cells(j).ySmooth = smooth(cells(j).y,runAvgWin);
    cells(j).velocitySmooth = [sqrt(diff(cells(j).xSmooth).^2+...
        diff(cells(j).ySmooth).^2)./diff(cells(j).times); 0];

    % proximal/contact cutoffs
    % first try out a few different cutoffs, select one with the least
    % changes
    vascularContacts = false(length(cells(j).vascularDistSmooth),3);
    for k = 1:3
        vascularContacts(:,k) = cells(j).vascularDistSmooth < (contactCutoff+k-2);
        vascularContacts(:,k) = imclose(vascularContacts(:,k),ones(mergeLength,1));
%         vascularContacts(:,k) = imopen(vascularContacts(:,k),ones(mergeLength,1));
    end
    [Y,I] = min(sum(abs(diff(vascularContacts,1)),1));
    cells(j).vascularContactCutoff = contactCutoff+I-2;
    cells(j).vascularContact = vascularContacts(:,I);
    
    vascularProximals = false(length(cells(j).vascularDistSmooth),3);
    for k = 1:3
        vascularProximals(:,k) = cells(j).vascularDistSmooth > ...
            cells(j).vascularContactCutoff & ...
            (cells(j).vascularDistSmooth < (proximalCutoff+k-2));
        vascularProximals(:,k) = imclose(vascularProximals(:,k),ones(mergeLength,1));
%         vascularProximals(:,k) = imopen(vascularProximals(:,k),ones(mergeLength,1));
    end
    [Y,I] = min(sum(abs(diff(vascularProximals,1)),1));
    cells(j).vascularProximalCutoff = proximalCutoff+I-2;
    cells(j).vascularProximal = vascularProximals(:,I);
    
    % don't expect change that often, merge together events that happen
    % within mergeLength
%     cells(j).vascularContact = imclose(cells(j).vascularContact,ones(mergeLength,1));
%     cells(j).vascularProximal = imclose(cells(j).vascularProximal,ones(mergeLength,1));
    
    
    osteoContacts = false(length(cells(j).osteoDistSmooth),3);
    for k = 1:3
        osteoContacts(:,k) = cells(j).osteoDistSmooth < (contactCutoff+k-2);
        osteoContacts(:,k) = imclose(osteoContacts(:,k),ones(mergeLength,1));
    end
    [Y,I] = min(sum(abs(diff(osteoContacts,1)),1));
    cells(j).osteoContactCutoff = contactCutoff+I-2;
    cells(j).osteoContact = osteoContacts(:,I);
    
    osteoProximals = false(length(cells(j).osteoDistSmooth),3);
    for k = 1:3
        osteoProximals(:,k) = cells(j).osteoDistSmooth > ...
            cells(j).osteoContactCutoff & ...
            (cells(j).osteoDistSmooth < (proximalCutoff+k-2));
        osteoProximals(:,k) = imclose(osteoProximals(:,k),ones(mergeLength,1));
    end
    [Y,I] = min(sum(abs(diff(osteoProximals,1)),1));
    cells(j).osteoProximalCutoff = proximalCutoff+I-2;
    cells(j).osteoProximal = osteoProximals(:,I);
    
%     cells(j).osteoContact = imclose(cells(j).osteoContact,ones(mergeLength,1));
%     cells(j).osteoProximal = imclose(cells(j).osteoProximal,ones(mergeLength,1));


    cells(j).runAvgWin = runAvgWin;
    cells(j).proximalCutoff = proximalCutoff;
    cells(j).contactCutoff = contactCutoff;
    cells(j).mergeLength = mergeLength;
    
end
    
save(fullfile('/Users/tklee/code/reya_image_analysis/code/allCellsKLS.mat'),'cells')    

