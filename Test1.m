classdef Test1 < matlab.unittest.Test
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods (Test)
        function testSolution(testCase)
            
            [Q,S]=cpd_GRBF_lowrankQSParallel(Y, beta, numeig, eigfgt, fgt);
            [Q2,S2]=cpd_GRBF_lowrankQS(Y, beta, numeig, eigfgt, fgt );
            testCase.verifyEqual(Q,Q2);
        end
            
    end
    
end

