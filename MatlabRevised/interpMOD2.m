function interpMOD2(x,y,xr)       %MOD
%% interp - Program to interpolate data using Lagrange 
% polynomial to fit quadratic to three data points
% Original by AJG; modified by Eduardo Chomen Ramos 20200405 %MOD
% interpMOD2([1 2 3],[2 3 4],[0 10])                          %MOD
% x = x coordinate of the three points to be interpolated    %MOD
% y = y coordinate of the three points to be interpolated    %MOD
% xr = range of interpolation (from x_min to x_max)
help interp;  % Clear memory and print header
%% The following modded lines were removed since, now that the program runs from the command line, it does not need to request inputs %MOD
%% * Initialize the data points to be fit by quadratic  %MOD
%disp('Enter data points as x,y pairs (e.g., [1 2])');  %MOD
%for i=1:3                                              %MOD
%temp = input('Enter data point: ');                    %MOD
%  x(i) = temp(1);                                      %MOD
%  y(i) = temp(2);                                      %MOD
%end                                                    %MOD
%% * Establish the range of interpolation (from x_min to x_max)   %MOD
%xr = input('Enter range of x values as [x_min x_max]: ');        %MOD
%% * Find yi for the desired interpolation values xi using
%  the function intrpf
nplot = 100;     % Number of points for interpolation curve
for i=1:nplot
  xi(i) = xr(1) + (xr(2)-xr(1))*(i-1)/(nplot-1);
  yi(i) = intrpf(xi(i),x,y);  % Use intrpf function to interpolate
end
%% * Plot the curve given by (xi,yi) and mark original data points
plot(x,y,'*',xi,yi,'-');
xlabel('x');
ylabel('y');
title('Three point interpolation');
legend('Data points','Interpolation  ');
return;                          %MOD