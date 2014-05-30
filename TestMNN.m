classdef TestMNN < matlab.unittest.TestCase
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods (Test)
        function testSolution(testCase)
            
           	X = [ 3  3 ; 0 18 ; 1 17 ; 100 100 ]; 
            Y = [ 5 3 ; 0 18 ; 3 3 ; 99 99 ];
            [idx_x,points_y] = getMutualNeighbours( X,Y );
            testCase.verifyEqual( [3 3 ; 0 18; 99 99], points_y, 'AbsTol',0.000001 );
            
            %[Q,S]=cpd_GRBF_lowrankQSParallel(Y, beta, numeig, eigfgt, fgt);
            %[Q2,S2]=cpd_GRBF_lowrankQS(Y, beta, numeig, eigfgt, fgt );
            %testCase.verifyEqual(Q,Q2);
        end
            
        function testSimple(testCase)
            X = [3 3];
            Y = [5 3 ; 3 2.9];
            [idx_x,points_y] = getMutualNeighbours( X,Y );
            testCase.verifyEqual( [3 2.9], points_y, 'AbsTol',0.000001 );
        end
    end
    
end

