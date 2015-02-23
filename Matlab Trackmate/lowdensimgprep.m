function lowdensimgprep(filebase)
% Function for integrating the preparation of low density bacterial video
% data for tracking into the existing data processing workflow.  This takes
% in a "filebase". Images to be processed are stored as individual (i.e.
% single-layer) .tiff files at "filebase-n", where n is a four digit number
% ranging from 0001 to 1000 [We assume we process our normal 1000 frame
% series].

Miji(false);   % Starts a FIJI inside MATLAB
filebase = strrep(filebase, '\', '\\'); % Format filepath
for i = 1:1000  % 1000 frame series.
    %% Construct Image Name %%
    indexstr = int2str(i);
    suffix = '-0000';
    suffix(6-length(indexstr):5) = indexstr;
    imname = [filebase,suffix,'.tif'];
    MIJPath = strcat('path=[',imname,']');
    
    %% Open Image %%
    if mod(i,25) == 0 % Provide a progress indicator in the console.
        fprintf('Processing frame %d of 1000.\n', i);
    end
    MIJ.run('Open...', MIJPath);
    MIJ.run('Collect Garbage'); % Reduce unnecessary RAM usage

    %% Local Contrast %%
    % Normalize local contrast and despeckle filters
    MIJ.run('Normalize Local Contrast', 'block_radius_x=40 block_radius_y=40 standard_deviations=3 center stretch stack');
    MIJ.run('Despeckle', 'stack');
    MIJ.run('Collect Garbage'); 
    %% LUT Changes %%
    % Apply a LUT (identified by name). Note that this LUT file must be
    % placed in the /LUTS directory of the FIJI installation.
    MIJ.run('TESTLUT1'); % Apply the given LUT.
    %% Other Processing %%
    % Convert the image to a RGB color image to save LUT color adjustments.
    % Convert back to an 8-bit image for further processing and use.
    MIJ.run('RGB Color'); 
    MIJ.run('8-bit');
    %% Get Image Array
    % Sends the image array (with all filters, LUTs, etc. applied) to
    % MATLAB.
    imagearray = MIJ.getCurrentImage;
    %% Save LUT Changes %%
    % Save the image(s) as a multi-layer TIFF called/located at
    % "filebase_processed.tiff".
    savepath = strcat(filebase,'_processed.tif');
    if i == 1
        imwrite(uint8(imagearray), savepath);
    else
        imwrite(uint8(imagearray), savepath, 'WriteMode', 'append');
    end
    %% Close Image %%
    % Close image in FIJI and clear memory in preparation for next image.
    MIJ.run('Close All');
    MIJ.run('Collect Garbage');
end

%% Exit Miji
% Be sure to cleanly exit Miji to prevent errors and/or many copies of FIJI
% running at once.
MIJ.exit()
end