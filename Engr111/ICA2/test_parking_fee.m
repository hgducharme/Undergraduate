%TEST_PARKING_FEE testcases for parking_fee.m

% testcases [hours, expected_fee]
testcases = [...
[0,0]
[-1,40] % lost ticket
[2,4]
[3,7]
[4,7]
[5,8]
[20,23]
[-20,59] % lost ticket
[22,24]
[24,24]
[25,28]
[-25,64] % lost ticket
[27,31]
[29,32]
[46,48]
[123,127]
[-123,163] % lost ticket
[1+rand-0.5,4] % about an hour
[3+rand-0.5,7] % about 3 hours
[12+rand,16] % about 12.5 hours
];

if ~exist('parking_fee','file')
    fprintf(2,[...
        'It seems that parking_fee.m does not exist.\n'...
        'Have you created the function yet?\n'...
        'If so, are you in the correct directory?\n']);
    return
end

try
    nargin('parking_fee');
catch exception
    fprintf(2,[...
        'It seems that parking_fee.m is not a function.\n'...
        'You must write a function, not a script.\n']);
    return
end

helpTxt = help('parking_fee');
if isempty(helpTxt)
    fprintf(2,[...
        'It seems that parking_fee.m does not have any help comments.\n'...
        'Did you forget them?\n'...
        'Are they in the wrong place?\n']);
    return
end

passed = 0;
failed = 0;
for i = 1: size(testcases,1)
    t = testcases(i,:);
    hours = t(1);
    expected = t(2);
    actual = parking_fee(hours);
    if actual ~= expected
        fprintf(2,'FAILED test #%d (%d hours): expected %d, got %d\n',...
            i,hours,expected,actual);
        failed = failed + 1;
    else
        fprintf('PASSED test #%d\n',i);
        passed = passed + 1;
    end
end
fprintf('[\bPassed: %d\nFailed: %d]\b\n',passed,failed);