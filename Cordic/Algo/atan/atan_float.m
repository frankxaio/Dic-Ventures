function a = atan_float(tana)
itr = 10;
x = 1;
a = 0;

for cnt = 0:itr-1
	tt   = atan(2^(-cnt));
	tmp1 = 2^(-cnt)*tana;
	tmp2 = 2^(-cnt)*x;
	
	if (tana >= 0)
		x    = x     + tmp1;
		tana = tana  - tmp2;
		a    = a     + tt;
	else
		x    = x     - tmp1;
		tana = tana  + tmp2; 
		a    = a     - tt;
	end
end


