function fig = plot_results(x, f, magnitude, feats, mfccCoeffs, fileLabel, outputDir)
%PLOT_RESULTS Generate the 4-panel diagnostic plot for one audio file.
%   FIG = UTILS.PLOT_RESULTS(X, F, MAGNITUDE, FEATS, MFCCCOEFFS,
%   FILELABEL) creates a 2x2 figure containing:
%       1. Time domain waveform
%       2. Frequency spectrum (magnitude vs. frequency)
%       3. Bar chart comparing DSP features
%       4. MFCC feature map (coefficient heat map across frames)
%
%   FIG = UTILS.PLOT_RESULTS(..., OUTPUTDIR) additionally saves the
%   figure as a PNG file into OUTPUTDIR (created automatically if it
%   does not already exist).
%
%   Inputs:
%       x          - Nx1 time-domain audio signal
%       f          - frequency axis, in Hz, for the magnitude spectrum
%       magnitude  - magnitude spectrum values
%       feats      - struct with fields: centroid, zcr, energy, rolloff
%       mfccCoeffs - [numFrames x numCoeffs] MFCC coefficient matrix
%       fileLabel  - string used in plot titles and the saved filename
%       outputDir  - (optional) folder to save the figure as a PNG
%
%   Output:
%       fig - handle to the generated figure
%
%   Example:
%       feats = struct('centroid', 850, 'zcr', 0.02, 'energy', 0.003, 'rolloff', 1300);
%       utils.plot_results(x, f, mag, feats, mfccCoeffs, 'classical1', 'results/figures');
%
%   See also UTILS.COMPUTE_FFT, FEATURES.EXTRACT_MFCC

    if nargin < 7
        outputDir = '';
    end

    fig = figure('Name', ['DSP Analysis - ' fileLabel], 'Visible', 'on');

    subplot(2, 2, 1)
    plot(x)
    title(['Time Domain - ' fileLabel], 'Interpreter', 'none')
    xlabel('Samples')
    ylabel('Amplitude')

    subplot(2, 2, 2)
    plot(f, magnitude)
    title('Frequency Spectrum')
    xlabel('Frequency (Hz)')
    ylabel('Magnitude')

    subplot(2, 2, 3)
    bar([feats.centroid, feats.zcr * 10000, feats.energy * 10000, feats.rolloff])
    title('DSP Feature Comparison')
    set(gca, 'XTickLabel', {'Centroid', 'ZCR (x1e4)', 'Energy (x1e4)', 'Rolloff'})
    ylabel('Value')

    subplot(2, 2, 4)
    imagesc(mfccCoeffs')
    axis xy
    colorbar
    title('MFCC Feature Map')
    xlabel('Frame Number')
    ylabel('MFCC Coefficient')

    if ~isempty(outputDir)
        if ~isfolder(outputDir)
            mkdir(outputDir)
        end
        saveas(fig, fullfile(outputDir, [fileLabel '_analysis.png']));
    end
end
