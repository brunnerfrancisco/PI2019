
# La idea es aplicar a la imagen
#   - el filtro de mediana
#   - el laplaciano al filtro de mediana
#   - el negativo al laplaciano
#   - obtener la escala de grises del negativo
#   - oscurecer los grises.
# por ultimo multiplicar la mediana por los grises oscurecidos

clear
#image = imread("images/anahi.png");
image = imread("images/tajmahal.png");

imageDouble = im2double(image);

imageR = imageDouble(:,:,1);
imageG = imageDouble(:,:,2);
imageB = imageDouble(:,:,3);

medianaR = medfilt2(imageR);
medianaG = medfilt2(imageG);
medianaB = medfilt2(imageB);

mediana(:,:,1)=medianaR;
mediana(:,:,2)=medianaG;
mediana(:,:,3)=medianaB;

laplacian_filter = fspecial("laplacian", 1);

laplacianoR = imfilter(medianaR,laplacian_filter);
laplacianoG = imfilter(medianaG,laplacian_filter);
laplacianoB = imfilter(medianaB,laplacian_filter);

laplaciano(:,:,1)=laplacianoR;
laplaciano(:,:,2)=laplacianoG;
laplaciano(:,:,3)=laplacianoB;

negativoR = imcomplement(laplacianoR);
negativoG = imcomplement(laplacianoG);
negativoB = imcomplement(laplacianoB);

negativo = imcomplement(laplaciano);

#negativo(:,:,1)=negativoR;
#negativo(:,:,2)=negativoG;
#negativo(:,:,3)=negativoB;

level = graythresh(negativo);

disp(level);

grises = im2bw(negativo,level);

cartoonR = medianaR.*grises;
cartoonG = medianaG.*grises;
cartoonB = medianaB.*grises;

cartoon(:,:,1) = cartoonR;
cartoon(:,:,2) = cartoonG;
cartoon(:,:,3) = cartoonB;

#cartoon = immultiply(mediana,negativo);

#imshow(cartoon);


