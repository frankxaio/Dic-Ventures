% tana: 17=1+8+8

function a2 = atan_fix2(tana)
%x: 27=0+9+18
x     = 2^18;

%tana2: 27=1+8+18
tana2 = floor(tana * 2^10);

%a: 21=1+8+12
a     = 0;

%tt: 20=0+8+12
tt = [524288,309505,163534,83012,41667,20854,10430,5215,2608,1304,652,326,163,81,41,20,10,5,3];

for cnt = 0:18
    %tmp1: 27=1+8+18
	tmp1 = floor(2^(-cnt)*tana2);

	%tmp2: 27=0+9+18
	tmp2 = floor(2^(-cnt)*x);
	
	if (tana2 >= 0)
		x     = x     + tmp1;
		tana2 = tana2 - tmp2;
		a     = a     + tt(cnt+1);
	else
		x     = x     - tmp1;
		tana2 = tana2 + tmp2; 
		a     = a     - tt(cnt+1);
	end
end

%a2: 9=1+8+0
a2 = round(a/2^12);




