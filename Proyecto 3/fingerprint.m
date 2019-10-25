
clear

k = 1;
for i = 1:10
  for j = 1:8
    images(:,:,k) = imread(sprintf("DB2_B/1%02d_%01d.tif",i,j));
    k++;
  endfor
endfor
k--;

for i=1:k

  imageDouble = im2double(images(:,:,i));
  B = 5; # para imaganes de 500dpi

  N = 8; # para imaganes de 500dpi

  averageMatrix = ones(N,"double");
  averageMatrix = averageMatrix./(N^2);

  morphTemplate = ones(B,"double");


  #Estrategia: Paso 1) Aplico la Mediana de BxB
  mediana = medfilt2(imageDouble,[B B]);

  #Estrategia: Paso 2) Obtengo los gradientes en X y en Y
  sobelX = fspecial("sobel");
  sobelY = sobelX';
  gradX = imfilter(mediana,sobelX,"replicate");
  gradY = imfilter(mediana,sobelY,"replicate");
  #[gradX,gradY] = imgradientxy (mediana, "sobel");

  #Estrategia: Paso 3) Se calcula el promedio de cada pixel de los N^2 pixeles
  # alrededor
  Mx = conv2(gradX,averageMatrix,'same');
  My = conv2(gradY,averageMatrix,'same');

  #Estrategia: Paso 4) Se calcula el desvio estandar de cada pixel en X y en Y
  stdX = (conv2(((gradX.-Mx).*(gradX.-Mx)),averageMatrix,'same')).^(1/2);
  stdY = (conv2(((gradY.-My).*(gradY.-My)),averageMatrix,'same')).^(1/2);

  #Estrategia: Paso 5) El desvio estandar total es la suma de los desvios
  # en X y en Y
  grddev = stdX .+ stdY;

  #Estrategia: Paso 6) Aplicamos el umbradado al desvio para obtener la mascara
  # Calculamos el umbral apropiado
  hist = imhist(grddev);
  level = otsuthresh(hist);
  threshold = im2bw(grddev,level);

  #Estrategia: Paso 7) Eliminamos agujeros aplicando apertura y clausura con 
  # elementos de BxB
  #Apertura
  morphOpen = imopen(threshold,morphTemplate);

  #Clausura
  morphClose = imclose(morphOpen,morphTemplate);

  #Estrategia: Paso 8) Aplicar la mascara para que quede el fondo en negro
  imageFinalNegro = imageDouble.*morphClose;

  #Estrategia: Paso 8) Aplicar la mascara para que quede el fondo en negro
  imageFinalBlanco = imageDouble.+imcomplement(morphClose);
  imageFinalBlanco(imageFinalBlanco>1.0) = 1.0;


  #figure(1);
  #subplot(1,3,1);imshow(imageDouble);
  #subplot(1,3,2);imshow(imageFinalNegro);
  #subplot(1,3,3);imshow(imageFinalBlanco);

  imwrite(imageFinalNegro,sprintf("DB2_B_P/%02d_Negro.tif",i));
  imwrite(imageFinalBlanco,sprintf("DB2_B_P/%02d_Blanco.tif",i));

endfor