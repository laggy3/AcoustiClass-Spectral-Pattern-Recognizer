function genre = classify_genre(spectralCentroid, zcr, energy)
%CLASSIFY_GENRE Rule-based genre classification from DSP features.
%   GENRE = CLASSIFY_GENRE(SPECTRALCENTROID, ZCR, ENERGY) applies a set
%   of ordered threshold rules to the extracted DSP features and returns
%   a music genre label.
%
%   Classification rules (evaluated in order, first match wins):
%
%       Classical  : spectralCentroid <  2000 Hz  AND energy < 0.02
%       Jazz       : spectralCentroid <  2600 Hz  AND zcr    < 0.04
%       Pop        : spectralCentroid <  3300 Hz  AND energy < 0.12
%       Rock       : spectralCentroid >  3800 Hz  AND energy > 0.09
%       Electronic : otherwise (fallback / default)
%
%   Inputs:
%       spectralCentroid - scalar spectral centroid, in Hz
%                          (see features.spectral_centroid)
%       zcr              - scalar zero crossing rate
%                          (see features.zero_crossing_rate)
%       energy           - scalar signal energy
%                          (see features.signal_energy)
%
%   Output:
%       genre - character vector, one of:
%               'Classical' | 'Jazz' | 'Pop' | 'Rock' | 'Electronic'
%
%   Note:
%       MFCC features are intentionally excluded from this decision
%       logic. They are extracted separately (features.extract_mfcc)
%       for spectral analysis and visualization only.
%
%   Example:
%       genre = classify_genre(849.83, 0.0231, 0.0031);  % -> 'Classical'
%       genre = classify_genre(4309.86, 0.0623, 0.1027); % -> 'Rock'
%
%   See also FEATURES.SPECTRAL_CENTROID, FEATURES.ZERO_CROSSING_RATE,
%   FEATURES.SIGNAL_ENERGY

    if spectralCentroid < 2000 && energy < 0.02
        genre = 'Classical';
    elseif spectralCentroid < 2600 && zcr < 0.04
        genre = 'Jazz';
    elseif spectralCentroid < 3300 && energy < 0.12
        genre = 'Pop';
    elseif spectralCentroid > 3800 && energy > 0.09
        genre = 'Rock';
    else
        genre = 'Electronic';
    end
end
