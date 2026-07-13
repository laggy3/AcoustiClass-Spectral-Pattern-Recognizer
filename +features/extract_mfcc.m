function [coeffs, meanValue] = extract_mfcc(x, fs)
%EXTRACT_MFCC Extract Mel-Frequency Cepstral Coefficients for analysis.
%   [COEFFS, MEANVALUE] = FEATURES.EXTRACT_MFCC(X, FS) computes the MFCC
%   matrix for the mono time-domain signal X sampled at FS Hz, using
%   MATLAB Audio Toolbox's MFCC pipeline (pre-emphasis, framing,
%   Hamming windowing, FFT, Mel filter bank, log energy, DCT).
%
%   IMPORTANT: MFCC features are computed for analysis / visualization
%   purposes only. They are intentionally NOT used inside
%   CLASSIFY_GENRE.m, matching the original project scope.
%
%   Inputs:
%       x  - Nx1 mono time-domain audio signal
%       fs - sample rate, in Hz
%
%   Outputs:
%       coeffs    - [numFrames x numCoeffs] matrix of MFCC coefficients
%       meanValue - scalar mean of all MFCC coefficients (summary
%                   statistic used for reporting only)
%
%   Requires: MATLAB Audio Toolbox (mfcc function)
%
%   Example:
%       [mfccCoeffs, mfccMean] = features.extract_mfcc(x, fs);
%
%   See also MFCC, UTILS.PLOT_RESULTS

    if isempty(x)
        error('features:extract_mfcc:emptyInput', ...
            'Input signal x is empty.');
    end

    try
        coeffs = mfcc(x, fs);
    catch ME
        error('features:extract_mfcc:mfccFailed', ...
            ['Failed to compute MFCC coefficients. Ensure the MATLAB ' ...
             'Audio Toolbox is installed.\nOriginal error: %s'], ME.message);
    end

    meanValue = mean(coeffs(:));
end
