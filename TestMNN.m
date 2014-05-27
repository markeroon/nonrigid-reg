classdef TestMNN < matlab.unittest.TestCase
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods (Test)
        function testSolution(testCase)
            
           	X = [ 3  3 ; 0 18 ]; 
            Y = [ 5 3 ; 3 17 ; 3 3 ];
            [idx_x,points_y] = getMutualNeighbours( X,Y );
            testCase.verifyEqual( [3 3 ; 3 17], points_y, 'AbsTol',0.000001 );
            
            %[Q,S]=cpd_GRBF_lowrankQSParallel(Y, beta, numeig, eigfgt, fgt);
            %[Q2,S2]=cpd_GRBF_lowrankQS(Y, beta, numeig, eigfgt, fgt );
            %testCase.verifyEqual(Q,Q2);
        end
            
    end
    
end

