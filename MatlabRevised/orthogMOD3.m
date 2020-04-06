function dummy_output = orthogMOD3(a,b)	%MOD
% orthogMOD3 - Program to test if a pair of vectors are orthogonal %MOD
% invoke as:  orthogMOD3([1 1 1],[1 -2 1])		%MOD
% a is the first vector and b is the second vector	%MOD
% Assumes vectors are in 3D space
% clear all;  help orthog;   % Clear the memory and print header
help orthogMOD3; %print header %MOD
%% * Initialize the vectors a and b %MOD
% any test vector for a and b %MOD
% a = input('Enter the first vector: '); %MOD
% b = input('Enter the second vector: '); %MOD
%% * Evaluate the dot product as sum over products of elements %MOD
a_dot_b = 0;
for i=1:3 
  a_dot_b = a_dot_b + a(i)*b(i);
end
%% * Print dot product and state whether vectors are orthogonal %MOD
% Both dot product will be zero if they are orthogonal %MOD
if( a_dot_b == 0 )
  disp('Vectors are orthogonal');
else
  disp('Vectors are NOT orthogonal');
  fprintf('Dot product = %g \n',a_dot_b);
end
% Original by AJG; modified by Rosalyn Chan  20200406 