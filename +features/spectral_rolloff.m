function ro = spectral_rolloff(f, magnitude, rolloffPercent)
%SPECTRAL_ROLLOFF Compute the spectral roll-off frequency of a spectrum.
%   RO = FEATURES.SPECTRAL_ROLLOFF(F, MAGNITUDE) computes the frequency
%   below which 85% of the total spectral energy is contained.
%
%   RO = FEATURES.SPECTRAL_ROLLOFF(F, MAGNITUDE, ROLLOFFPERCENT) uses a
%   custom energy threshold ROLLOFFPERCENT (0 < ROLLOFFPERCENT < 1)
%   instead of the default 0.85.
%
%   Inputs:
%       f              - Nx1 (or 1xN) vector of frequency bins, in Hz
%       magnitude      - Nx1 (or 1xN) vector of magnitude spectrum
%                        values, same length as f
%       rolloffPercent - (optional) energy fraction threshold,
%                        default 0.85
%
%   Output:
%       ro - scalar frequency, in Hz, below which ROLLOFFPERCENT of the
%            total spectral energy is contained. Indicates how quickly
%            the spectral energy decays with frequency.
%
%   Example:
%       ro85 = features.spectral_rolloff(f, mag);
%       ro90 = features.spectral_rolloff(f, mag, 0.90);
%
%   See also FEATURES.SPECTRAL_CENTROID, UTILS.COMPUTE_FFT

    if nargin < 3 || isempty(rolloffPercent)
        rolloffPercent = 0.85;
    end

    f = f(:);
    magnitude = magnitude(:);

    if numel(f) ~= numel(magnitude)
        error('features:spectral_rolloff:sizeMismatch', ...
            'f and magnitude must have the same number of elements.');
    end
    if rolloffPercent <= 0 || rolloffPercent >= 1
        error('features:spectral_rolloff:invalidThreshold', ...
            'rolloffPercent must be strictly between 0 and 1.');
    end

    totalEnergy = sum(magnitude);
    if totalEnergy == 0
        warning('features:spectral_rolloff:zeroEnergy', ...
            'Magnitude spectrum has zero total energy; returning 0.');
        ro = 0;
        return
    end

    cumulativeEnergy = cumsum(magnitude);
    idx = find(cumulativeEnergy >= rolloffPercent * totalEnergy, 1);

    if isempty(idx)
        idx = numel(f);
    end

    ro = f(idx);
end
