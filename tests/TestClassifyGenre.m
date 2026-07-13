classdef TestClassifyGenre < matlab.unittest.TestCase
%TESTCLASSIFYGENRE Unit tests for classify_genre.m
%   Test values are taken directly from the sample outputs documented
%   in the project report (see docs/report/).

    methods (Test)

        function testClassicalSample(testCase)
            genre = classify_genre(849.83, 0.0231, 0.0031);
            testCase.verifyEqual(genre, 'Classical');
        end

        function testPopSample(testCase)
            genre = classify_genre(2855.29, 0.0292, 0.0918);
            testCase.verifyEqual(genre, 'Pop');
        end

        function testRockSample(testCase)
            genre = classify_genre(4309.86, 0.0623, 0.1027);
            testCase.verifyEqual(genre, 'Rock');
        end

        function testJazzSample(testCase)
            genre = classify_genre(2291.63, 0.0282, 0.0230);
            testCase.verifyEqual(genre, 'Jazz');
        end

        function testElectronicSample(testCase)
            genre = classify_genre(3565.32, 0.0336, 0.0879);
            testCase.verifyEqual(genre, 'Electronic');
        end

    end
end
