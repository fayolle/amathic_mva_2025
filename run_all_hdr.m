% Script to process all HDR images in a given directory 
% and save the processed result as PNG. 
% 
% Input HDR images should use the .hdr format. 
%
% The location of the input images ('inputFolder') needs to be edited. 

% Input folder (Needs to be edited) 
inputFolder = 'input_hdr';

outputFolder = 'output_hdr';
if ~exist(outputFolder, 'dir')
    mkdir(outputFolder);
    fprintf('Created output folder: %s\n', outputFolder);
end

hdrFiles = dir(fullfile(inputFolder, '*.hdr'));

if isempty(hdrFiles)
    fprintf('No .hdr files found in "%s". Please place your HDR images there.\n', inputFolder);
    return; 
end

fprintf('Starting HDR image processing...\n');

for i = 1:length(hdrFiles)
    currentFilename = hdrFiles(i).name;
    hdrPath = fullfile(inputFolder, currentFilename);
    [~, baseName, ~] = fileparts(currentFilename); 
    pngPath = fullfile(outputFolder, [baseName, '.png']);

    fprintf('Processing ''%s''...\n', currentFilename);

    try
        hdrImage = hdrread(hdrPath);
        hdrImage = im2double(hdrImage);

        processedImage = imSlim(hdrImage, 0.5);

        imwrite(processedImage, pngPath);
        fprintf('Saved ''%s.png'' to ''%s''\n', baseName, outputFolder);

    catch ME
        fprintf('An error occurred while processing ''%s'':\n', currentFilename);
        disp(ME.message); 
    end
end

fprintf('\nProcessing complete.\n');
