function sc = spectral_centroid(f, magnitude)
%SPECTRAL_CENTROID Compute the spectral centroid of a magnitude spectrum.
%   SC = FEATURES.SPECTRAL_CENTROID(F, MAGNITUDE) computes the spectral
%   centroid ("center of mass" of the frequency spectrum) given a
%   frequency vector F (Hz) and its corresponding magnitude spectrum.
%
%   Formula:
%       SC = sum(f(k) .* X(k)) / sum(X(k))
%
%   where f(k) is the frequency of bin k and X(k) is the magnitude of
%   the spectrum at bin k.
%
%   Inputs:
%       f         - Nx1 (or 1xN) vector of frequency bins, in Hz
%       magnitude - Nx1 (or 1xN) vector of magnitude spectrum values,
%                   same length as f
%
%   Output:
%       sc - scalar spectral centroid, in Hz. Low values indicate
%            smoother/darker sounds; high values indicate brighter
%            sounds with more high-frequency energy.
%
%   Example:
%       [f, mag] = utils.compute_fft(x, fs);
%       sc = features.spectral_centroid(f, mag);
%
%   See also FEATURES.ZERO_CROSSING_RATE, FEATURES.SPECTRAL_ROLLOFF,
%   UTILS.COMPUTE_FFT

    f = f(:);
    magnitude = magnitude(:);

    if numel(f) ~= numel(magnitude)
        error('features:spectral_centroid:sizeMismatch', ...
            'f and magnitude must have the same number of elements.');
    end

    totalEnergy = sum(magnitude);

    if totalEnergy == 0
        warning('features:spectral_centroid:zeroEnergy', ...
            'Magnitude spectrum has zero total energy; returning 0.');
        sc = 0;
        return
    end

    sc = sum(f .* magnitude) / totalEnergy;
end
