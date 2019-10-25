clear

image = imread("images/tajmahal.png");

imageDouble = im2double(image);

figure(1); imshow(imageDouble); title("Original");

n = 30;

[rows,cols,dim] = size(imageDouble);

for i = 1 : n
  pepper(:,:,:,i) = imnoise (imageDouble, "salt & pepper", 0.1);
endfor

#figure(2); imshow(pepper(:,:,:,1)); title("Pepper[1]");
imwrite(pepper(:,:,:,1),"images/tajmahal_pepper_1.png");

media(:,:,1) = zeros(rows,cols,"double");
media(:,:,2) = zeros(rows,cols,"double");
media(:,:,3) = zeros(rows,cols,"double");

for i = 1 : n
  media(:,:,1) = media(:,:,1).+pepper(:,:,1,i);
  media(:,:,2) = media(:,:,2).+pepper(:,:,2,i);
  media(:,:,3) = media(:,:,3).+pepper(:,:,3,i);
endfor

media = media./n;

#figure(3); imshow(media); title("Pepper - Media");
imwrite(media,"images/tajmahal_pepper_media.png");

for i = 1 : cols
  mediana(:,:,1) = median(pepper(:,i,1,:));
  mediana(:,:,2) = median(pepper(:,i,2,:));
  mediana(:,:,3) = median(pepper(:,i,3,:));
endfor

#figure(4); imshow(media); title("Pepper - Mediana");

for i = 1 : n
  gaussian(:,:,:,i) = imnoise(imageDouble,"gaussian",0,0.02);
endfor

#figure(5); imshow(gaussian(:,:,:,1)); title("Gaussian[1]");
imwrite(gaussian(:,:,:,1),"images/tajmahal_gaussian_1.png");

media(:,:,1) = zeros(rows,cols,"double");
media(:,:,2) = zeros(rows,cols,"double");
media(:,:,3) = zeros(rows,cols,"double");

for i = 1 : n
  media(:,:,1) = media(:,:,1).+gaussian(:,:,1,i);
  media(:,:,2) = media(:,:,2).+gaussian(:,:,2,i);
  media(:,:,3) = media(:,:,3).+gaussian(:,:,3,i);
endfor

media = media./n;

#figure(6); imshow(media); title("Gaussian - Media");
imwrite(media,"images/tajmahal_gaussian_media.png");

for i = 1 : cols
  mediana(:,:,1) = median(gaussian(:,i,1,:));
  mediana(:,:,2) = median(gaussian(:,i,2,:));
  mediana(:,:,3) = median(gaussian(:,i,3,:));
endfor

#figure(7); imshow(media); title("Gaussian - Mediana");
imwrite(mediana,"images/tajmahal_gaussian_mediana.png");

