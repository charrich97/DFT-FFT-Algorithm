% script to verify myFFT by comparing to MATLAB fft
% GEB, October 2022
x = [1:256];

N = 8
err1 = sum(abs( fft(x,N) - myDFT(x,N) ))
err2 = sum(abs( fft(x,N) - myFFT_273(x,N) ))

N = 256
err1 = sum(abs( fft(x,N) - myDFT(x,N) ))
err2 = sum(abs( fft(x,N) - myFFT_273(x,N) ))

N=16
x = ones(1,N);
X = myFFT_273(x,N);
X = fftshift(X);
xlist = [-N/2:N/2-1]/N;
plot(xlist,abs(X),'-o')
xlabel('f (cycles/sample)')
ylabel('magnitude FFT')

