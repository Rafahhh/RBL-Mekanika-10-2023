clc
close all
clear

sim = 10;
Ts = 0.01;

% Simulasi Jalan Berlubang/Terganggu

c = 0;
a1 = 0.02;
a2 = 0.03;

for i = 0:Ts:sim
    c = c+1;
    if i > 0 && i < 0.5
        ud(c) = a1*(1-cos(4*pi*i));
    elseif i > 2 && i < 2.5
        ud(c) = a2*(1-cos(4*pi*i));
    else
        ud(c) = 0;
    end
end

i = 0:Ts:sim;
plot(i,ud,"LineWidth",2)
xlabel('t'),ylabel('perpindahan (m)')

% Parameter
mb = 280;
mw = 45;
k1 = 17900;
k2 = 370000;    
b  = 1000;

% Matriks
A = [0 1 0 0; (-k1/mb) (-b/mb) (k1/mb) (b/mb); 0 0 0 1; (k1/mw) (b/mw) (-(k1+k2)/mw) (-b/mw)];
B = [0; 0; 0; (k2/mw)];
C = [1 0 0 0];
D = 0;

Gol = ss(A,B,C,D);

% Simulasi
tsim = 0:Ts:sim;
u    = ud;
x0   = [0,0,0,0];
y    = lsim(Gol,u,tsim,x0);

i=0:Ts:sim;
plot(i,y,'b',i,ud,'k','LineWidth',2)
legend('Sistem suspensi', "Gangguan jalan")
xlabel('Waktu (s)'), ylabel('Perpindahan (m)')
title("Badan Mobil")
