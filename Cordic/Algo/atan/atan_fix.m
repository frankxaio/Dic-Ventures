% tana: 17=1+8+8

function a2 = atan_fix(tana)
itr     = 19;
exp_x   = 18;
exp_a   = 12;

x = floor(1*2^exp_x);
tana2 = floor(tana * 2^(exp_x-8));
a = 0;	

for cnt = 0:itr-1 	
	tt   = round(atan(2^(-cnt))/(2*pi/1024) * 2^exp_a);
	tmp1 = floor(2^(-cnt)*tana2);
	tmp2 = floor(2^(-cnt)*x);
	
	if (tana2 >= 0)
		x     = x     + tmp1;
		tana2 = tana2 - tmp2;
		a     = a     + tt;
	else
		x     = x     - tmp1;
		tana2 = tana2 + tmp2; 
		a     = a     - tt;
	end
end

a2 = round(a/2^exp_a);
