#include <Servo.h>
#include <PID_v1.h>

// Constants
const int servoPin = 9;
const int trigPin = 6;      // Trig pin for ultrasonic sensor
const int echoPin = 5;      // Echo pin for ultrasonic sensor
const int centerDistance = 15;  // Desired distance to keep the ball centered
const int totalLength = 29;     // Total length of the balance track

// PID parameters
double Kp = 3, Ki = 0, Kd = 1;  // Adjusted Ki and Kd
double Setpoint, Input, Output;
int prevdist = -1;
// Servo and PID objects
Servo myServo;
PID myPID(&Input, &Output, &Setpoint, Kp, Ki, Kd, DIRECT);

// Function to read the ball position (distance) from the ultrasonic sensor
int readPosition() {
  int duration, distance;
  
  // Send trig pulse
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
  
  // Measure echo pulse width
  duration = pulseIn(echoPin, HIGH);
  
  // Calculate distance
  distance = duration * 0.034 / 2;
//  distance = constrain(distance, 0, totalLength);  // Ensure distance is within valid range
  if(prevdist!=-1 && abs(distance-prevdist)>10){distance = prevdist;}
  prevdist = distance;
  return distance;
}

// Initial setup
void setup() {
  Serial.begin(9600);
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  myServo.attach(servoPin);
  Setpoint = centerDistance;  // Center position for the ball
  myPID.SetMode(AUTOMATIC);
  myPID.SetOutputLimits(-45, 45);  // Ensure sufficient range for correction
  
  // Debugging setup
  Serial.println("PID Control Initialized");
  Serial.println("------------------------");
  Serial.println("Distance (cm)\tSetpoint\tError\tPID Output\tServo Position");
}

// Main loop
void loop() {
  // Read the ball position
  Input = readPosition();  // Use direct position as input
  
  // Compute the PID output
  myPID.Compute();

  // Map PID output to servo angle range (centered at 90°)
  double ServoOutput = 90 - Output;  
  ServoOutput = constrain(ServoOutput, 30, 150);  // Servo range
  
  // Move the servo to the computed position
  myServo.write(ServoOutput);

  // Print debug information
  Serial.print(Input);
  Serial.print("\t\t");
  Serial.print(Setpoint);
  Serial.print("\t\t");
  Serial.print(Input - Setpoint);  // Error
  Serial.print("\t\t");
  Serial.print(Output);
  Serial.print("\t\t");
  Serial.println(ServoOutput);
  
  // Delay for stability
  delay(50);
}