function interpMOD1(temp,xr) %MOD
%% interpMOD1 - Modified program to interpolate data using Lagrange %MOD
% polynomial to fit quadratic to three data points
% invoke as interpMOD1([-1 2; 0 3; 1 2], [-2 2]) %MOD
% temp stores the 3 x,y point values to be fit 
                               % by quadratic: [x1 y1; x2 y2; x3 y3] %MOD
% xr is the range of interpolation from xmin to xmax: [xmin xmax] %MOD
% Original by AJG; modified by Julia Bicknell 20200405 %MOD
 help interpMOD1;  % print header %MOD

%% * Initialize the data points to be fit by quadratic
x = zeros; y = zeros; %MOD
for i=1:3
  x(i) = temp(i,1); %MOD
  y(i) = temp(i,2); %MOD
end
%MOD (line deleted here)
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
end