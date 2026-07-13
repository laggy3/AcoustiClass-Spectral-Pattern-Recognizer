classdef TestZeroCrossingRate < matlab.unittest.TestCase
%TESTZEROCROSSINGRATE Unit tests for features.zero_crossing_rate.

    methods (Test)

        function testConstantSignalHasZeroCrossings(testCase)
            x = ones(100, 1);
            actual = features.zero_crossing_rate(x);
            testCase.verifyEqual(actual, 0, 'AbsTol', 1e-9);
        end

        function testAlternatingSignalHasMaxCrossingRate(testCase)
            % [-1, 1, -1, 1, ...] crosses zero every single sample.
            x = repmat([-1; 1], 50, 1);
            actual = features.zero_crossing_rate(x);
            testCase.verifyEqual(actual, 1, 'AbsTol', 1e-9);
        end

        function testKnownSequence(testCase)
            % sign: [1 1 -1 -1 1] -> |diff| = [0 2 0 2] -> sum=4, N=5 -> ZCR=4/10
            x = [1; 2; -1; -3; 5];
            actual = features.zero_crossing_rate(x);
            testCase.verifyEqual(actual, 4/10, 'AbsTol', 1e-9);
        end

        function testEmptyInputThrows(testCase)
            testCase.verifyError(@() features.zero_crossing_rate([]), ...
                'features:zero_crossing_rate:emptyInput');
        end

    end
end
