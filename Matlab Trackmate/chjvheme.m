function chjvheme(memoryallocationMB)
% chjvheme  Changes Matlab's java heap memory which can be used for MIJI/
% FIJI. This can be done to a limited extent in Matlab's preferences menu.
%
% migimemoryallocation(megabytes)
%
% This function requires specification of the amount of RAM (in megabytes)
% to be allocated. 
% This will do some basic checking of the input number and throw warnings
% if it thinks you  may be doing something silly (allocating more memory than you
% have, for example)
% * Guidelines for memory allocation: 
% http://www.openmicroscopy.org/site/support/bio-formats5/users/imagej/managing-memory.html

% Check amount of computer RAM
[~, systemMemory] = memory;
totalMemory = floor(systemMemory.PhysicalMemory.Total/2^20);    % Convert & round from bytes to MB

% Warning and Error Messages

BigRamWarning = strcat('You''ve allocated more than your avaliable RAM (',...
    num2str(totalMemory),'MB). That may not be a brilliant decision.',...
    ' You might consider changing that.');
RamWarning = strcat('You''ve allocated more than 75% of your avaliable RAM (', ...
    num2str(totalMemory),'MB). This may cause system slowness or instability.');
NumberError = strcat('Please be sure to specify a numeric amount of RAM to allocate. Please ',...
    'check newMemory.');
         
% Basic input checking

if isnumeric(memoryallocationMB)    % If the input argument is a number
    if memoryallocationMB > totalMemory
        warning(BigRamWarning)
    elseif memoryallocationMB > totalMemory * .75 % Warn if requesting more than 75% of RAM
        warning(RamWarning)
    end
else    % Throw error if input wasn't a number
    error('MIJIMEMORYALLOCATION:ANumberPlease', NumberError)
end

% Vetted input is used to set Matlab Java heap memory.

prefFileName = strcat(prefdir,'\matlab.prf');   % Find this Matlab install's preference file location

origPrefFile = regexp(fileread(prefFileName), '\n', 'split');   % Read preference file and store each line to a cell array

i = 1;  % Set index for while loop
isJavaPref = strfind(origPrefFile{i}, 'JavaMemHeapMax=I');  % Check whether this line contains the code which sets the Java heap
while isempty(isJavaPref)   % Loop until java heap code line is found
    i = i+1;    % Increment i
    isJavaPref = strfind(origPrefFile{i}, 'JavaMemHeapMax=I');  % Check next line for Java heap code
end

origPrefFile{i} = regexprep(origPrefFile{i}, '\d*', num2str(memoryallocationMB));    % Replace old memory allocation with new amount
fid = fopen(prefFileName, 'w');     % Open Matlab preferences file in write mode
fprintf(fid, '%s\n', origPrefFile{:});  % Write new preferences file
fclose(fid);    % Close modified preferences file
disp(['Java heap memory has been changed to ' num2str(memoryallocationMB) 'MB.'])
end 