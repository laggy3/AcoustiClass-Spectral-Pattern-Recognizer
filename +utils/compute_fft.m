function [f, magnitude] = compute_fft(x, fs)
%COMPUTE_FFT Compute the single-sided magnitude spectrum of a signal.
%   [F, MAGNITUDE] = UTILS.COMPUTE_FFT(X, FS) computes the Fast Fourier
%   Transform of the mono time-domain signal X and returns the
%   single-sided magnitude spectrum together with its frequency axis.
%
%   Inputs:
%       x  - Nx1 mono time-domain audio signal
%       fs - sample rate, in Hz
%
%   Outputs:
%       f         - frequency axis, in Hz (length floor(N/2))
%       magnitude - single-sided magnitude spectrum (length floor(N/2))
%
%   Example:
%       [f, magnitude] = utils.compute_fft(x, fs);
%       plot(f, magnitude)
%
%   See also FFT, FEATURES.SPECTRAL_CENTROID, FEATURES.SPECTRAL_ROLLOFF

    x = x(:);
    N = length(x);

    if N == 0
        error('utils:compute_fft:emptyInput', 'Input signal x is empty.');
    end

    X = fft(x);
    magnitude = abs(X(1:floor(N/2)));
    f = (0:length(magnitude)-1)' * (fs / N);
end
