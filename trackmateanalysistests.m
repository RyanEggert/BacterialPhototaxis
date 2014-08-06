clf


[tracks, md] = importTrackMateTracks('F:\July18201421_Tracks.xml', 'ClipZ');

% Instantiate the MSD analyzer

msda = msdanalyzer(2, md.spaceUnits, md.timeUnits); % 2-dimensions

msda = msda.addAll(tracks);

disp(msda)

msda.plotTracks()
msda.labelPlotTracks() % This automatically labels the graph axes

msda = msda.computeMSD();

msda.msd()