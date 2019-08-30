import sys
import cv2
import time

# Input
imgPath = sys.argv[1] if len(sys.argv) > 1 else 'img.jpg'
scale = int(sys.argv[2]) if len(sys.argv) == 3 else 1

# Open camera
print "Opening camera"
cap = cv2.VideoCapture(0)
if not cap.isOpened():
  print "Camera not opened"
  exit(1)

# Acquire some frame to adjust exposure
print "Adjusting exposure"
for i in range(30):
    ret, frame = cap.read()
    time.sleep(0.1)

# Close camera
cap.release()

# Check if frame is dark
img = cv2.resize(frame, (int(frame.shape[1]/scale), int(frame.shape[0]/scale)))
gray = cv2.cvtColor(img, cv2.cv.CV_BGR2GRAY)
avgColor = cv2.mean(gray)[0]
print "Average color: %.0f" % avgColor
if avgColor < 15:
  print "Image too dark"
  exit(0)

# Save image
print 'Saving %s' % imgPath
cv2.imwrite(imgPath, img)

