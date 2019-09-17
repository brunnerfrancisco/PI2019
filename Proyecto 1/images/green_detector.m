clear
imageRGB = imread("b_2_1.jpg");

imageRED   = imageRGB(:,:,1);
imageGREEN = imageRGB(:,:,2);
imageBLUE  = imageRGB(:,:,3);

imageHSV = rgb2hsv(imageRGB);
imageHUE = imageHSV(:,:,1);
imageSAT = imageHSV(:,:,2);
imageVAL = imageHSV(:,:,3);
imageOUT = imageHSV;

imageTAM=size(imageRGB);

rows = imageTAM(1);
cols = imageTAM(2);

cantPixels=imageTAM(1).*imageTAM(2);

verdeVivo=0;
verdeSeco=0;
tierra=0;
pverdeVivo=0;
pverdeSeco=0;
pTierra=0;

for i=1:rows
  for j=1:cols
    if( (imageHUE(i,j)>0.14) && (imageHUE(i,j)<0.47) && (imageSAT(i,j)>0.13) && (imageVAL(i,j)>0.2) ) %detecto verdes
      imageOUT(i,j,1)=0.0;
      imageOUT(i,j,2)=0.5;
      verdeVivo = verdeVivo+1;
    else if( (imageHUE(i,j)>=0.04) && (imageHUE(i,j)<0.18) && (imageVAL(i,j)>0.7)) % detecto amarillos
      imageOUT(i,j,1) = 0.65;
      imageOUT(i,j,2) = 0.5;
      verdeSeco = verdeSeco + 1;
      else if( ((imageHUE(i,j)>0.6) || (imageHUE(i,j)<0.20))  && (imageVAL(i,j)<0.95) && (imageVAL(i,j)>0.09) ) % detecto marrones
        imageOUT(i,j,1) = 0.27;
        imageOUT(i,j,2) = 0.5;
        tierra = tierra + 1;
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

disp("Porcentaje Verde Vivo: "), disp(pverdeVivo);
disp("Porcentaje Verde Seco: "), disp(pverdeSeco);
disp("Porcentaje Tierra: "),     disp(pTierra);
