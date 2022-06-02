# aartvark
Your art gallery companion. 
Julia J., Lily T., Khuyen L., Ryan A. 

## Expected behavior
As the user approaches the painting / device underneath a painting: 
- More than 1.5 meters away: they will hear music. 
- More than 1.2 meters away (but less than 1.5 meters away), or less than 1.2 meters away but have not heard the preview: they will hear a preview of the painting. 
- Less than 1.2 meters away: full audio description with details.

Once the full audio description is playing, they can move around and still keep the audio description playing as long as they don't get out of the sensor's range for more than 5 seconds. 

## Code components
This project consists of: 
1. Arduino code, which is in `arduino_code`. This should be loaded into any Arduino used. 
2. Processing code, which is in `processing_code`. This contains individual folders for each painting (which has the painting's audio description, preview and musical piece). The code in each folder code should run on a device positioned underneath the corresponding painting.
3. Mobile app code, which is in `mobile_code`. If you are only looking to view the app, you do not need to run this code (follow instructions below). 

## Setting up
### Arduino 
Wire up your Arduino according to this [schematic](arduino_code/arduino_wiring.png). You'll need an Arduino UNO, an ultrasonic sensor, and a button. 

Download [Arduino IDE](https://www.arduino.cc/en/software/). Open `arduino_code/arduino_code.ino` with the Arduino IDE.

Upload the code to your Arduino, following [these instructions](https://docs.arduino.cc/software/ide-v2/tutorials/getting-started/ide-v2-uploading-a-sketch).

### Processing
Download [Processing](https://processing.org/download). Open `processing_code/[painting_id]/[painting_id]_processing/[painting_id]_processing.pde` with Processing.

Connect your Arduino to your device with a USB-B cable. 

Identify the Arduino port using [these instructions](https://support.arduino.cc/hc/en-us/articles/4406856349970-Select-board-and-port-in-Arduino-IDE) (follow the "Select port" section). 

Then replace `"/dev/cu.usbmodem14201"` in this line
`myPort = new Serial(this, "/dev/cu.usbmodem14201", 9600);` with your Arduino port. 

Run the code (triangle button in the Processing toolbar).

### Mobile app 
Download Expo Go at [link].

Log in details: username: `aartvark`, password: `CS377Q2022`

Click on the project titled "aartvark". 

### (Optional) Physical set up 
Print out each painting in the individual folders in `processing_code`.

Hang up the paintings, and place your devices with Arduino underneath the painting corresponding to the Processing code running on that device. 

Run the Processing code. Relocate the ultrasonic sensor to an appropriate spot, such that it is detecting the correct distance from somebody walking towards the painting as if they are approaching it in a museum. 




