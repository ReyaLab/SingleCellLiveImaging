%% get areas

close all
clear all
% folder
outputfolder = 'C:\Users\tklee.WIN\research\reya_image_analysis_2010\annotations\cleaned annotations';

experimentName = {...
    '090207 Normal Lin-',...
    '100910 F480 1 Lin-',...
    '100927 F480 2 Lin- 645 TPs',...
    '101007 VeCad Lin+',...
    '100927 Osteosense Lin- 650TPs',...
    '100917 Osteosense Lin-',...
    '100910 VE Cad Lin-',...
    '100927 VE Cad Lin-',...
    '081125 Lin- Orig Long',...
    '100917 VE Cad Lin-'...
    };

scaling = [.775,.7215,1.443,.7215,1.443,1.443,.7215,1.443,.775,1.443];
scaling = scaling./1000; % into mm from microns

numE = length(experimentName);
Vareas = zeros(numE,1);
Vperims = zeros(numE,1);
Oareas = zeros(numE,1);
Operims = zeros(numE,1);


for j = 1:length(experimentName)
    vessels = imread(fullfile(outputfolder,[experimentName{j},' Vessels.tif']))>0;
    osteo = imread(fullfile(outputfolder,[experimentName{j},' Osteo.tif']))>0;
    Vareas(j) = sum(vessels(:))*scaling(j)^2;
    Oareas(j) = sum(osteo(:))*scaling(j)^2;
    
    vesselperim = imclearborder(bwperim(vessels));
    osteoperim = imclearborder(bwperim(osteo));
    
    Vperims(j) = sum(vesselperim(:))*scaling(j);
    Operims(j) = sum(osteoperim(:))*scaling(j);
    
end
    
excelfile = 'perimAreas.xls';
xlswrite(excelfile,{'experiment','osteo area (mm2)','vascular area (mm2)',...
    'osteo perim (mm)','vascular perim (mm)','o/v area ratio','o/v perim ratio'},...
    'perim area','A1')
xlswrite(excelfile,experimentName','perim area','A2')
xlswrite(excelfile,Oareas,'perim area','B2')
xlswrite(excelfile,Vareas,'perim area','C2')
xlswrite(excelfile,Operims,'perim area','D2')
xlswrite(excelfile,Vperims,'perim area','E2')
xlswrite(excelfile,Oareas./Vareas,'perim area','F2')
xlswrite(excelfile,Operims./Vperims,'perim area','G2')


