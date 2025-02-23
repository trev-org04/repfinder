import cv2
from ultralytics import YOLO

model = YOLO("yolov8n.pt")  

video_path = "videos/rpac.mp4"
cap = cv2.VideoCapture(video_path)

fps = int(cap.get(cv2.CAP_PROP_FPS))
frame_width = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
frame_height = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))

out = cv2.VideoWriter("detection-rpac.mp4", cv2.VideoWriter_fourcc(*'mp4v'), fps, (frame_width, frame_height))

bounding_boxes = [(46, 231, 277, 282,"Hamstring Curl"), 
                (332, 245, 240, 268, "Bicep Curl"),
                (587, 248, 247, 262, "Ab Crunch "), 
                (103, 16, 281, 223, "Leg Extension"), 
                (400, 20, 173, 226, "Leg Extension"), 
                (588, 14, 213, 218, "Leg Curl")]

def compute_iou(boxA, boxB):
    xA = max(boxA[0], boxB[0])
    yA = max(boxA[1], boxB[1])
    xB = min(boxA[2], boxB[2])
    yB = min(boxA[3], boxB[3])

    interArea = max(0, xB - xA) * max(0, yB - yA)
    
    boxAArea = (boxA[2] - boxA[0]) * (boxA[3] - boxA[1])
    boxBArea = (boxB[2] - boxB[0]) * (boxB[3] - boxB[1])

    iou = interArea / float(boxAArea + boxBArea - interArea)
    return iou

while cap.isOpened():
    ret, frame = cap.read()
    if not ret:
        break

    results = model(frame)

    people_boxes = []
    
    for r in results:
        for box in r.boxes:
            cls = int(box.cls[0])  
            conf = float(box.conf[0])  
            x1, y1, x2, y2 = map(int, box.xyxy[0])  

            if cls == 0 and conf > 0.5:  
                people_boxes.append((x1, y1, x2, y2))
                cv2.rectangle(frame, (x1, y1), (x2, y2), (255, 0, 0), 2) 
                cv2.putText(frame, f"Person {conf:.2f}", (x1, y1 - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.6, (255, 0, 0), 2)

    for (x, y, w, h, label) in bounding_boxes:
        machine_box = (x, y, x + w, y + h)
        cv2.rectangle(frame, (x, y), (x + w, y + h), (0, 255, 0), 2)
        cv2.putText(frame, label, (x, y - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.6, (0, 255, 0), 2)

        for (px1, py1, px2, py2) in people_boxes:
            person_box = (px1, py1, px2, py2)
            iou = compute_iou(machine_box, person_box)

            if iou > 0.1:  
                cv2.putText(frame, f"Using {label}", (x, y + h + 20), cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 0, 255), 2)
            
    out.write(frame)
    cv2.imshow("Machine Usage Detection", frame)

    if cv2.waitKey(1) & 0xFF == ord('q'):  
        break

cap.release()
out.release()
cv2.destroyAllWindows()