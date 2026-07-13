%% MAIN - Music Genre Classification Using Multiple DSP Features with MFCC Analysis
%   Entry-point pipeline. Loops through the WAV files listed below,
%   extracts DSP + MFCC features via the +features package, classifies
%   each track's genre with CLASSIFY_GENRE, prints a per-file report to
%   the command window, saves diagnostic plots to results/figures, and
%   writes a summary table to results/classification_summary.csv.
%
%   Authors:     Nitish M A (24BEL1023), Lagsshin S (24BEL1059)
%   Institution: VIT Chennai
%   Course:      Signal Processing - Mini Project
%
%   Usage:
%       >> main
%
%   Requirements:
%       - MATLAB Signal Processing Toolbox
%       - MATLAB Audio Toolbox (required for the mfcc function)
%       - WAV files placed in data/raw/  (see README.md)
%
%   See also CLASSIFY_GENRE, UTILS.PREPROCESS_AUDIO, UTILS.COMPUTE_FFT,
%   UTILS.PLOT_RESULTS

clc
clear
close all

%% ---- Project-relative paths (no hardcoded absolute paths) ----
projectRoot = fileparts(mfilename('fullpath'));
dataDir     = fullfile(projectRoot, 'data', 'raw');
resultsDir  = fullfile(projectRoot, 'results', 'figures');
summaryCsv  = fullfile(projectRoot, 'results', 'classification_summary.csv');

if ~isfolder(resultsDir)
    mkdir(resultsDir)
end

%% ---- Input audio files ----
% Place the corresponding .wav files inside data/raw/ before running.
files = {'classical1.wav', 'pop3.wav', 'rock4.wav', 'jazz1.wav', 'electronic4.wav'};

results = table('Size', [0, 6], ...
    'VariableTypes', {'string', 'double', 'double', 'double', 'double', 'string'}, ...
    'VariableNames', {'File', 'SpectralCentroid_Hz', 'ZCR', 'Energy', 'SpectralRolloff_Hz', 'Genre'});

%% ---- Processing pipeline ----
for i = 1:length(files)
    filepath = fullfile(dataDir, files{i});

    try
        [x, fs] = utils.preprocess_audio(filepath);
    catch ME
        warning('main:fileSkipped', 'Skipping "%s": %s', files{i}, ME.message);
        continue
    end

    % ---- Frequency domain (FFT) ----
    [f, magnitude] = utils.compute_fft(x, fs);

    % ---- DSP feature extraction ----
    sc      = features.spectral_centroid(f, magnitude);
    zcr     = features.zero_crossing_rate(x);
    energy  = features.signal_energy(x);
    rolloff = features.spectral_rolloff(f, magnitude);

    % ---- MFCC extraction (analysis only, NOT used in classification) ----
    [mfccCoeffs, mfccMean] = features.extract_mfcc(x, fs);

    % ---- Rule-based genre classification ----
    genre = classify_genre(sc, zcr, energy);

    % ---- Console report (matches original project output format) ----
    fprintf('File: %s\n', files{i});
    fprintf('Spectral Centroid: %.2f Hz\n', sc);
    fprintf('ZCR: %.4f\n', zcr);
    fprintf('Energy: %.4f\n', energy);
    fprintf('Spectral Roll-off: %.2f Hz\n', rolloff);
    fprintf('MFCC Mean Value: %.2f\n', mfccMean);
    fprintf('Detected Genre: %s\n\n', genre);

    results = [results; {files{i}, sc, zcr, energy, rolloff, string(genre)}]; %#ok<AGROW>

    % ---- Visualization (time domain, spectrum, feature bars, MFCC map) ----
    feats = struct('centroid', sc, 'zcr', zcr, 'energy', energy, 'rolloff', rolloff);
    [~, fileLabel] = fileparts(files{i});
    utils.plot_results(x, f, magnitude, feats, mfccCoeffs, fileLabel, resultsDir);
end

%% ---- Summary ----
disp(results)

if height(results) > 0
    writetable(results, summaryCsv);
    fprintf('Summary written to: %s\n', summaryCsv);
else
    warning('main:noResults', ...
        'No audio files were processed. Check that data/raw/ contains the expected .wav files.');
end
