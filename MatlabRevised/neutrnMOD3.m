function output= neutrnMOD3(tau,N,L,nstep) %MOD
% neutrn - Program to solve the neutron diffusion equation %MOD
% using the Forward Time Centered Space (FTCS) scheme. %MOD
% invoke as:  neutrnMOD3(0.0005,50,100,10000)		%MOD
% tau is time step  %MOD
% N is number of grid points %MOD
% L is system length  %MOD
% nstep is number of time steps %MOD
% Original by AJG; modified by HUI LI 20200406 %MOD
help neutrnMOD3;	% Print header %MOD
% clear all; help neutrn;  % Clear memory and print header %MOD

% * Initialize parameters (time step, grid points, etc.).
% tau = input('Enter time step: '); %MOD
% N = input('Enter the number of grid points: '); %MOD
% L = input('Enter system length: ');  %MOD
% The system extends from x=-L/2 to x=L/2
h = L/(N-1);  % Grid size
D = 1.;   % Diffusion coefficient
C = 1.;   % Generation rate
coeff = D*tau/h^2;
coeff2 = C*tau;
if( coeff < 0.5 )
  disp('Solution is expected to be stable');
else
  disp('WARNING: Solution is expected to be unstable');
end

% * Set initial and boundary conditions.
nn = zeros(N,1);        % Initialize density to zero at all points
nn_new = zeros(N,1);    % Initialize temporary array used by FTCS
nn(round(N/2)) = 1/h;   % Initial cond. is delta function in center

% The boundary conditions are nn(1) = nn(N) = 0

% * Set up loop and plot variables.
xplot = (0:N-1)*h - L/2;   % Record the x scale for plots
iplot = 1;                 % Counter used to count plots
% nstep = input('Enter number of time steps: '); %MOD
nplots = 50;               % Number of snapshots (plots) to take
plot_step = nstep/nplots;  % Number of time steps between plots

% * Loop over the desired number of time steps.
for istep=1:nstep  %% MAIN LOOP %%

  %* Compute the new density using FTCS scheme.
  nn_new(2:(N-1)) = nn(2:(N-1)) + ...
      coeff*(nn(3:N) + nn(1:(N-2)) - 2*nn(2:(N-1))) + ...
	   coeff2*nn(2:(N-1));
  nn = nn_new;        % Reset temperature to new values
  
  %* Periodically record the density for plotting.
  if( rem(istep,plot_step) < 1 )   % Every plot_step steps
    nnplot(:,iplot) = nn(:);       % record nn(i) for plotting
    tplot(iplot) = istep*tau;      % Record time for plots
    nAve(iplot) = mean(nn);        % Record average density 
	 iplot = iplot+1;
	 fprintf('Finished %g of %g steps\n',istep,nstep);
  end
end

% * Plot density versus x and t as a 3D-surface plot
figure(1); clf;
mesh(tplot,xplot,nnplot);
xlabel('Time');  ylabel('x');  zlabel('n(x,t)');
title('Neutron diffusion');

% * Plot average neutron density versus time
figure(2); clf;
plot(tplot,nAve,'*');
xlabel('Time'); ylabel('Average density');
title(['L = ',num2str(L),'  (L_c = \pi)']);