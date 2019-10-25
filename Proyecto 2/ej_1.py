import cv2 as cv
import numpy as np

path=r'images/tajmahal.png'

ddepth = cv.CV_16S

kernel_size = 5

image = cv.imread(path)

median = cv.medianBlur(image, 5)

src_gray = cv.cvtColor(median, cv.COLOR_BGR2GRAY)

dst = cv.Laplacian(src_gray, ddepth, ksize=kernel_size)

abs_dst = cv.convertScaleAbs(dst)

cartoon = cv.multiply(median,abs_dst)

cv.imshow("lala",abs_dst)

cv.waitKey()
