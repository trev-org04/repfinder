import cv2
import time
import threading  # ✅ Runs Supabase updates in parallel
from ultralytics import YOLO
from collections import deque
from datetime import datetime
from supabase import create_client, Client

# Supabase Configuration
SUPABASE_URL = "https://zfeaehqvwkfislfqisgj.supabase.co"
SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpmZWFlaHF2d2tmaXNsZnFpc2dqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDAyNTgwODYsImV4cCI6MjA1NTgzNDA4Nn0.Tu7B4GqJ9uZPR1WyqcL6j9SmHVvOq-bBZSJHYu6F3aQ"
supabase: Client = create_client(SUPABASE_URL, SUPABASE_KEY)


# Trained model
model = YOLO("yolov8n.pt")  

# Capture video
video_path = "videos/rpac.mp4"
cap = cv2.VideoCapture(video_path)

fps = int(cap.get(cv2.CAP_PROP_FPS))
frame_width = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
frame_height = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))

out = cv2.VideoWriter("detection-rpac.mp4", cv2.VideoWriter_fourcc(*'mp4v'), fps, (frame_width, frame_height))

# Define Machines and Their Regions
bounding_boxes = [(46, 231, 277, 282,"Hamstring Curl",1, "LEGS"), 
                (332, 245, 240, 268, "Bicep Curl",2, "BICEPS"),
                (587, 248, 247, 262, "Ab Crunch ",3, "ABS"), 
                (103, 16, 281, 223, "Leg Extension",4, "LEGS"), 
                (400, 20, 173, 226, "Leg Extension",5, "LEGS"), 
                (588, 14, 213, 218, "Leg Curl",6, "LEGS")]

# Create buffers for each machine
machine_buffer = {}

# Ensure all keys match the access pattern
machine_buffer = { (machine_id, label, muscle_group): deque(maxlen=30) for (_, _, _, _, label, machine_id, muscle_group) in bounding_boxes }

# Stores the last known status to avoid unnecessary DB writes
last_machine_status = {key: None for key in machine_buffer}

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

# Run Supabase Updates in a Separate Thread 
def async_update_supabase(machine_status_updates):
    def task():
            response = supabase.table("machines").upsert(machine_status_updates).execute()
    threading.Thread(target=task, daemon=True).start()

# Process video
frame_count = 0
while cap.isOpened():
    ret, frame = cap.read()
    if not ret:
        break

    results = model(frame)

    people_boxes = []
    
    # Detect humans on machine
    for r in results:
        for box in r.boxes:
            cls = int(box.cls[0])  
            conf = float(box.conf[0])  
            x1, y1, x2, y2 = map(int, box.xyxy[0])  

            if cls == 0 and conf > 0.5:  
                people_boxes.append((x1, y1, x2, y2))
                cv2.rectangle(frame, (x1, y1), (x2, y2), (255, 0, 0), 2) 
                cv2.putText(frame, f"Person {conf:.2f}", (x1, y1 - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.6, (255, 0, 0), 2)

    # Process each machine
    for (x, y, w, h, label, machine_id, muscleGroup) in bounding_boxes:
        machine_box = (x, y, x + w, y + h)
        cv2.rectangle(frame, (x, y), (x + w, y + h), (0, 255, 0), 2)
        cv2.putText(frame, label, (x, y - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.6, (0, 255, 0), 2)
        occupied = False

        for (px1, py1, px2, py2) in people_boxes:
            person_box = (px1, py1, px2, py2)
            iou = compute_iou(machine_box, person_box)

            if iou > 0.1:
                occupied = True  
                cv2.putText(frame, f"Using {label}", (x, y + h + 20), cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 0, 255), 2)
            
        # Update buffer
        machine_buffer[(machine_id, label, muscleGroup)].append(occupied)

        if frame_count % fps == 0:
            machine_status_updates = []
            for machine, buffer in machine_buffer.items():
                if len(buffer) == 30: 
                    is_available = not any(buffer)
                    status = "available" if is_available else "occupied"

                    # Avoid unnecessary db updates
                    if last_machine_status[machine] != status:
                        machine_status_updates.append({
                            "machine_id": machine[0],
                            "name": machine[1],
                            "muscle_group": machine[2],
                            "status": status,
                            "last_updated": datetime.utcnow().isoformat()
                        })
                        last_machine_status[machine] = status  

        if machine_status_updates:
            async_update_supabase(machine_status_updates) 

    frame_count +=1
    out.write(frame)
    cv2.imshow("Machine Usage Detection", frame)

    if cv2.waitKey(1) & 0xFF == ord('q'):  
        break

cap.release()
out.release()
cv2.destroyAllWindows()