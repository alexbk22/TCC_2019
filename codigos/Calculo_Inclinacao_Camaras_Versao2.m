%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% CALCULOS DAS MEDIDAS ANGULARES TETA1 E TETA2, E ASSIM POSSIBILITAR A %%%%%
%%%%%%%%%%%%% DETERMINACAO DO ANGULO DE INCLINACAO (i) DAS CAMARAS %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
clc

%% DADOS CONHECIDOS
Sb = 0.15;     %Percentagem de sobreposicao
Delta = 0.07;  %Distancia (metros) entre CP1 e CP2
Z = 80;        %Altura de voo (metros)
f = 0.0077;    %Distancia focal (metros)
L = 0.0088;    %Menor dimensao do CMOS (metros)

%% CALCULO DO ANGULO DE ABERTURA DA CAMARA (lado menor)
alpha = 2*atand(L/(2*f));   %Valor em graus decimais

%% EQUACAO PARA DETERMINACAO DO ANGULO T2
%% atand((2*Z*tand(T2)+Delta)/(Sb*Z)-tand(T2))+T2-alpha=0

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% DETERMINACAO DO ANGULO T2 %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%% METODO DAS BISSECCOES SUCESSIVAS %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% INICIALIZACAO (Definicao do intervalo de busca)
a = 0;       %Limite esquerdo
b = 80;      %Limite direito
p = 0.0001;  %Criterio de parada

itera = -1;  %Contar o numero de iteracoes

%% ITERACOES
fprintf('#ITERACOES:\n');
do
  itera += 1;
  % Calcular f(a) e f(b)
  fa = atand((2*Z*tand(a)+Delta)/(Sb*Z)-tand(a))+a-alpha;  %Resultado para f(a)
  fb = atand((2*Z*tand(b)+Delta)/(Sb*Z)-tand(b))+b-alpha;  %Resultado para f(b)
  
  % Verificar se o intervalo contem a raiz da equacao
  if (fa*fb > 0)  
    fprintf("A raiz nao esta nesse intervalo!\n");
		break;
  end
  
  % Dividir o intervalo ao meio
  Xn = (a+b)/2;
  
  % Calcular f(Xn)
  fXn = atand((2*Z*tand(Xn)+Delta)/(Sb*Z)-tand(Xn))+Xn-alpha;
  
  % Imprimir resultados parciais para fins de controle
  fprintf('iteracao=%.0f\ta=%.6f\tb=%.6f\tXn=%.6f\tfXn=%.8f\t\n',itera,a,b,Xn,fXn);
  
  % Verificar o subintervalo onde a função tem sinais contrários nos extremos
  if (fXn*fa < 0)
    b=Xn; % b assume o valor de Xn
  else
    a=Xn; % a assume o valor de Xn
  end
  
until (abs(fXn) <= p)

%% RESULTADO %%
T2 = Xn;   % Valor do angulo Teta2

%% CALCULO DE TETA1 (T1+T2=alpha)
T1 = alpha - T2;

fprintf('\n#RESULTADO:\n');
fprintf('T1= %.4f\n',T1);
fprintf('T2= %.4f\n',T2);
fprintf('Alpha= %.4f\n',alpha);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%% CALCULAR O ANGULO DE INCLINACAO (i) %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

B = alpha/2-T2; %Angulo B obtido pela soma dos angulos internos do triangulo
i = B;          %Angulo de inclinacao (i)

fprintf('Inclinacao= %.4f\n',i);















