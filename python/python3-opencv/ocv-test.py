#!/usr/bin/python3

import cv2

#read image 
img = cv2.imread('/usr/share/wallpapers/Next/contents/images/360x720.png')
 
#show image
cv2.imshow('Example - Show image in window',img)
  
cv2.waitKey(0) # waits until a key is pressed
cv2.destroyAllWindows() # destroys the window showing image

