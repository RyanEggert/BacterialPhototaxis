function consolecountdown
    t = 10;
    timer = ['Matlab will close in ' num2str(t) ' seconds...'];
    fprintf(timer);
    n=numel(timer);
    pause(1)
    for t = fliplr(0:9)
        timer = ['Matlab will close in  ' num2str(t) ' seconds...'];
        fprintf(repmat('\b',1,n));  % Backspaces n times
        fprintf(timer);   % Prints new message
        n=numel(timer);   % Stores length of latest message
        pause(1);   % Wait a second
    end
    fprintf(repmat('\b',1,n));
    disp('Closing Matlab...')
end
