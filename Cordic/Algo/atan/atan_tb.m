clc;
clear;
close all;

% tana: 17=1+8+8
% a:    9=1+8+0


%% 已知一個正切值(tan(x))，求角度(x)
delt = 2^-8;
delt_a = 2*pi/1024;
tana = [-256:delt:256-delt];
len = length(tana);
a = zeros(1,len);

for cnt = 1:len
% 	a(cnt) = atan_float(tana(cnt));
%	a_fix(cnt) = atan_fix(round(tana(cnt)/delt));a(cnt) = a_fix(cnt) * delt_a;
 	a_fix(cnt) = atan_fix_max(round(tana(cnt)/delt));a(cnt) = a_fix(cnt) * delt_a;
% 	a_fix(cnt) = atan_fix2(round(tana(cnt)/delt));a(cnt) = a_fix(cnt) * delt_a;
end

figure(1);plot(a*180/pi, tana);grid on;
figure(2);plot(tana, a); grid on;

%% evaluate
a_real = atan(tana);
err_a = abs(a_real - a);
figure(3); plot(tana,err_a);grid on;

max(err_a)















