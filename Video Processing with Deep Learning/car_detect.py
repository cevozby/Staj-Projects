import cv2
import numpy as np
import time
import imutils
from imutils.video import FPS
from imutils.video import VideoStream


INPUT_FILE='arabakısa2.mp4'
OUTPUT_FILE='output.avi'
LABELS_FILE='coco.names'
CONFIG_FILE='yolov3.cfg'
WEIGHTS_FILE='yolov3.weights'
CONFIDENCE_THRESHOLD=0.7

H=None
W=None

fps = FPS().start()

fourcc = cv2.VideoWriter_fourcc(*"MJPG")
writer = cv2.VideoWriter(OUTPUT_FILE, fourcc, 30,
	(800, 600), True)

LABELS = open(LABELS_FILE).read().strip().split("\n")

np.random.seed(4)
COLORS = np.random.randint(0, 255, size=(len(LABELS), 3),
	dtype="uint8")


net = cv2.dnn.readNetFromDarknet(CONFIG_FILE, WEIGHTS_FILE)

vs = cv2.VideoCapture(INPUT_FILE)


# determine only the *output* layer names that we need from YOLO
ln = net.getLayerNames()
ln = [ln[i[0] - 1] for i in net.getUnconnectedOutLayers()]
cnt =0;
carr=0;
while True:
    cnt+=1
    print ("Frame number", cnt)
    try:
        (grabbed, image) = vs.read()
    except:
            break
    ROI=image[0:800, 175:600]
    blob = cv2.dnn.blobFromImage(ROI, 1 / 255.0, (416, 416),
                                 swapRB=True, crop=False)
    net.setInput(blob)
    if W is None or H is None:
        (H, W) = ROI.shape[:2]
    layerOutputs = net.forward(ln)




	# initialize our lists of detected bounding boxes, confidences, and
	# class IDs, respectively
    boxes = []
    confidences = []
    classIDs = []

	# loop over each of the layer outputs
    for output in layerOutputs:
		# loop over each of the detections
        for detection in output:
			# extract the class ID and confidence (i.e., probability) of
			# the current object detection
            scores = detection[5:]
            classID = np.argmax(scores)
            confidence = scores[classID]

			# filter out weak predictions by ensuring the detected
			# probability is greater than the minimum probability
            if confidence > CONFIDENCE_THRESHOLD:
				# scale the bounding box coordinates back relative to the
				# size of the image, keeping in mind that YOLO actually
				# returns the center (x, y)-coordinates of the bounding
				# box followed by the boxes' width and height
                box = detection[0:4] * np.array([W, H, W, H])
                (centerX, centerY, width, height) = box.astype("int")

				# use the center (x, y)-coordinates to derive the top and
				# and left corner of the bounding box
                x = int(centerX - (width / 2))
                y = int(centerY - (height / 2))

				# update our list of bounding box coordinates, confidences,
				# and class IDs
                boxes.append([x, y, int(width), int(height)])
                confidences.append(float(confidence))
                classIDs.append(classID)

	# apply non-maxima suppression to suppress weak, overlapping bounding
	# boxes
    idxs = cv2.dnn.NMSBoxes(boxes, confidences, CONFIDENCE_THRESHOLD,
		CONFIDENCE_THRESHOLD)

	# ensure at least one detection exists
    if len(idxs) > 0:
		# loop over the indexes we are keeping
        for i in idxs.flatten():
          #  print(classIDs[i])
			# extract the bounding box coordinates
            if classIDs[i]==2 or classIDs[i]==5 or classIDs[i]==7:
                carr=carr+1
                (x, y) = (boxes[i][0], boxes[i][1])
                (w, h) = (boxes[i][2], boxes[i][3])

                color = [int(c) for c in COLORS[classIDs[i]]]

                cv2.rectangle(ROI, (x, y), (x + w, y + h), color, 2)
                text = "{}: {:.2f}".format(LABELS[classIDs[i]], confidences[i])
                cv2.putText(ROI, text, (x, y - 5), cv2.FONT_HERSHEY_SIMPLEX,
                            0.5, color, 2)
            else:
                break

	# show the output image
    text2="{} = {}".format("car number", carr)
    cv2.putText(image, text2, (125,35), cv2.FONT_HERSHEY_SIMPLEX,
                0.6, (0,0,255), 2)
    cv2.imshow("output", cv2.resize(image,(800, 600)))
    carr=0;
    writer.write(cv2.resize(image,(800, 600)))
    fps.update()
    key = cv2.waitKey(1) & 0xFF
    if key == ord("q"):
        break

fps.stop()

print("[INFO] elasped time: {:.2f}".format(fps.elapsed()))
print("[INFO] approx. FPS: {:.2f}".format(fps.fps()))

# do a bit of cleanup
cv2.destroyAllWindows()

# release the file pointers
print("[INFO] cleaning up...")
writer.release()
vs.release()