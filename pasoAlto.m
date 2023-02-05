function [ba,aa] = pasoAlto(gain,fc, BW)
%% constantes
fs = 48000;
w0 = 2*pi*fc/fs;
alpha = sin(w0) * sinh( log(2)/2 * BW * w0/sin(w0) );
A = 10^(gain/40);
%% Calculo coeficientes
b0 = A*((A+1) + (A-1)*cos(w0)+2*sqrt(A)*alpha);
b1 = -2*A*((A-1) + (A+1)*cos(w0));
b2 = A*((A+1) + (A-1)*cos(w0) - 2*sqrt(A)*alpha);
a0 = ((A+1)   - (A-1)*cos(w0) + 2*sqrt(A)*alpha);
a1 = 2*((A-1) - (A+1)*cos(w0));
a2 = (A+1)   -   (A-1)*cos(w0) - 2*sqrt(A)*alpha;
%% Sistema coeficientes
aa = [a0,a1,a2]'; 
ba = [b0,b1,b2]';
end
