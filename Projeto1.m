% Projeto 1
% Principios de Visao Computacional - UnB 2/2017
% Filipe Teixeira & Lucas Santos

imagens = cell(1,5);
for i=1:1
    % Salvando a imagem como variavel
    imagens{i} = imread(sprintf('Imagens/%d.jpeg',i));
    % Pegando os pontos da imagem
    figure(1), imshow(imagens{i}), title('Selecione os pontos paralelos e aperte ENTER'), hold on;
    [x, y] = getpts(figure(1));
    %%%% Plotando as retas
    %% Reta 1
    % Limites da janela de plot
    xlims = xlim(gca);
    ylims = ylim(gca);
    % Equacao de reta y = a*x + b
    a = (y(2)-y(1)) / (x(2)-x(1));
    b = y(1)-a*x(1);
    % Plot da linha na janela de plot
    [linha_y] = xlims*a+b;
    line( xlims, linha_y, 'LineWidth', 2, 'Color', 'red' );
    %% Reta 2
    % Equacao de reta y = a*x + b
    a = (y(3)-y(1)) / (x(3)-x(1));
    b = y(1)-a*x(1);
    % Plot da linha na janela de plot
    [linha_y] = xlims*a+b;
    line( xlims, linha_y, 'LineWidth', 2, 'Color', 'red' ); 
    %% Reta 3
    % Equacao de reta y = a*x + b
    a = (y(4)-y(2)) / (x(4)-x(2));
    b = y(2)-a*x(2);
    % Plot da linha na janela de plot
    [linha_y] = xlims*a+b;
    line( xlims, linha_y, 'LineWidth', 2, 'Color', 'red' ); 
    %% Reta 4
    % Equacao de reta y = a*x + b
    a = (y(4)-y(3)) / (x(4)-x(3));
    b = y(3)-a*x(3);
    % Plot da linha na janela de plot
    [linha_y] = xlims*a+b;
    line( xlims, linha_y, 'LineWidth', 2, 'Color', 'red' );
    pause;
    % Salvando a imagem final
    print(sprintf('Imagens Fuga Manual/%d.jpeg',i),'-dpng');
end