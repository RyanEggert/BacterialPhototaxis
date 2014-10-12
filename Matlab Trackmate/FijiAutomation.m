% Miji;   % Starts a FIJI inside MATLAB

%% Select Images to Process %%

filterSpec = {'*.cxd;*.tif;*.png;*.jpg',...
 'Image Files (*.cxd,*.tif,*.png,*.jpg)';
  '*.*',  'All Files (*.*)'};
[fileNames,pathName,~] = uigetfile(filterSpec,'Select Image File(s) for Processing', 'MultiSelect', 'on');


for i = 1:length(fileNames)    % For every image file selected...
    imageLocation = strcat(pathName, fileNames(i));
    %% Open Image %%


    %% Local Contrast %%


    %% LUT Changes %%


    %% Other Processing %%


    %% Save LUT Changes %%


end

%% Tracking %%



%% Save Tracking Results %%


%% Exit Miji
% MIJ.exit()