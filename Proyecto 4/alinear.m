clear
pkg load image

#Cargo la imagen
rgb_image = imread("images/horizonte_2.jpg");

#Transformo a escala de grises
image_gray= rgb2gray(rgb_image);

#Obtengo los bordes con el operador de canny
bordes =edge(image_gray, 'canny');

figure(4); imshow(bordes);

#Computo la transformada de hough al espacio theta rho
[H,theta,rho] = hough(bordes);

#Obtengo los valores mas altos dentro de la matriz transformada
P = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
x = theta(P(:,2)); 
y = rho(P(:,1));

#Obtengo las lineas candidatas
lineas = houghlines(bordes,theta,rho,P,'FillGap',15,'MinLength',20);

figure(1), imshow(rgb_image), hold on
max_len = 0;
max_index = -1;

#Para cada linea obtenida, la dibujo sobre la imagen original y a la vez obtengo la mas larga
for k = 1:length(lineas)
   xy = [lineas(k).point1; lineas(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   len = norm(lineas(k).point1 - lineas(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
      max_index=k;
   end
end

#Resalto en rojo la linea mas larga
plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','red');

#Obtengo la rotacion que se le debe aplicar a la imagen para acomodarla
rotation = x(2);
if ( rotation > 0)
  rotation-= 90;
else
  rotation+=90;
end

#Finalmente roto la imagen y la muestro
image_rot = imrotate (rgb_image, rotation );
#, 'fourier', 'crop'
figure(2);
imshow(image_rot);hold on,
plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','cyan');
