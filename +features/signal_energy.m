function e = signal_energy(x)
%SIGNAL_ENERGY Compute the average energy of a time-domain signal.
%   E = FEATURES.SIGNAL_ENERGY(X) computes the mean squared amplitude
%   of the mono audio signal X.
%
%   Formula:
%       Energy = (1 / N) * sum(x(n)^2)
%
%   Inputs:
%       x - Nx1 (or 1xN) vector, mono time-domain audio signal
%
%   Output:
%       e - scalar signal energy. Signals with higher amplitude
%           variation generally produce higher energy values.
%
%   Example:
%       e = features.signal_energy(x);
%
%   See also FEATURES.ZERO_CROSSING_RATE, FEATURES.SPECTRAL_CENTROID

    x = x(:);

    if isempty(x)
        error('features:signal_energy:emptyInput', ...
            'Input signal x is empty.');
    end

    e = sum(x.^2) / length(x);
end
