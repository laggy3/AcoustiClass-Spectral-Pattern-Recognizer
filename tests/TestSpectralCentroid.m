classdef TestSpectralCentroid < matlab.unittest.TestCase
%TESTSPECTRALCENTROID Unit tests for features.spectral_centroid.

    methods (Test)

        function testEnergyConcentratedAtSingleBin(testCase)
            % All energy at 300 Hz -> centroid must equal 300 Hz exactly.
            f = [100; 200; 300; 400];
            magnitude = [0; 0; 5; 0];
            actual = features.spectral_centroid(f, magnitude);
            testCase.verifyEqual(actual, 300, 'AbsTol', 1e-9);
        end

        function testUniformSpectrumReturnsMeanFrequency(testCase)
            % Flat spectrum -> centroid equals the mean of the frequency axis.
            f = (0:9)';
            magnitude = ones(10, 1);
            actual = features.spectral_centroid(f, magnitude);
            expected = mean(f);
            testCase.verifyEqual(actual, expected, 'AbsTol', 1e-9);
        end

        function testAcceptsRowVectors(testCase)
            f = [0 100 200 300];
            magnitude = [1 1 1 1];
            actual = features.spectral_centroid(f, magnitude);
            testCase.verifyEqual(actual, mean(f), 'AbsTol', 1e-9);
        end

        function testMismatchedLengthsThrows(testCase)
            f = [1 2 3];
            magnitude = [1 2];
            testCase.verifyError(@() features.spectral_centroid(f, magnitude), ...
                'features:spectral_centroid:sizeMismatch');
        end

        function testZeroEnergyReturnsZeroWithWarning(testCase)
            f = [1 2 3];
            magnitude = [0 0 0];
            testCase.verifyWarning(@() features.spectral_centroid(f, magnitude), ...
                'features:spectral_centroid:zeroEnergy');
            actual = features.spectral_centroid(f, magnitude);
            testCase.verifyEqual(actual, 0);
        end

    end
end
