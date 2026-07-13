function [x, fs] = preprocess_audio(filepath)
%PREPROCESS_AUDIO Read a WAV file and convert it to mono.
%   [X, FS] = UTILS.PREPROCESS_AUDIO(FILEPATH) reads the audio file at
%   FILEPATH using AUDIOREAD and converts stereo signals to mono by
%   averaging the two channels together.
%
%   Inputs:
%       filepath - full or relative path to a .wav audio file
%
%   Outputs:
%       x  - Nx1 mono time-domain audio signal (double, normalized to
%            [-1, 1] as returned by AUDIOREAD)
%       fs - sample rate, in Hz
%
%   Throws:
%       utils:preprocess_audio:fileNotFound if FILEPATH does not point
%       to an existing file.
%
%   Example:
%       [x, fs] = utils.preprocess_audio('data/raw/classical1.wav');
%
%   See also AUDIOREAD, UTILS.COMPUTE_FFT

    if ~isfile(filepath)
        error('utils:preprocess_audio:fileNotFound', ...
            'Audio file not found: %s', filepath);
    end

    [x, fs] = audioread(filepath);

    % Stereo to mono conversion (average both channels)
    if size(x, 2) == 2
        x = mean(x, 2);
    end
end
