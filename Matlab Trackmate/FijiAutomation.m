Miji;   % Starts a FIJI inside MATLAB

%% Select Images to Process %%

[FileNames,PathNames,FilterIndex] = uigetfile(FilterSpec,'Select Image File(s) for Processing', 'MultiSelect', 'on')

%% Open Image %%


%% Local Contrast %%


%% LUT Changes %%


%% Other Processing %%


%% Save LUT Changes %%



%% Tracking %%



%% Save Tracking Results %%


%% Exit Miji
MIJ.exit()