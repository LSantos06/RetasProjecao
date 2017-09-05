% Universidade de Bras�lia
% Departamento de Ci�ncia da Computa��o 
% Projeto Demonstrativo 1
% Principios de Visao Computacional, Turma A, 2/2017
% Filipe Teixeira (14/0139486) & Lucas Santos(14/0151010)
% Objetivo: O projeto consiste em calcular pontos de fuga e verificar rela��es entre objetos nas imagens. 

%% Loop

imgs = cell(1,5);
for i=1:5 
    %% Prepara��o

    % Abrindo imagem, obtendo dimens�es e exibindo-a
    fprintf('\nimg%d.jpeg:\n',i);
    imgs{i} = imread(sprintf('Imagens/img%d.jpeg',i));
    imgs_size = size(imgs{i});
    figure(1), imshow(imgs{i}), hold on;

    %% Pontos de Fuga e Linha do Horizonte

    % Prepando vetores para acomodares as coordenadas dos pontos de fuga
    pf_x = zeros(2,1);
    pf_y = zeros(2,1);

    % Obtendo pontos de topo e base da altura da pessoa 1 (altura conhecida)
    title('Marque (nessa ordem) o topo e a base da altura (Pessoa 1 - altura conhecida) e pressione enter'), [p1_x,p1_y] = getpts(figure(1));
    plot(p1_x(1),p1_y(1), 'v', 'LineWidth', 2, 'Color', 'White'); % Topo
    plot(p1_x(2),p1_y(2), '^', 'LineWidth', 2, 'Color', 'Cyan'); % Base
    h1 = 1.50;

    % Obtendo pontos de topo e base da altura da pessoa 2 (altura desconhecida)
    title('Marque (nessa ordem) o topo e a base da altura (Pessoa 2 - altura desconhecida) e pressione enter'), [p2_x,p2_y] = getpts(figure(1));
    plot(p2_x(1),p2_y(1), 'v', 'LineWidth', 2, 'Color', 'Yellow'); % Topo
    plot(p2_x(2),p2_y(2), '^', 'LineWidth', 2, 'Color', 'Cyan'); % Base

    % Obtendo Reta 1 do primeiro par de retas paralelas
    title('Indique um segmento (Reta 1) do primeiro par de paralelas - marque dois pontos e pressione enter'), [r_x,r_y] = getline(figure(1));
    % C�lculo dos coeficientes m e n em y = m*x+n
    m11 = (r_y(2)-r_y(1))/(r_x(2)-r_x(1)); % m = (y2-y1)/(x2-x1)
    n11 = r_y(1)-m11*r_x(1); % n = y1-m*x1 = y2-m*x2
    % Plot da reta
    r_x = [0,imgs_size(2)];
    r_y = m11*r_x+n11;
    line(r_x,r_y, 'LineWidth', 2, 'Color', 'Red');

    % Obtendo Reta 2 do primeiro par de retas paralelas
    title('Indique um segmento (Reta 2) do primeiro par de paralelas - marque dois pontos e pressione enter'), [r_x,r_y] = getline(figure(1));
    % C�lculo dos coeficientes m e n em y = m*x+n
    m12 = (r_y(2)-r_y(1))/(r_x(2)-r_x(1)); % m = (y2-y1)/(x2-x1)
    n12 = r_y(1)-m12*r_x(1); % n = y1-m*x1 = y2-m*x2
    % Plot da reta
    r_x = [0,imgs_size(2)];
    r_y = m12*r_x+n12;
    line(r_x,r_y, 'LineWidth', 2, 'Color', 'Red');

    % C�lculo e plot do ponto de fuga do primeiro par de retas paralelas
    pf_x(1) = (n12-n11)/(m11-m12); % x = (n2-n1)/(m1-m2)
    pf_y(1) = m11*pf_x(1)+n11; % y = m1*x+n1 = m2*x+n2
    plot(pf_x(1),pf_y(1), 'x', 'LineWidth', 2, 'Color', 'Red');

    % Obtendo Reta 1 do segundo par de retas paralelas
    title('Indique um segmento (Reta 1) do segundo par de paralelas  - marque dois pontos e pressione enter'), [r_x,r_y] = getline(figure(1));
    % C�lculo dos coeficientes m e n em y = m*x+n
    m21 = (r_y(2)-r_y(1))/(r_x(2)-r_x(1)); % m = (y2-y1)/(x2-x1)
    n21 = r_y(1)-m21*r_x(1); % n = y1-m*x1 = y2-m*x2
    % Plot da reta
    r_x = [0,imgs_size(2)];
    r_y = m21*r_x+n21;
    line(r_x,r_y, 'LineWidth', 2, 'Color', 'Green');

    % Obtendo Reta 2 do segundo par de retas paralelas
    title('Indique um segmento (Reta 2) do segundo par de paralelas - marque dois pontos e pressione enter'), [r_x,r_y] = getline(figure(1));
    % C�lculo dos coeficientes m e n em y = m*x+n
    m22 = (r_y(2)-r_y(1))/(r_x(2)-r_x(1)); % m = (y2-y1)/(x2-x1)
    n22 = r_y(1)-m22*r_x(1); % n = y1-m*x1 = y2-m*x2
    % Plot da reta
    r_x = [0,imgs_size(2)];
    r_y = m22*r_x+n22;
    line(r_x,r_y, 'LineWidth', 2, 'Color', 'Green');

    % C�lculo e plot do ponto de fuga do segundo par de retas paralelas
    pf_x(2) = (n22-n21)/(m21-m22); % x = (n2-n1)/(m1-m2)
    pf_y(2) = m21*pf_x(2)+n21; % y = m1*x+n1 = m2*x+n2
    plot(pf_x(2),pf_y(2), 'x', 'LineWidth', 2, 'Color', 'Green');

    % Parte autom�tica do programa
    title('C�lculo dos pontos (em vermelho e em verde) e reta de fuga (em magenta),')

    % Obtendo linha de fuga/linha do horizonte
    % C�lculo dos coeficientes m e n em y = m*x+n
    lf_m = (pf_y(2)-pf_y(1))/(pf_x(2)-pf_x(1)); % m = (y2-y1)/(x2-x1)
    lf_n = pf_y(1)-lf_m*pf_x(1); % n = y1-m*x1 = y2-m*x2
    % Plot da linha
    r_x = [0,imgs_size(2)];
    r_y = lf_m*r_x+lf_n;
    line(r_x,r_y,'LineStyle',':', 'LineWidth', 2, 'Color', 'Magenta');
    
    %
    print(sprintf('Imagens Fuga Manual/img%d.jpeg',i),'-dpng');

    %% Matriz de rotacao

    % Matriz relativa a camera do iPhone 6
    K = [1229 0 imgs_size(2)/2;
         0 1153 imgs_size(1)/2;
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
    fprintf('\tR = \n'); disp(R);
    figure(2), plot3(r1,r2,r3), title('Eixos 3D da camera');
    
    %% C�lculo da altura da pessoa de interesse


    % C�lculo da reta que passa na base das pessoas a serem comparadas
    % C�lculo dos coeficientes m e n em y = m*x+n
    pb_m = (p2_y(2)-p1_y(2))/(p2_x(2)-p1_x(2)); % m = (y2-y1)/(x2-x1)
    pb_n = p1_y(2)-pb_m*p1_x(2); % n = y1-m*x1 = y2-m*x2
    % Plot da reta
    %r_x = [0,img_size(2)];
    %r_y = pb_m*r_x+pb_n;
    %figure(1), line(r_x,r_y,'LineStyle',':', 'LineWidth', 2, 'Color', 'Cyan');

    % C�lculo e plot do ponto v de cruzamento entre a linha de fuga e reta base
    v_x = (lf_n-pb_n)/(pb_m-lf_m); % x = (n2-n1)/(m1-m2)
    v_y = pb_m*v_x+pb_n; % y = m1*x+n1 = m2*x+n2
    %plot(v_x,v_y, 'x', 'LineWidth', 2, 'Color', 'Blue');

    % C�lculo e plot do ponto vz acima da pessoa de altura conhecida (p1) para
    % o qual z tende ao infinito
    vz_x = p1_x(1);
    vz_y = 1;
    %plot(vz_x,vz_y, 'v', 'LineWidth', 2, 'Color', 'Black');

    % C�lculo da reta pt que passa no topo da pessoa de altura desconhecida (p2)
    % e pelo ponto v
    % C�lculo dos coeficientes m e n em y = m*x+n
    pt_m = (v_y-p2_y(1))/(v_x-p2_x(1)); % m = (y2-y1)/(x2-x1)
    pt_n = v_y-pt_m*v_x; % n = y1-m*x1 = y2-m*x2
    % Plot da reta
    %r_x = [0,img_size(2)];
    %r_y = pt_m*r_x+pt_n;
    %line(r_x,r_y,'LineStyle',':', 'LineWidth', 2, 'Color', 'Yellow');

    % C�lculo e plot do ponto p21 pertencente � reta pt logo acima da pessoa de
    % altura conhecida
    p21_x = p1_x(1);
    p21_y = pt_m*p21_x+pt_n;
    %plot(p21_x,p21_y, 'v', 'LineWidth', 2, 'Color', 'Yellow');

    %% C�lculo final da altura desejada
    h2 = h1*(((norm([p21_x,p21_y]-[p1_x(2),p1_y(2)]))*(norm([vz_x,vz_y]-[p1_x(1),p1_y(1)])))/(((norm([p1_x(1),p1_y(1)]-[p1_x(2),p1_y(2)]))*(norm([vz_x,vz_y]-[p21_x,p21_y])))));
    fprintf('\th1(conhecida) = %f, h2(calculada) = %f\n',h1,h2,i);
    pause;
end