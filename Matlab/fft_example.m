%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  The Ideal FFT Plotter
%
%  Created by Jon Guerber, June 23, 2009
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% The FFT function in Matlab is useful for translating a time domain
% waveform into its frequency domain representation.  While a simple idea,
% the process of coding this can be awkward the first time.  Here are some
% sample wavforms and their frequency domain representations.  





%%% When taking an FFT, there are a couple of important rules to remember:

% 1.  The number of points or samples taken in the time domain waveform
% should be in the set of 2^N.  Common sample numbers include 64, 1024, and
% 16384.

% 2.  Within the number of points taken, there should be an integer number
% of periods.  This is becasue the FFT creates "frequency bins" from 1 to
% the number of points taken.  If the total periods is not an interger, it
% won't fall into a bin.  If this is impossible to accomplish, consider
% windowing.

% 3.  Make sure that the interger number of periods from stap 2 is a prime
% number.  This ensures nothing "folds" down from higher frequencies into
% your signal (or noise) bin.  

% 4.  The FFT output is discrete so its symmetric.  This means you really
% only have to plot the first half of the wavform (unless you do something
% funky).

% 5.  If you have a signal and noise plot, you can find the SNR by sorting
% the frequency bins and dividing the biggest frequency bin by the sum of
% all the others. 

% 6.  Feel free to ask me if you have questions.  I don't know everything,
% but I can typically point you to people who do!  Have fun



clc


%%%%%%%% Sine Ideal Time and Frequency Response  %%%%%%%%%%

B = 10;                                        % The number of points (2^B)
Vref = 1;

s = ((sin(2*pi*17/(2^B)*[0:((2^B)-1)]))/2);    % Create a sine wave with frequency in bin #17
f=(0:1:(2^B)-1)*(1);                           % Normalize the index values of the Sine wave  between 0 and 1
fftout = abs(fft((s)))/(2^B);                  % Take the B-point FFT
fftoutdB = 20*log10(fftout/(max(fftout)));     % Normalize the fft to the input tone and evaluate in dB


Power = abs(fftout.*conj(fftout));
Power_Sort = sort(Power(2:end/2),'descend');
Sig_Power = Power_Sort(1);
Harm_Power = sum(Power_Sort(2:end));
SNR_Sine = 10*log10(Sig_Power/Harm_Power)


figure(1)
subplot(211)
plot(f,s)
title('Sine Time and Frequency Resposne')
axis([0 100 -.5 .5])
subplot(212)
plot(f(1:(2^B)/2)/(2^B),fftoutdB(1:(2^B)/2));  % Plot the fft
xlabel('Normalized Frequency')
ylabel('Magnitude (dB)')

figure(2)




%%%%%%%% Sawtooth Ideal Time and Frequency Response  %%%%%%%%%%

B = 10;
Vref = 1;

s = ((sawtooth(2*pi*17/(2^B)*[0:((2^B)-1)]))/2);   % Create a sine wave with frequency in bin #17
f=(0:1:(2^B)-1)*(1);                           % Normalize the index values of the Sine wave  between 0 and 1
fftout = abs(fft((s)))/(2^B);                  % Take the B-point FFT
fftoutdB = 20*log10(fftout/(max(fftout)));     % Normalize the fft to the input tone and evaluate in dB

Power = abs(fftout.*conj(fftout));
Power_Sort = sort(Power(2:end/2),'descend');
Sig_Power = Power_Sort(1);
Harm_Power = sum(Power_Sort(2:end));
SNR_Saw = 10*log10(Sig_Power/Harm_Power)

subplot(211)
plot(f,s)
title('Sawtooth Time and Frequency Resposne')
axis([0 100 -.5 .5])
subplot(212)
plot(f(1:(2^B)/2)/(2^B),fftoutdB(1:(2^B)/2));  % Plot the fft
xlabel('Normalized Frequency')
ylabel('Magnitude (dB)')
figure(3)


%%%%%%%% Sinc Ideal Time and Frequency Response  %%%%%%%%%%

B = 10;
Vref = 1;

s = ((sinc(2*pi*17/(2^B)*[0:((2^B)-1)]))/2);   % Create a sine wave with frequency in bin #17
f=(0:1:(2^B)-1)*(1);                           % Normalize the index values of the Sine wave  between 0 and 1
fftout = abs(fft((s)))/(2^B);                  % Take the B-point FFT
fftoutdB = 20*log10(fftout/(max(fftout)));     % Normalize the fft to the input tone and evaluate in dB


subplot(211)
plot(f,s)
title('Sinc Time and Frequency Resposne')
axis([0 100 -.5 .5])
subplot(212)
plot(f(1:(2^B)/2)/(2^B),fftoutdB(1:(2^B)/2));  % Plot the fft
xlabel('Normalized Frequency')
ylabel('Magnitude (dB)')






















