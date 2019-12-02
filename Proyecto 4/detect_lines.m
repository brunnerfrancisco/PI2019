
clear;

pkg load geometry;

pkg load image;

imageRGB = imread('images/horizonte_3.jpg');

imageGray = rgb2gray(imageRGB);

imageBW = edge(imageGray,'Sobel');

# Transformacion de la imagen
[H,theta,rho] = hough(imageBW);

# Hallar los picos de la transformacion
houghPeaks = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));

#Obtener las lineas a partir de los picos de la transformacion
lines = houghlines(imageBW,theta,rho,houghPeaks,'FillGap',20,'MinLength',20);

# Mostrar Imagen Original
figure, subplot(1,2,1), imshow(imageRGB), hold on, title("Original");


for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
end

xy = [lines(1).point1; lines(1).point2];
plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','red');

# Calcular el angulo de rotacion
if( lines(1).theta < 0 )
  angleRot = lines(1).theta+90;
else
  angleRot = lines(1).theta-90;
end

# Rotar la imagen con metodo de 'fourier' y crop para que lo que se
#  salga de la imagen lo corte y no ajuste la imagen para que entre todo
imageRot = imrotate(imageRGB,angleRot,'fourier','crop');

subplot(1,2,2), imshow(imageRot), title("Rotation"), hold on;

