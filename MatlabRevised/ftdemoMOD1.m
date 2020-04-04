function [] = ftdemoMOD(N,freq,phase,Method)   %MOD
% ftdemoMOD - Discrete Fourier transform demonstration program    %MOD
% invoked as: ftdemoMOD(50,0.2,0,1)          %MOD
% N is the number of points                  %MOD
% freq is the frequency of the sine wave     %MOD
% phase is the phase of the sine wave        %MOD
% Method is the method used to compute the transform. Use direct summation  %MOD
% when Method ==1 or use fast Fourier transform (FFT) algorithm otherwise   %MOD
% Original by AJG; modified by Yu Luo 20200404 %MOD
help ftdemoMOD % Print header                %MOD
% clear all; help ftdemo; % Clear memory and print header      %MOD

%% * Initialize the sine wave time series to be transformed.
% N = input('Enter the number of points: ');         %MOD
% freq = input('Enter frequency of the sine wave: ');  %MOD
% phase = input('Enter phase of the sine wave: ');     %MOD
tau = 1;  % Time increment
t = (0:(N-1))*tau;              % t = [0, tau, 2*tau, ... ]
y = sin(2*pi*t*freq + phase);   % Sine wave time series
f = (0:(N-1))/(N*tau);          % f = [0, 1/(N*tau), ... ] 

%% * Compute the transform using desired method: direct summation
%  or fast Fourier transform (FFT) algorithm.
% Method = menu('Compute transform by','Direct summation','FFT');     %MOD
tStart = cputime;  % Start the stopwatch
if  ( Method == 1 )               % Direct summation   %MOD
% if( Method == 1 );             % Direct summation  %MOD
  twoPiN = -2*pi*sqrt(-1)/N;
  for k=0:N-1
    expTerm = exp(twoPiN*(0:N-1)*k);
    yt(k+1) = sum(y .* expTerm);
  end
else                           % Fast Fourier transform
  yt = fft(y);
end
tStop = cputime; % Stop the stopwatch
fprintf('Elapsed time (sec) = %g\n',tStop-tStart);

%% * Graph the time series and its transform.
figure(1); clf;  % Clear figure 1 window and bring forward
plot(t,y);
title('Original time series');
ylabel('Amplitude');  xlabel('Time');
figure(2); clf;  % Clear figure 2 window and bring forward
plot(f,real(yt),'-',f,imag(yt),'--');
legend('Real','Imaginary  ');
title('Fourier transform');
ylabel('Transform');  xlabel('Frequency');

%% * Compute and graph the power spectrum of the time series.
figure(3); clf;  % Clear figure 3 window and bring forward
powspec = abs(yt).^2;
semilogy(f,powspec,'-');
title('Power spectrum (unnormalized)');
ylabel('Power');  xlabel('Frequency');
end