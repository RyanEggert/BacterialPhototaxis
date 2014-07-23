[tracks, md] = importTrackMateTracks('F:\July18201421_Tracks.xml', 'ClipZ');


% Instantiate the MSD analyzer

ma = msdanalyzer(2, md.spaceUnits, md.timeUnits); % 2-dimensions

ma = ma.addAll(tracks);

disp(ma)