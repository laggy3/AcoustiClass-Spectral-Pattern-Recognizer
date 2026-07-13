function zcr = zero_crossing_rate(x)
%ZERO_CROSSING_RATE Compute the zero crossing rate of a time-domain signal.
%   ZCR = FEATURES.ZERO_CROSSING_RATE(X) computes the normalized rate at
%   which the mono audio signal X changes sign from one sample to the
%   next.
%
%   Formula:
%       ZCR = (1 / 2N) * sum(|sign(x(n)) - sign(x(n-1))|)
%
%   Inputs:
%       x - Nx1 (or 1xN) vector, mono time-domain audio signal
%
%   Output:
%       zcr - scalar zero crossing rate. Higher values indicate a
%             noisier signal with more high-frequency content
%             (e.g. distorted guitars, cymbals, synthesized noise).
%
%   Example:
%       zcr = features.zero_crossing_rate(x);
%
%   See also FEATURES.SPECTRAL_CENTROID, FEATURES.SIGNAL_ENERGY

    x = x(:);

    if isempty(x)
        error('features:zero_crossing_rate:emptyInput', ...
            'Input signal x is empty.');
    end

    zcr = sum(abs(diff(sign(x)))) / (2 * length(x));
end
