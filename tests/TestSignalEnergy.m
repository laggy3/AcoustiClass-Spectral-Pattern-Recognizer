classdef TestSignalEnergy < matlab.unittest.TestCase
%TESTSIGNALENERGY Unit tests for features.signal_energy.

    methods (Test)

        function testUnitAmplitudeSignal(testCase)
            x = ones(10, 1);
            actual = features.signal_energy(x);
            testCase.verifyEqual(actual, 1, 'AbsTol', 1e-9);
        end

        function testKnownSequence(testCase)
            % x = [1 2 3] -> sum(x.^2)=14, N=3 -> energy = 14/3
            x = [1; 2; 3];
            actual = features.signal_energy(x);
            testCase.verifyEqual(actual, 14/3, 'AbsTol', 1e-9);
        end

        function testSilentSignalHasZeroEnergy(testCase)
            x = zeros(1000, 1);
            actual = features.signal_energy(x);
            testCase.verifyEqual(actual, 0);
        end

        function testEmptyInputThrows(testCase)
            testCase.verifyError(@() features.signal_energy([]), ...
                'features:signal_energy:emptyInput');
        end

    end
end
