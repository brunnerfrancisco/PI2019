clear
imageRGB = imread("patio_casa.png");

% Paso la imagen a HSV y descompongo la matriz 
imageHSV = rgb2hsv(imageRGB);
imageHUE = round(imageHSV(:,:,1)*360);
imageSAT = imageHSV(:,:,2);
imageVAL = imageHSV(:,:,3);
imageOUT = imageHSV;

% Tamaño en pixels de la imagen
imageTAM=size(imageRGB);
rows = imageTAM(1);
cols = imageTAM(2);
cantPixels=rows.*cols;

verdeVivo=0;
verdeSeco=0;
tierra=0;
pverdeVivo=0;
pverdeSeco=0;
pTierra=0;
fuera=0;

for i=1:rows
  for j=1:cols
    if( (imageHUE(i,j)>50) && (imageHUE(i,j)<169) && (imageSAT(i,j)>0.15) && (imageVAL(i,j)>0.15) ) %detecto verdes
      % si es verde lo mapeo a rojo
      imageOUT(i,j,1)=0;
      imageOUT(i,j,2)=1.0;
      verdeVivo = verdeVivo+1;
    else if( (imageHUE(i,j)>=14) && (imageHUE(i,j)<50) && (imageVAL(i,j)>0.5)) % detecto amarillos
      % si es amarillos lo mapeo a verde
      imageOUT(i,j,1) = 0.33;
      imageOUT(i,j,2) = 1.0;
      verdeSeco = verdeSeco + 1;
      else if( ((imageHUE(i,j)>290) || (imageHUE(i,j)<50))  && (imageVAL(i,j)<0.95) && (imageVAL(i,j)>0.09) ) % detecto marrones
        % si es marron lo mapeo a azul
        imageOUT(i,j,1) = 0.66;
        imageOUT(i,j,2) = 1.0;
        tierra = tierra + 1;
      else % si no entra en ningun rango lo mapeo a negro
        imageOUT(i,j,1) = 0;
        imageOUT(i,j,2) = 0;
        fuera = fuera + 1;
      endif
    endif
    endif
  endfor
endfor

imageOUT_2= hsv2rgb(imageOUT);
imshow(imageOUT_2);

pverdeVivo = verdeVivo/cantPixels;
pverdeSeco = verdeSeco/cantPixels;
pTierra = tierra/cantPixels;
pFuera = fuera/cantPixels;

disp("Porcentaje Verde Vivo: "), disp(pverdeVivo);
disp("Porcentaje Verde Seco: "), disp(pverdeSeco);
disp("Porcentaje Tierra: "),     disp(pTierra);
disp("Porcentaje Fuera: "),     disp(pFuera);