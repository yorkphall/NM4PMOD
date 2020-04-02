function result = orbitMOD1(initR, initV, stepNum, stepTime, metho) %MOD
%% orbitMOD1 - Program to compute the orbit of a comet. %MOD
% Original by AJG; modified by Adrianna Van Brenen 20200402 %MOD
help orbitMOD1;  % Clear memory and print header %MOD

% initialize as: orbitMOD(initR, initV, stepNum, stepTime, metho) %MOD
% example: orbitMOD1(1, 2*pi, 300, 0.01, 3) %MOD

% initR = the initial radial distance [AU] %MOD
% initV = the initial tangential velocity [AU/yr] %MOD
% stepNum = the number of steps for the simulation to run %MOD
% stepTime = the duration of one timestep [yr] %MOD
% metho = numerical method to use. 1 - Euler, 2 - Euler-Cromer, %MOD
% 3 - Runge-Kutta, 4 - Adaptive Runge-Kutta %MOD

%% * Set initial position and velocity of the comet.
r0 = initR; %MOD
v0 = initV; %MOD
r = [r0 0];  v = [0 v0];
state = [ r(1) r(2) v(1) v(2) ];   % Used by R-K routines

%% * Set physical parameters (mass, G*M)
GM = 4*pi^2;      % Grav. const. * Mass of Sun (au^3/yr^2)
mass = 1.;        % Mass of comet 
adaptErr = 1.e-3; % Error parameter used by adaptive Runge-Kutta
time = 0;

%% * Loop over desired number of steps using specified
%  numerical method.
nStep = stepNum; %MOD
tau = stepTime; %MOD
NumericalMethod = metho; %MOD
for iStep=1:nStep  

  %* Record position and energy for plotting.
  rplot(iStep) = norm(r);           % Record position for polar plot
  thplot(iStep) = atan2(r(2),r(1));
  tplot(iStep) = time;
  kinetic(iStep) = .5*mass*norm(v)^2;   % Record energies
  potential(iStep) = - GM*mass/norm(r);
  
  %* Calculate new position and velocity using desired method.
  if( NumericalMethod == 1 )
    accel = -GM*r/norm(r)^3;   
    r = r + tau*v;             % Euler step
    v = v + tau*accel; 
    time = time + tau;   
  elseif( NumericalMethod == 2 )
    accel = -GM*r/norm(r)^3;   
    v = v + tau*accel; 
    r = r + tau*v;             % Euler-Cromer step
    time = time + tau;     
  elseif( NumericalMethod == 3 )
    state = rk4(state,time,tau,@gravrk,GM);
    r = [state(1) state(2)];   % 4th order Runge-Kutta
    v = [state(3) state(4)];
    time = time + tau;   
  else
    [state time tau] = rka(state,time,tau,adaptErr,@gravrk,GM);
    r = [state(1) state(2)];   % Adaptive Runge-Kutta
    v = [state(3) state(4)];
  end
  
end

%% * Graph the trajectory of the comet.
figure(1); clf;  % Clear figure 1 window and bring forward
polarplot(thplot,rplot,'+');  % Use polar plot for graphing orbit %MOD
title('Distance (AU)'); %label for r axis as title %MOD
%xlabel('Distance (AU)');  %removed due to removal of support with polarplot %MOD
%grid; %I do not want to toggle to grid to be off %MOD
pause(1)   % Pause for 1 second before drawing next plot

%% * Graph the energy of the comet versus time.
figure(2); clf;   % Clear figure 2 window and bring forward
totalE = kinetic + potential;   % Total energy
plot(tplot,kinetic,'-.',tplot,potential,'--',tplot,totalE,'-')
legend('Kinetic','Potential','Total');
xlabel('Time (yr)'); ylabel('Energy (M AU^2/yr^2)');
end %MOD