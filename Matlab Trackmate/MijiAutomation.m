Miji(false);   % Starts a FIJI inside MATLAB

%% Select Images to Process %%
%Iterate through images%


filterSpec = {'*.tif', 'TIFF files'; '*.cxd;*.tif;*.png;*.jpg',...
 'Image Files (*.cxd,*.tif,*.png,*.jpg)';
  '*.*',  'All Files (*.*)'};
[fileName,pathName,selected] = uigetfile(filterSpec,'Select first image file of sequence for Processing', 'MultiSelect', 'off');
 if ~selected
        disp('No files were selected for processing')
        MIJ.exit()
        return
 end
pathName = strrep(pathName, '\', '\\');
frameno = fileName(end-4:end-4);
assert(frameno == '1', 'It looks like the first image was not selected. You selected %s', fileName);
dataset = fileName(1:end-6);
savepathName = strcat(pathName(1:end-2), '_processed\\');
mkdir(savepathName); 
thisframe = 0;
for i = 1:1000  % 1000 frame series.
    thisframe = thisframe+1;
    thisimage = strrep(fileName, '-1.', strcat('-',num2str(thisframe),'.'));
    thisfullpath = strcat(pathName, thisimage);
    MIJPath = strcat('path=[',thisfullpath,']');
    
    %% Open Image %%
    if mod(thisframe,10) == 0
        fprintf('Processing frame %d of 1000 from %s dataset.\n', thisframe, dataset);
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
    savepath = strcat(savepathName,strrep(thisimage, strcat('-',num2str(thisframe),'.'),strcat('-',num2str(thisframe),'_processed.')));
    imwrite(uint8(imagearray), savepath);
    %% Close Image %%
    MIJ.run('Close All');
    MIJ.run('Collect Garbage');
end 

%% Exit Miji
MIJ.exit()