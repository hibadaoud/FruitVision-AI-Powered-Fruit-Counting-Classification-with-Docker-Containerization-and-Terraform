import cv2
import mediapipe as mp
from math import hypot
import paho.mqtt.client as mqtt

# Define the MQTT broker's IP address and port (should match the ESP8266's details)
mqtt_broker = '91.121.93.94'
mqtt_port = 1883
mqtt_topic = 'device/reception'

# Create an MQTT client
client = mqtt.Client()
 
# Connect to the MQTT broker
client.connect(mqtt_broker, mqtt_port)
print(f"Connected to MQTT broker: {mqtt_broker}:{mqtt_port}")

cap = cv2.VideoCapture(0)
# Get the screen width and height
screen_width = 1024  # Set your desired screen width
screen_height = 768  # Set your desired screen height
cap.set(3, screen_width)
cap.set(4, screen_height)

mpHands = mp.solutions.hands
hands = mpHands.Hands(max_num_hands=1)
mpDraw = mp.solutions.drawing_utils

# Calculate the coordinates for the rectangles
center_x = screen_width // 2
center_y = screen_height // 2
rect_width = 275
rect_height = 275
top_y = center_y - 335
bottom_y = center_y - 20
left_x = 50
right_x = screen_width - 350

# Define the text and rectangle colors
text_color = (65, 40, 200)
rect_color = (65, 40, 200)

# Initialize the mode variable
mode = 0

# Start the MQTT client's background thread
client.loop_start()

while True:
    success, img = cap.read()
    img = cv2.flip(img, 1)
    img = cv2.resize(img, [1000, 650])
    imgRGB = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)

    results = hands.process(imgRGB)

    lmList = []
    if results.multi_hand_landmarks:
        for handlandmark in results.multi_hand_landmarks:
            for id, lm in enumerate(handlandmark.landmark):
                h, w, _ = img.shape
                cx, cy = int(lm.x * w), int(lm.y * h)
                lmList.append([id, cx, cy])
            mpDraw.draw_landmarks(img, handlandmark, mpHands.HAND_CONNECTIONS)

    if len(lmList) >= 2:  # Check if at least two fingertips are detected
        x1, y1 = lmList[4][1], lmList[4][2]  # Thumb
        x2, y2 = lmList[8][1], lmList[8][2]  # Index finger

        # creating circle at the tips of thumb and index finger
        cv2.circle(img, (x1, y1), 10, (255, 0, 0), cv2.FILLED)  # image #fingers #radius #rgb
        cv2.circle(img, (x2, y2), 10, (255, 0, 0), cv2.FILLED)  # image #fingers #radius #rgb
        cv2.line(img, (x1, y1), (x2, y2), (255, 0, 0), 3)  # create a line b/w tips of index finger and thumb

        length = hypot(x2 - x1, y2 - y1)  # Distance between fingertips

        # Map the finger distance to motor speed (0% to 100%)
        speed = int(length)  # Adjust this scaling factor as needed

        # Ensure speed is within the valid range
        speed = min(max(speed, 0), 255)
        if speed < 70:
            speed = 0

        # Check hand position and set mode
        if left_x < x1 < left_x + rect_width and center_y - rect_height // 2 < y1 < center_y + rect_height // 2:
            mode = 3  # Left
        elif right_x < x1 < right_x + rect_width and center_y - rect_height // 2 < y1 < center_y + rect_height // 2:
            mode = 4  # Right
        elif center_x - rect_width // 2 < x1 < center_x + rect_width // 2 and top_y < y1 < top_y + rect_height:
            mode = 1  # Forward
        elif center_x - rect_width // 2 < x1 < center_x + rect_width // 2 and bottom_y < y1 < bottom_y + rect_height:
            mode = 2  # Backward
    else:
        # No hand detected, set speed and mode to 0
        speed = 0
        mode = 0

    print(speed, mode)
    # Get data from the user
    data = f"{speed},{mode}\n"
    try:
        client.publish(mqtt_topic, data)
    except ConnectionAbortedError as e:
        print(f"Connection aborted: {e}")
        # Attempt to reconnect or handle the error

    # Draw the border of the horizontal bar
    cv2.rectangle(img, (10, 10), (10 + speed, 30), (0, 0, 255), 2)
    # Create a filled horizontal bar
    cv2.rectangle(img, (10, 10), (10 + speed, 30), (0, 0, 255), cv2.FILLED)

    # Draw the four rectangles
    cv2.rectangle(img, (center_x - rect_width // 2, top_y), (center_x + rect_width // 2, top_y + rect_height),
                  rect_color, 2)  # Top
    cv2.rectangle(img, (center_x - rect_width // 2, bottom_y), (center_x + rect_width // 2, bottom_y + rect_height),
                  rect_color, 2)  # Bottom
    cv2.rectangle(img, (left_x, center_y - rect_height // 2), (left_x + rect_width, center_y + rect_height // 2),
                  rect_color, 2)  # Left
    cv2.rectangle(img, (right_x, center_y - rect_height // 2), (right_x + rect_width, center_y + rect_height // 2),
                  rect_color, 2)  # Right
    # Add text on top of each rectangle based on mode
    font = cv2.FONT_HERSHEY_SIMPLEX
    cv2.putText(img, "FORWARD", (center_x - rect_width // 2, top_y - 10), font, 1, text_color, 2)
    cv2.putText(img, "BACKWARD", (center_x - rect_width // 2, bottom_y - 10), font, 1, text_color, 2)
    cv2.putText(img, "LEFT", (left_x, center_y - rect_height // 2 - 10), font, 1, text_color, 2)
    cv2.putText(img, "RIGHT", (right_x, center_y - rect_height // 2 - 10), font, 1, text_color, 2)

    cv2.imshow('Image', img)

    if cv2.waitKey(1) & 0xFF == ord('q'):  # Press 'q' to exit the program
        break

# Clean up and release resources
cap.release()
cv2.destroyAllWindows()
client.loop_stop()
client.disconnect()
