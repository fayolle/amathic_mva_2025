% Script to process all LLIE images in a given directory 
% and save the processed result as PNG. 
% 
% Input low light images should use the .png format. 
%
% The location of the input images ('inputFolder') needs to be edited. 

% Input folder (Needs to be edited)
inputFolder = 'input_llie';

outputFolder = 'output_llie';
if ~exist(outputFolder, 'dir')
    mkdir(outputFolder);
    fprintf('Created output folder: %s\n', outputFolder);
end

llieFiles = dir(fullfile(inputFolder, '*.png'));

if isempty(llieFiles)
    fprintf('No .png llie files found in "%s". Please place your llie images there.\n', inputFolder);
    return; 
end

fprintf('Starting LLIE image processing...\n');

for i = 1:length(llieFiles)
    currentFilename = llieFiles(i).name;
    lliePath = fullfile(inputFolder, currentFilename);
    [~, baseName, ~] = fileparts(currentFilename); 
    pngPath = fullfile(outputFolder, [baseName, '.png']);

    fprintf('Processing ''%s''...\n', currentFilename);

    try
        llieImage = imread(lliePath);
        llieImage = im2double(llieImage);

        processedImage = imSlim(llieImage, 0.0);

        imwrite(processedImage, pngPath);
        fprintf('Saved ''%s.png'' to ''%s''\n', baseName, outputFolder);

    catch ME
        fprintf('An error occurred while processing ''%s'':\n', currentFilename);
        disp(ME.message); 
    end
end

fprintf('\nProcessing complete.\n');
