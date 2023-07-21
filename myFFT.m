%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Filename    : my_FFT_273.m
%   Author      : Chuck Richardson
%   UnityID     : cdricha5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function X = myFFT_273(x,N)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Calculate the Length of the Series
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    L=length(x);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Truncate/Zero-Pad
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if(N<L)                                                                 
        xin=x(1:N);                                                               
    elseif(N>=L)                                                             
        xin=[x, zeros(1,N-L)];                                                     
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Compute Number of Stages
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    NUM_STAGES=log2(N);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Reverse Order for Butterfly
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    xin=bitrevorder(xin);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Pre-Compute the Twiddle Factors
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Twiddle_Factors = zeros(0,N/2-1); %Pre-Allocate Twiddle Factors
    for n = 0:(N/2-1)
        Twiddle_Factors(n+1)=cos(2*pi/N*n)-1i*sin(2*pi/N*n);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Initialize Butterfly Arrays/Output Array
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Input_Butterfly = zeros(1,2);
    Get_Butterfly   = zeros(1,2);
    X               = zeros(1,N);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Going through N-Point DFTs
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for stages = 1:NUM_STAGES
        N_Stage = 2^stages;
        N_Stage_Div_2 = N_Stage/2;
        Twiddle_Factor = Twiddle_Factors(1:N/N_Stage:(N/2));
        N_minus_Nstage = N-N_Stage;
        for k = 0:N_Stage:N_minus_Nstage
            for n=0:N_Stage_Div_2 -1
                Input_Butterfly          = [xin(n+k+1) xin(n+k+N_Stage_Div_2+1)];
                Get_Butterfly            = butterfly(Input_Butterfly, Twiddle_Factor(n+1));
                xin(n+k+1)                = Get_Butterfly(1);
                xin(n+k+N_Stage_Div_2+1)  = Get_Butterfly(2);
            end
        end      
    end
    X=xin;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Butterfly Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function bout = butterfly(bin, twiddle)
    bout(1) =   bin(1) + (bin(2).*twiddle);
    bout(2) =   bin(1) - (bin(2).*twiddle);
end
