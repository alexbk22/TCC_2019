clear
clc

%Verificar o comportamento do sistema em relacao a altura de voo
	T1=53.3069;
	T2=6.1829;
	Delta=0.07;

	ac=1; %acrescimos
	vf=100; %valor final
	ne=vf/ac+1; %numero de elementos
	Z=zeros(2,ne);
	Z(1,1:ne)=[0:ac:vf];
  Dif=zeros(2,ne);
  
	for i=2:ne
		d1=Z(1,i)*tand(T1);
		d2=Z(1,i)*tand(T2);
		d=d1+d2;
		s=2*d2+Delta;
		Sb=s/d;
		Z(2,i)=Sb;
    %fprintf("%\d: \t%\d\n",Z(1,i),Sb);
    Dif(1:2,i)=[i,Sb-Z(2,i-1)];
	end
  
  figure (1)
	plot(Z(1,2:ne),Z(2,2:ne));
  
  figure (2)
  plot(Dif(1,2:ne),Dif(2,2:ne));
