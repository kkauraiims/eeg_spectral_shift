%% Load subject file 

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab; % open eeglab

%load dataset
EEG = pop_loadset('filename','eeglab_data.set','filepath','C:\\Users\\KIRAN\\Desktop\\eeglab_current\\eeglab14_1_2b\\sample_data\\');

[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0); %store dataset in ALLEEG

EEG = eeg_checkset( EEG ); % check the fields of EEG data set 

%% Plot EEG spectra and retrieve corresponding frequencies

% EEG.data = EEG chan x time-points matrix
% EEG.srate = sampling rate of EEG 
% spectra = power spectra (mean power over epochs), in dB
% freqs =frequencies of spectra (Hz)


[spectra,freqs] = spectopo(EEG.data(1:128,:,:), 0, EEG.srate); % no. of data frames = data length 
%% Set the following frequency bands: delta=1-4, theta=4-8, alpha=8-12, beta=13-30, gamma=30-80

deltaIdx = find(freqs>1 & freqs<4);
thetaIdx = find(freqs>4 & freqs<8);
alphaIdx = find(freqs>8 & freqs<13);
betaIdx  = find(freqs>13 & freqs<30);
gammaIdx = find(freqs>30 & freqs<80);

%% Compute absolute power
 deltaPower = mean(10.^(spectra(deltaIdx)/10));
 thetaPower = mean(10.^(spectra(thetaIdx)/10));
 alphaPower = mean(10.^(spectra(alphaIdx)/10));
 betaPower  = mean(10.^(spectra(betaIdx)/10));
 gammaPower = mean(10.^(spectra(gammaIdx)/10));


%% %% Compute power in dB

deltaPower = mean(spectra(deltaIdx));
thetaPower = mean(spectra(thetaIdx));
alphaPower = mean(spectra(alphaIdx));
betaPower  = mean(spectra(betaIdx));
gammaPower = mean(spectra(gammaIdx));

%% Export results in excel sheet

% create an array of power in bands
power_in_bands = [deltaPower thetaPower alphaPower betaPower gammaPower];

% convert this array to a table 
power_table = array2table (power_in_bands, 'VariableNames', {'delta', 'theta', 'alpha', 'beta', 'gamma'}); 

% export table to excel 
writetable(power_table, 'power_in_bands.xlsx','WriteVariableNames', true);
