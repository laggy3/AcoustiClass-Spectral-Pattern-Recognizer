classdef TestSpectralRolloff < matlab.unittest.TestCase
%TESTSPECTRALROLLOFF Unit tests for features.spectral_rolloff.

    methods (Test)

        function testDefaultThresholdOnStepSpectrum(testCase)
            % Energy [1 1 1 1 1 1 1 1 1 10] concentrated in the last bin.
            % Cumulative sum reaches 85% only once the last (10-index)
            % bin is included, so roll-off should equal the last frequency.
            f = (100:100:1000)';
            magnitude = [ones(9,1); 10];
            actual = features.spectral_rolloff(f, magnitude);
            testCase.verifyEqual(actual, 1000);
        end

        function testUniformSpectrumRolloffNearEnd(testCase)
            f = (1:10)';
            magnitude = ones(10, 1);
            actual = features.spectral_rolloff(f, magnitude, 0.85);
            % Cumulative energy reaches 85% of 10 (=8.5) at bin index 9.
            testCase.verifyEqual(actual, 9);
        end

        function testCustomThreshold(testCase)
            f = (1:4)';
            magnitude = [1; 1; 1; 1];
            % 50% threshold -> cumulative [1 2 3 4] reaches 2 (=50% of 4) at index 2.
            actual = features.spectral_rolloff(f, magnitude, 0.5);
            testCase.verifyEqual(actual, 2);
        end

        function testInvalidThresholdThrows(testCase)
            f = [1 2 3];
            magnitude = [1 1 1];
            testCase.verifyError(@() features.spectral_rolloff(f, magnitude, 1.5), ...
                'features:spectral_rolloff:invalidThreshold');
        end

        function testMismatchedLengthsThrows(testCase)
            f = [1 2 3];
            magnitude = [1 2];
            testCase.verifyError(@() features.spectral_rolloff(f, magnitude), ...
                'features:spectral_rolloff:sizeMismatch');
        end

    end
end
