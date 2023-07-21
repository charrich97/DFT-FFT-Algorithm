% benchmarking script for myDFT, mlfft, and myFFT
% GEB, October 2022
x = [1:1024];       % test data
N=1024;             % length of DFT, FFT
ntimes = 10;      % number of times to compute DFT/FFT

profile on

% myDFT
for time = 1:ntimes
    X = myDFT(x,N);
end

% myFFT
for time = 1:ntimes
    X = myFFT_273(x,N);
end

% MATLAB FFT
for time = 1:ntimes
    X = mlfft(x,N);
end

profile off
profile viewer
%-------------------------
function X = mlfft(x,N)
X = fft(x,N);
end
