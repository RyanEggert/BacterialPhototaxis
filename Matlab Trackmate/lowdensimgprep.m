function lowdensimgprep(filebase)
Miji(false);   % Starts a FIJI inside MATLAB
filebase = strrep(filebase, '\', '\\');
for i = 1:1000  % 1000 frame series.
    indexstr = int2str(i);
    suffix = '-0000';
    suffix(6-length(indexstr):5) = indexstr;
    imname = [filebase,suffix,'.tif'];
    MIJPath = strcat('path=[',imname,']');
    
    %% Open Image %%
    if mod(i,25) == 0
        fprintf('Processing frame %d of 1000.\n', i);
    end
    MIJ.run('Open...', MIJPath);
    MIJ.run('Collect Garbage');

    %% Local Contrast %%
    MIJ.run('Normalize Local Contrast', 'block_radius_x=40 block_radius_y=40 standard_deviations=3 center stretch stack');
    MIJ.run('Despeckle', 'stack');
    MIJ.run('Collect Garbage');
    %% LUT Changes %%
    MIJ.run('TESTLUT1');
    %% Other Processing %%
    MIJ.run('RGB Color');
    MIJ.run('8-bit');
    %% Get Image Array
    imagearray = MIJ.getCurrentImage;
    %% Save LUT Changes %%
    savepath = strcat(filebase,'_processed.tif');
    if i == 1
        imwrite(uint8(imagearray), savepath);
    else
        imwrite(uint8(imagearray), savepath, 'WriteMode', 'append');
    end
    %% Close Image %%
    MIJ.run('Close All');
    MIJ.run('Collect Garbage');
end

%% Exit Miji
MIJ.exit()
end