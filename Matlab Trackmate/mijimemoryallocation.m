function mijimemoryallocation(varargin)
% MIJIMEMORYALLOCATION  Changes the maximum RAM allocated for MIJI/FIJI
% migimemoryallocation(megabytes)
%
% mijimemoryallocation.m opens an instance of miji, runs a macro to adjust
% the maximum amount of RAM allocated to miji, and closes the instance of
% miji. The new memory allocation will take effect the next time miji is
% started.
% You have the option of specifying how much RAM (in megabytes) you would
% like to allocate to miji/fiji. If no amout is specified [e.g. calling 
% mijimemoryallocation()], the memory will be adjusted to 70%* of the
% computer's total avaliable RAM. 
% * Guidelines for memory allocation: 
% http://www.openmicroscopy.org/site/support/bio-formats5/users/imagej/managing-memory.html

% Check amount of computer RAM
[~, systemMemory] = memory;
totalMemory = floor(systemMemory.PhysicalMemory.Total/2^20);    % Convert & round from bytes to MB

% Warning and Error Messages
ArgumentError = strcat('Argument error. The migi memory allocation function takes', ...
    ' only one (optional) argument.\nPlease check your function input to make sure', ...
    ' you are passing in only one argument.');
NeedMoreRamError = strcat('We''ve detected that your system has ', num2str(totalMemory),...
    'MB of RAM. We think you asked for more than that. Please ask for less. Or buy some more', ...
    ', whichever you prefer. Please check your input to mijimemoryallocation().');
RamWarning = strcat('you''ve allocated more than 75% of your avaliable RAM to MIJI. ', ...
     'This may cause system slowness or instability');
NumberError = strcat('Please be sure to specify a numeric amount of RAM to allocate. Please ',...
    'check your input to mijimemoryallocation()');
         
if nargin == 1  % If memory amount is specified
    memoryallocationMB = varargin{1};
    
elseif nargin == 0  % If memory amount is not specified
    memoryallocationMB = totalMemory * .70;  % Sets 70% of total RAM to be allocated.
else    % Why have you given me all these arguments?
    error('MIJIMEMORYALLOCATION:TooManyArguments', ArgumentError)
end

if isnumeric(memoryallocationMB)    % If the input argument is a number
    if memoryallocationMB > totalMemory     % If you asked for more RAM than your computer has
        error('MIJIMEMORYALLOCATION:NeedMoreRAM', NeedMoreRamError)
    end
    if memoryallocationMB > totalMemory * .75 % Warn if requesting more than 75% of RAM
        warning(RamWarning)
    end
else    % Throw error if input wasn't a number
    error('MIJIMEMORYALLOCATION:ANumberPlease', NumberError)
end

% Vetted input is used to set MIJI/FIJI memory.

mijiMemoryString = strcat('maximum=', num2str(memoryallocationMB),' run')
Miji(false);    % Starts FIJI w/o GUI
MIJ.run('Memory & Threads...', mijiMemoryString);
MIJ.exit();     % Close FIJI
end 