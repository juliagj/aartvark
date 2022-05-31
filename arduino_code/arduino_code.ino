int trigPin = 11;    // Trigger
int echoPin = 12;    // Echo
int buttonPin = 9; 
long duration, cm, inches;

boolean buttonFlag = false; 
 
void setup() {
  //Serial Port begin
  Serial.begin (9600);
  //Define inputs and outputs
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);

  pinMode(buttonPin, INPUT_PULLUP);  
  
}

void loop() {
  // The sensor is triggered by a HIGH pulse of 10 or more microseconds.
  // Give a short LOW pulse beforehand to ensure a clean HIGH pulse:
  digitalWrite(trigPin, LOW);
  delayMicroseconds(5);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
 
  // Read the signal from the sensor: a HIGH pulse whose
  // duration is the time (in microseconds) from the sending
  // of the ping to the reiuhception of its echo off of an object.
  pinMode(echoPin, INPUT);
  duration = pulseIn(echoPin, HIGH);
 
  // Convert the time into a distance
  cm = (duration/2) / 29.1;     // Divide by 29.1 or multiply by 0.0343
  inches = (duration/2) / 74;   // Divide by 74 or multiply by 0.0135

  Serial.write(cm);

  boolean buttonState = digitalRead(buttonPin); 
   if (buttonState == LOW && buttonFlag == false) // LOW means button is pressed
   {
      Serial.write("e"); 
      delay(250);
      buttonFlag = true;
   } else if (buttonState == LOW && buttonFlag == true) 
   {
      Serial.write("y"); 
      delay(250);
      buttonFlag = false;
   }
  delay(250);
}
