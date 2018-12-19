function convTi = convolve_Ti(Tis)
    %% Convolution of [Ti(i) 1] implemented by using fft and ifft %%
    
    L = length(Tis);
    
    denums = [Tis.*ones(1,L); ones(1,L)];  % [Ti(1) Ti(2) ...] ; [1 1 ...]
    n=(size(denums,1)-1)*size(denums,2)+1;
    convTi = ifft(prod(fft(denums,n),2),'symmetric')';
    