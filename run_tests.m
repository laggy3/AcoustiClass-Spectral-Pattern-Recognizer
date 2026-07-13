%% RUN_TESTS - Execute the full unit test suite for this project.
%   Discovers and runs every test class inside tests/ using the MATLAB
%   Unit Testing Framework, printing a text summary to the command
%   window and returning a non-zero exit style result if any test fails.
%
%   Usage:
%       >> run_tests

import matlab.unittest.TestSuite
import matlab.unittest.TestRunner

projectRoot = fileparts(mfilename('fullpath'));
addpath(projectRoot);

suite  = TestSuite.fromFolder(fullfile(projectRoot, 'tests'), 'IncludingSubfolders', true);
runner = TestRunner.withTextOutput;
results = runner.run(suite);

disp(results)

numFailed = nnz([results.Failed]);
if numFailed > 0
    fprintf(2, '%d test(s) FAILED.\n', numFailed);
else
    fprintf('All %d test(s) PASSED.\n', numel(results));
end
