import cv2 as cv
import numpy as np

path = r'b_2_1.jpg'

imagen = cv.imread(path)

hsv_img = cv.cvtColor(imagen, cv.COLOR_BGR2HSV)

mask = cv.inRange(hsv_img, (36, 25, 25), (70, 255,255))

imask = mask>0

green = np.zeros_like(imagen, np.uint8)

green[imask] = imagen[imask]

cv.imshow(path,green)

cv.waitKey()
