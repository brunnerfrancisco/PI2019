clear
imageRGB = imread("b_2_1.jpg");
imageHSV = rgb2hsv(imageRGB);
[fil,col,aux] = size(imageHSV);
imageHUE=round(imageHSV(:,:,1)*360);
imageSAT=round(imageHSV(:,:,2)*255);
imageVAL=round(imageHSV(:,:,3)*255);

totalCeldas=fil*col;
green(1:fil,1:col,1)=0;
green(1:fil,1:col,2)=0;
green(1:fil,1:col,3)=0;
cantVerdes=0;


for i=1:fil
  for j=1:col
    if(imageHUE(i,j)>36 && imageHUE(i,j)<=110 )%&& imageSAT>25 && imageSAT<=255 && imageVAL>25 && imageVAL<=255)
      cantVerdes = cantVerdes + 1;
      green(i,j,:)=imageRGB(i,j,:);
    else
      green(i,j)=0;
    endif
  endfor
endfor

porcentaje = cantVerdes/totalCeldas;

disp(porcentaje);
imshow(green);



%threshI = (imageHSV(:,:,2)>=0.1)&(imageHSV(:,:,2)<=1)&(imageHSV(:,:,3)>=0.1)&(imageHSV(:,:,3)<=1);
%green = ((imageHUE>90)&(imageHUE<=150))&threshI;
