% Deteccao de Pontos de Fuga
% Principios de Visao Computacional - UnB 2/2017
% Filipe Teixeira & Lucas Santos

% Salvando a imagem
imagens = cell(1,5);
for i=1:5
    imagens{i}=imread(sprintf('Imagens/%d.jpeg',i));
    % Convertendo imagem para tons de cinza
    imagem_cinza = rgb2gray(imagens{i}); 
    figure(1), imshow(imagem_cinza), title('Imagem em escala cinza'), pause;
    % Geracao do histograma da imagem
    imagem_limiar = imagem_cinza;
    figure(2), imhist(imagem_limiar), title('Histograma da imagem em escala cinza'), pause;
    % Filtragem mediana
    imagem_limiar = medfilt2(imagem_limiar);
    % Converte imagem em tons de cinza para preto e branco de acordo com um limiar
    limiar = 100;
    imagem_limiar(imagem_limiar < limiar) = 0;
    imagem_limiar(imagem_limiar >= limiar) = 1;
    imagem_limiar = logical(imagem_limiar);
    figure(3), imshow(imagem_limiar), title('Imagem em preto e branco'), pause;
    % Deteccao de bordas
    imagem_bordas = edge(imagem_limiar, 'sobel');
    figure(4), imshow(imagem_bordas), title('Deteccao de bordas'), pause;
    % Deteccao de bordas horizontais
    imagem_bordas_horizontais = edge(imagem_limiar, 'sobel', (graythresh(imagens{i})*0.5), 'horizontal');
    figure(5), imshow(imagem_bordas_horizontais), title('Deteccao de bordas horizontais'), pause;
    % Transformada Hough
    [H, theta, rho] = hough(imagem_bordas_horizontais);
    figure(6), imshow(imadjust(mat2gray(H)), [], 'X', theta, 'Y', rho, 'InitialMagnification', 'fit'), title('Transformada Hough'), pause;
    xlabel('\theta (graus)'), ylabel('\rho');
    axis on, axis normal, hold on;
    colormap(hot);
    % Encontrando picos da trasnformada Hough
    picos = houghpeaks(H, 300, 'threshold', ceil(0.5*max(H(:))));
    x = theta(picos(:,2));
    y = rho(picos(:,1));
    plot(x,y,'s','Color','Red'); pause;
    % Linhas que convergem para os pontos de fuga
    linhas = houghlines(imagem_bordas_horizontais, theta, rho, picos, 'FillGap', 400, 'MinLength', 500);
    figure(7), imshow(imagens{i}), title('Imagem com as linhas de fuga'), hold on
    for k = 1:length(linhas)
        xy = [linhas(k).point1; linhas(k).point2];
        plot(xy(:,1),xy(:,2), 'LineWidth', 2, 'Color', 'Red');
        plot(xy(1,1),xy(1,2), 'x', 'LineWidth', 2, 'Color', 'Yellow');
        plot(xy(2,1),xy(2,2), 'x', 'LineWidth', 2, 'Color', 'Green');
    end
    pause;
    % Salvando a imagem final
    print(sprintf('Imagens Fuga Automatico/%d.jpeg',i),'-dpng');
end
    
    