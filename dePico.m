function [bp,ap] = dePico(gain, fc , BW)      %% ap = Coeficientes "a"(peakingEQ)  & bp = Coeficientes "b"(peakingEQ)
%% constantes
fs = 48000;
w0 = 2*pi*fc/fs;
alpha = (sin(w0)*sinh(log(2)/2)*BW*w0/sin(w0));
A = 10^(gain/40);
%% coeficientes
b0 = 1 + alpha*A;
b1 = -2*cos(w0);
b2 = 1-alpha*A;
a0 = 1+alpha/A;
a1 = -2*cos(w0);
a2 = 1-alpha/A;
%% Sistema coeficientes
bp = [b0 b1 b2]';
ap = [a0 a1 a2]';

end

