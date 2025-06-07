% tana: 17=1+8+8

function a2 = atan_fix_max(tana)
itr     = 19;
exp_x   = 18;
exp_a   = 12;

x     = floor(1*2^exp_x);

cfg_x_wid = 27;
if x >= 2^cfg_x_wid
	x = mod(x,2^cfg_x_wid);
elseif x >= 0
	x = x;
else
	fprintf('x < 0: %d\n',x);
end


tana2 = floor(tana * 2^(exp_x-8));

cfg_tana2_wid = 27;
if (tana2 >= 2^(cfg_tana2_wid-1)) || (tana2 < -2^(cfg_tana2_wid-1))
	tana2 = tana2-(floor((tana2-2^(cfg_tana2_wid-1))/2^cfg_tana2_wid)+1)*2^cfg_tana2_wid;
else
	tana2 = tana2;
end

a         = 0;

cfg_a_wid = 21;
if (a >= 2^(cfg_a_wid-1)) || (a < -2^(cfg_a_wid-1))
	a = a-(floor((a-2^(cfg_a_wid-1))/2^cfg_a_wid)+1)*2^cfg_a_wid;
else
	a = a;
end


for cnt = 0:itr-1
	tt   = round(atan(2^(-cnt))/(2*pi/1024) * 2^exp_a);
	
	cfg_tt_wid = 20;
	if tt >= 2^cfg_tt_wid
		tt = mod(tt,2^cfg_tt_wid);
	elseif tt >= 0
		tt = tt;
	else
		fprintf('tt < 0: %d\n',tt);
	end
	
	tmp1 = floor(2^(-cnt)*tana2);
	
	cfg_tmp1_wid = 27;
	if (tmp1 >= 2^(cfg_tmp1_wid-1)) || (tmp1 < -2^(cfg_tmp1_wid-1))
		tmp1 = tmp1-(floor((tmp1-2^(cfg_tmp1_wid-1))/2^cfg_tmp1_wid)+1)*2^cfg_tmp1_wid;
	else
		tmp1 = tmp1;
	end
	
	tmp2 = floor(2^(-cnt)*x);
	
	cfg_tmp2_wid = 27;
	if tmp2 >= 2^cfg_tmp2_wid
		tmp2 = mod(tmp2,2^cfg_tmp2_wid);
	elseif tmp2 >= 0
		tmp2 = tmp2;
	else
		fprintf('tmp2 < 0: %d\n',tmp2);
	end
	
	if (tana2 >= 0)
		x     = x     + tmp1;
		tana2 = tana2 - tmp2;
		a     = a     + tt;
	else
		x     = x     - tmp1;
		tana2 = tana2 + tmp2;
		a     = a     - tt;
	end
	
	if x >= 2^cfg_x_wid
		x = mod(x,2^cfg_x_wid);
	elseif x >= 0
		x = x;
	else
		fprintf('x < 0: %d\n',x);
	end
	
	if (tana2 >= 2^(cfg_tana2_wid-1)) || (tana2 < -2^(cfg_tana2_wid-1))
		tana2 = tana2-(floor((tana2-2^(cfg_tana2_wid-1))/2^cfg_tana2_wid)+1)*2^cfg_tana2_wid;
	else
		tana2 = tana2;
	end
	
	if (a >= 2^(cfg_a_wid-1)) || (a < -2^(cfg_a_wid-1))
		a = a-(floor((a-2^(cfg_a_wid-1))/2^cfg_a_wid)+1)*2^cfg_a_wid;
	else
		a = a;
	end
end

a2 = round(a/2^exp_a);

cfg_a2_wid = 9;
if (a2 >= 2^(cfg_a2_wid-1)) || (a2 < -2^(cfg_a2_wid-1))
	a2 = a2-(floor((a2-2^(cfg_a2_wid-1))/2^cfg_a2_wid)+1)*2^cfg_a2_wid;
else
	a2 = a2;
end




