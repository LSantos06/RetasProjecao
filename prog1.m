% Projeto Demonstrativo 1
% Principios de Visao Computacional - UnB 2/2017
% Filipe Teixeira & Lucas Santos

% Abrindo imagem, obtendo dimensões e exibindo-a
img = imread('Imagens/exemplo.png');
img_size = size(img);
figure(1), imshow(img), hold on;

%% Pontos de Fuga
% Prepando vetores para acomodares as coordenadas dos pontos de fuga
pf_x = zeros(2,1);
pf_y = zeros(2,1);

% Obtendo pontos de topo e base da altura da pessoa 1 (altura conhecida)
title('Marque (nessa ordem) o topo e a base da altura (Pessoa 1 - altura conhecida) e pressione enter'), [p1_x,p1_y] = getpts(figure(1));
plot(p1_x(1),p1_y(1), 'x', 'LineWidth', 2, 'Color', 'Yellow');
plot(p1_x(2),p1_y(2), 'x', 'LineWidth', 2, 'Color', 'Cyan');

% Obtendo pontos de topo e base da altura da pessoa 2 (altura desconhecida)
title('Marque (nessa ordem) o topo e a base da altura (Pessoa 2 - altura desconhecida) e pressione enter'), [p2_x,p2_y] = getpts(figure(1));
plot(p2_x(1),p2_y(1), 'x', 'LineWidth', 2, 'Color', 'Yellow');
plot(p2_x(2),p2_y(2), 'x', 'LineWidth', 2, 'Color', 'Cyan');

% Obtendo Reta 1 do primeiro par de retas paralelas
title('Indique um segmento (Reta 1) do primeiro par de paralelas - marque dois pontos e pressione enter'), [r_x,r_y] = getline(figure(1));
% Cálculo dos coeficientes m e n em y = m*x+n
m11 = (r_y(2)-r_y(1))/(r_x(2)-r_x(1)); % m = (y2-y1)/(x2-x1)
n11 = r_y(1)-m11*r_x(1); % n = y1-m*x1 = y2-m*x2
% Plot da reta
r_x = [0,img_size(2)];
r_y = m11*r_x+n11;
line(r_x,r_y, 'LineWidth', 2, 'Color', 'Red');

% Obtendo Reta 2 do primeiro par de retas paralelas
title('Indique um segmento (Reta 2) do primeiro par de paralelas - marque dois pontos e pressione enter'), [r_x,r_y] = getline(figure(1));
% Cálculo dos coeficientes m e n em y = m*x+n
m12 = (r_y(2)-r_y(1))/(r_x(2)-r_x(1)); % m = (y2-y1)/(x2-x1)
n12 = r_y(1)-m12*r_x(1); % n = y1-m*x1 = y2-m*x2
% Plot da reta
r_x = [0,img_size(2)];
r_y = m12*r_x+n12;
line(r_x,r_y, 'LineWidth', 2, 'Color', 'Red');

% Cálculo e plot do ponto de fuga do primeiro par de retas paralelas
pf_x(1) = (n12-n11)/(m11-m12); % x = (n2-n1)/(m1-m2)
pf_y(1) = m11*pf_x(1)+n11; % y = m1*x+n1 = m2*x+n2
plot(pf_x(1),pf_y(1), 'x', 'LineWidth', 2, 'Color', 'Magenta');

% Obtendo Reta 1 do segundo par de retas paralelas
title('Indique um segmento (Reta 1) do segundo par de paralelas  - marque dois pontos e pressione enter'), [r_x,r_y] = getline(figure(1));
% Cálculo dos coeficientes m e n em y = m*x+n
m21 = (r_y(2)-r_y(1))/(r_x(2)-r_x(1)); % m = (y2-y1)/(x2-x1)
n21 = r_y(1)-m21*r_x(1); % n = y1-m*x1 = y2-m*x2
% Plot da reta
r_x = [0,img_size(2)];
r_y = m21*r_x+n21;
line(r_x,r_y, 'LineWidth', 2, 'Color', 'Green');

% Obtendo Reta 2 do segundo par de retas paralelas
title('Indique um segmento (Reta 2) do segundo par de paralelas - marque dois pontos e pressione enter'), [r_x,r_y] = getline(figure(1));
% Cálculo dos coeficientes m e n em y = m*x+n
m22 = (r_y(2)-r_y(1))/(r_x(2)-r_x(1)); % m = (y2-y1)/(x2-x1)
n22 = r_y(1)-m22*r_x(1); % n = y1-m*x1 = y2-m*x2
% Plot da reta
r_x = [0,img_size(2)];
r_y = m22*r_x+n22;
line(r_x,r_y, 'LineWidth', 2, 'Color', 'Green');

% Cálculo e plot do ponto de fuga do segundo par de retas paralelas
pf_x(2) = (n22-n21)/(m21-m22) % x = (n2-n1)/(m1-m2)
pf_y(2) = m21*pf_x(2)+n21 % y = m1*x+n1 = m2*x+n2
plot(pf_x(2),pf_y(2), 'x', 'LineWidth', 2, 'Color', 'Magenta');

% Obtendo linha de fuga/linha do horizonte
% Cálculo dos coeficientes m e n em y = m*x+n
lf_m = (pf_y(2)-pf_y(1))/(pf_x(2)-pf_x(1)); % m = (y2-y1)/(x2-x1)
lf_n = pf_y(1)-lf_m*pf_x(1); % n = y1-m*x1 = y2-m*x2
% Plot da linha
r_x = [0,img_size(2)];
r_y = lf_m*r_x+lf_n;
line(r_x,r_y,'LineStyle',':', 'LineWidth', 2, 'Color', 'Magenta');

% Cálculo da reta que passa na base das pessoas a serem comparadas
% Cálculo dos coeficientes m e n em y = m*x+n
p_m = (p2_y(2)-p1_y(2))/(p2_x(2)-p1_x(2)); % m = (y2-y1)/(x2-x1)
p_n = p2_y(2)-p_m*p2_x(2); % n = y1-m*x1 = y2-m*x2
% Plot da linha
r_x = [0,img_size(2)];
r_y = p_m*r_x+p_n;
line(r_x,r_y,'LineStyle',':', 'LineWidth', 2, 'Color', 'Cyan');

% Cálculo e plot do ponto v de cruzamento entre a linha de fuga e reta base
v_x = (lf_n-p_n)/(p_m-lf_m) % x = (n2-n1)/(m1-m2)
v_y = p_m*v_x+p_n; % y = m1*x+n1 = m2*x+n2
plot(v_x,v_y, 'x', 'LineWidth', 2, 'Color', 'Blue');

%% Matriz de rotacao

% Matriz relativa a camera do iPhone 6
K = [1229 0 size(img,2)/2;
     0 1153 size(img,1)/2;
     0 0 1];

% Pontos de fuga
pf_1 = [pf_x(1); 
        pf_y(1); 
        1];
pf_2 = [pf_x(2); 
        pf_y(2); 
        1];

% Dimensoes 3D (r1, r2 e r3)
r1 = (K\pf_1)/(norm(K\pf_1));
r2 = (K\pf_2)/(norm(K\pf_2));
r3 = cross(r1,r2);
R = [r1 r2 r3];
fprintf("R = \n"); disp(R);
figure(2), title("Eixos 3D da camera"), plot3(r1,r2,r3);
