function results=orbitMOD2(r0,v0,nStep,tau,NumericalMethod)%MOD
% Invoke as (for example): orbitMOD(1,pi/2,40,0.01,4)
help orbit; %MOD
% Calculates the orbit of a comet.
% r0 is the initial radial distance in [AU].
% v0 is the initial tangential velocity in [AU/yr].
% nstep is the number of steps
% tau is the time step in [yr]
% NumericalMethod can be selected 1 through 3
%   - Method 1 uses Euler
%   - Method 2 uses Euler-Cromer
%   - Method 3 uses Runge-Kutta
%   - Method 4 uses Adaptive Runge-Kutta
% Original by AJG; modified by Jamie Isen 20200401.

%% * Set initial position and velocity of the comet.
%r0 = input('Enter initial radial distance (AU): ');  %MOD
%v0 = input('Enter initial tangential velocity (AU/yr): '); %MOD
r = [r0 0];  v = [0 v0];
state = [ r(1) r(2) v(1) v(2) ];   % Used by R-K routines

%% * Set physical parameters (mass, G*M)
GM = 4*pi^2;      % Grav. const. * Mass of Sun (au^3/yr^2)
mass = 1.;        % Mass of comet 
adaptErr = 1.e-3; % Error parameter used by adaptive Runge-Kutta
time = 0;

%% * Loop over desired number of steps using specified
%  numerical method.
%nStep = input('Enter number of steps: '); %MOD
%tau = input('Enter time step (yr): ');     %MOD
%NumericalMethod = menu('Choose a numerical method:', ...   %MOD
%       'Euler','Euler-Cromer','Runge-Kutta','Adaptive R-K');   %MOD
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
  elseif( NumericalMethod == 4 ) %MOD
    [state time tau] = rka(state,time,tau,adaptErr,@gravrk,GM);
    r = [state(1) state(2)];   % Adaptive Runge-Kutta
    v = [state(3) state(4)];
  else %MOD
      fprintf("Not a valid method"); %MOD
      return;    %MOD
  end
  
end

%% * Graph the trajectory of the comet.
figure(1); clf;  % Clear figure 1 window and bring forward
polarplot(thplot,rplot,'+');  % Use polar plot for graphing orbit %MOD
title('Distance (AU)');  %MOD
pause(1)   % Pause for 1 second before drawing next plot

%% * Graph the energy of the comet versus time.
figure(2); clf;   % Clear figure 2 window and bring forward
totalE = kinetic + potential;   % Total energy
plot(tplot,kinetic,'-.',tplot,potential,'--',tplot,totalE,'-')
legend('Kinetic','Potential','Total');
xlabel('Time (yr)'); ylabel('Energy (M AU^2/yr^2)');