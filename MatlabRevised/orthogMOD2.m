function orthogMOD2(a,b) %MOD
%% orthog - Program to test if a pair of vectors 
% is orthogonal.  Assumes vectors are in 3D space
% Invoke as: orthogMOD2([1 2 3],[4 5 6]) %MOD
% a is the first vector, b is the second vector %MOD
% Original by AJG; modified by (Margarita Khramova) 20200602    %MOD
help orthog;   %MOD
%% * Initialize the vectors a and b
% a = input('Enter the first vector: ');    %MOD
% b = input('Enter the second vector: ');   %MOD
%% * Evaluate the dot product as sum over products of elements
a_dot_b = 0;
for i=1:3
  a_dot_b = a_dot_b + a(i)*b(i);
end
%% * Print dot product and state whether vectors are orthogonal
if( a_dot_b == 0 )
  disp('Vectors are orthogonal');
else
  disp('Vectors are NOT orthogonal');
  fprintf('Dot product = %g \n',a_dot_b);
end %MOD