% TDS�-G33
% Laboratorio: Trabajo final
%
% alumno1: carlos.chinchilla.fiter@alumnos.upm.es     
% alumno2: javier.ariza.rosado@alumnos.upm.es    
% alumno3: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
%
%% Un poco de limpieza
clear; clc; close all;
%% Sistema a ecualizar
[Z, P, K] = room('carlos.chinchilla.fiter@alumnos.upm.es','javier.ariza.rosado@alumnos.upm.es');
[B, A] = zp2tf(Z, P, K);
[H, w] = freqz(B, A, 4096);
mH = 20*log10(abs(H));
plot(w, mH);
title('Módulo de la respuesta en frecuencia de la sala');
xlabel('\omega'); ylabel('dB'); grid on;
axis([0, pi, min(mH)-1, max(mH)+1]);
%% Señal de prueba
fs = 48e3; % frecuencia de muestreo
f0 = 20; % frecuencia inicial
f1 = 20e3; % frecuencia final
t1 = 10; % tiempo final
t = 0:1/fs:t1; % vector de tiempos
x = chirp(t, f0, t1, f1, 'logarithmic');
%% Filtro repisa paso bajo [Ganancia, frecuencia de corte, ancho de banda]
[bb, ab]=pasoBajo(13.2, 10000, 2);     %% bb = coeficientes "b" del paso bajo, igual con "ab"
[Hb,w]=freqz(bb, ab,4096);
mHpasobajo=20*log10(abs(Hb));
%% Filtro pico 1 [Ganancia, frecuencia central y ancho de banda]
[bp1, ap1]=dePico(1, 4000, 1);         %% bp1 = coeficientes "b" del filtro peaking1
[Hp1,w]=freqz(bp1, ap1,4096);
mHpico1=20*log10(abs(Hp1));
%% Filtro pico 2 [Ganancia, frecuencia central y ancho de banda]
[bp2, ap2]=dePico(-2, 15000, 1);       %% bp2 = coeficientes "b" del filtro peaking2
[Hp2,w]=freqz(bp2, ap2,4096);
mHpico2=20*log10(abs(Hp2));
%% Filtro pico 3 [Ganancia, frecuencia central y ancho de banda]
[bp3, ap3]=dePico(-1.5, 10000, 1);     %% bp3 = coeficientes "b" del filtro peaking3
[Hp3,w]=freqz(bp3, ap3,4096);
mHpico3=20*log10(abs(Hp3));
%% Filtro repisa paso alto  [Ganancia, frecuencia de corte, ancho de banda]
[ba, aa]=pasoAlto(-2, 10000, 1.5);      %% ba = coeficientes "b" del paso alto, igual con "aa"
[Ha,w]=freqz(ba, aa,4096);
mHpasoalto=20*log10(abs(Ha));
%% Sistema global
mHtotal = mHpasobajo + mHpico1 + mHpico2 + mHpico3 + mHpasoalto;
%% Representación gráfica
mHglobal = mH + mHtotal;
figure
title('Respuesta en frecuencia de la sala ecualizada');
ejeFrec = (w*fs)/(2*pi);
semilogx(ejeFrec,mHglobal);
xlabel('Hz'); ylabel('dB'); 
grid on;
axis([20 20000 min(mHglobal)-1 max(mHglobal)+1]); % Representamos de 20Hz a 20KHz, los ejes se calculan con los maximos de la funcion
grid on;


