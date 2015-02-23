%% Import TrackMate Data + MSD analysis %%

clf

% Import tracks and metadata from TrackMate XML file
[tracks, md] = importTrackMateTracks('F:\MijiScripts\TestSeries\TestSeries_processed.xml', 'ClipZ');

% Instantiate the MSD analyzer
msda = msdanalyzer(2, md.spaceUnits, md.timeUnits); % 2-dimensions

msda = msda.addAll(tracks);

disp(msda)

msda.plotTracks()
msda.labelPlotTracks() % This automatically labels the graph axes

msda = msda.computeMSD();

msda.msd()

% For more, see http://tinevez.github.io/msdanalyzer/