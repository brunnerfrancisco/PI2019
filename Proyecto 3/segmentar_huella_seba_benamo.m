clear
pkg load image

#Cargo todas las imagenes existentes
k=1;
for i=1:10
  for j=1:8
    imagenes(:,:,k) = imread(sprintf("DB2_B/1%02d_%01d.tif",i,j));
    k++;
  endfor
endfor

sobelVertical = [ -1 -2 -1; 0 0 0; 1 2 1];
sobelHorizontal = [-1 0 1; -1 0 2; -1 0 1];

#Parametros a utilizar
imagenInicial = 20;
cantImagenes = 4;  

#Para imagenes de 500 dpi
B = 3;
N = 8;
matrizPromedio = ones(N, "double")./(N^2);

#Realizo las operaciones para la cantidad de imágenes deseada
for i= imagenInicial: imagenInicial+cantImagenes
  
  #Selecciono la imagen del arreglo
  imagenDouble = im2double(imagenes(:,:,i));

  #Aplico un filtro de mediana para remover imperfecciones menores como ruido y artefactos
  mediana = medfilt2(imagenDouble, [B B]);

  #Obtengo el gradiente en x e y 
  gradX = imfilter (mediana, sobelVertical, 'replicate');
  gradY = imfilter (mediana, sobelHorizontal, 'replicate');
  
  #Calculo el promedio del gradiente de los N^2 píxeles de alrededor
  gradXProm = imfilter(gradX, matrizPromedio, 'replicate');
  gradYProm = imfilter(gradY, matrizPromedio, 'replicate');  

  #Calculo el desvío estándar total en cada píxel
  # Realizar los calculos componente a componente, despues hacer un nuevo promediado
  # una vez terminado aplicar raiz cuadrada componente a componente
  DE_X = (gradX.-gradXProm).* (gradX.-gradXProm);
  DE_XProm = imfilter(DE_X, matrizPromedio, 'replicate');
  
  DE_Y = (gradY.-gradYProm).* (gradY.-gradYProm);
  DE_YProm = imfilter(DE_Y, matrizPromedio, 'replicate');
  
  DE_XFinal = DE_XProm .^(1/2);
  DE_YFinal = DE_YProm .^(1/2);
  
  DE = DE_XFinal .+ DE_YFinal;

  #Obtengo y aplico el umbral al desvío estándar para obtener una máscara
  umbral = im2bw(DE, graythresh(DE));

  #Elimino elementos pequeños y agujeros en la máscara aplicando apertura y clausura morfológica  
  SE = ones(B, "double");
  apertura = imopen(umbral, SE);
  mascaraNegro = imclose(apertura, SE);
  
  #Aplico la mascara obtenida a la imagen original
  imagenFinalNegro = imagenDouble .* mascaraNegro;
  
  mascaraBlanco = imcomplement(mascaraNegro);
  imagenFinalBlanco = imagenDouble .+ mascaraBlanco;
  
  figure(i);
  subplot(1,3,1);
  imshow(imagenFinalNegro);
  subplot(1,3,2);
  imshow(imagenDouble);
  subplot(1,3,3);
  imshow(imagenFinalBlanco);
  
endfor

