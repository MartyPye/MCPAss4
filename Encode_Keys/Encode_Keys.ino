#include <FreeSixIMU.h>
#include <FIMU_ADXL345.h>
#include <FIMU_ITG3200.h>

#include <Wire.h>

//define mappings for function keys
#define POS 0x3B //F2
#define NEG 0x3C //F3
#define AXIS_X 0x3D //F4
#define AXIS_Y 0x3E //F5
#define AXIS_Z 0x3F //F6
#define VAL_0 0x40 //F7 & 0
#define VAL_1 0x41 //F8 & 1
#define VAL_2 0x42 //F9 & 2
#define VAL_3 0x43 //F10 & 3
#define VAL_4 0x44 //F11 & 4

float angles[3]; // store Euler angles
float oldAngles[3] = {0,0,0}; // save Euler Angles
byte encodedArray[4] = {0x40, 0x40, 0x40, 0x40};
int changeX, changeY, changeZ; // Store changes in Axes

// Set the FreeSixIMU object
FreeSixIMU sixDOF = FreeSixIMU();

uint8_t buf[8] = { 
  0 }; 

void setup() 
{
  Serial.begin(115200);
  delay(200);
  Wire.begin();

  delay(5);
  sixDOF.init(); //begin the IMU
  delay(5);

}


void loop() 
{
  delay(500);
  sixDOF.getEuler(angles);
  
  //Get the changes in Angles in 500 ms 
  changeX = -angles[2]-oldAngles[0];
  changeY = angles[1]-oldAngles[1];
  changeZ = angles[0]-oldAngles[2];
  
  //Check and update angle values if change in any direction is more than 5
  if (abs(changeX) > 5 || abs(changeY) > 5 || abs(changeZ) > 5) {
    updateAngles(-angles[2],angles[1],angles[0]);
  }

}

//check direction of maximum change and send keyboard encoding
void updateAngles(int x, int y, int z)
{

  int newBaseValue;
  
  //get the maximum 
  int maximum = max(abs(changeX),max(abs(changeY),abs(changeZ)));

  if(abs(changeX) == maximum)
  {
    //change value to new base(5)
    newBaseValue = changeBase(abs(changeX));
    
    //encode value in new base to Function keys given in #define
    encodeValue(newBaseValue);
    if(x < 0)
    {

      press(NEG, AXIS_X, encodedArray[3], encodedArray[2], encodedArray[1], encodedArray[0]); 
    }
    else
    {

      press(POS, AXIS_X, encodedArray[3], encodedArray[2], encodedArray[1], encodedArray[0]);
    }
  }
  else if(abs(changeY) == maximum)
  {
    newBaseValue = changeBase(abs(changeY));
    encodeValue(newBaseValue);
    if(y < 0)
    {

      press(NEG, AXIS_Y, encodedArray[3], encodedArray[2], encodedArray[1], encodedArray[0]); 
    }
    else
    {

      press(POS, AXIS_Y, encodedArray[3], encodedArray[2], encodedArray[1], encodedArray[0]); 
    }
  } 
  else if(abs(changeZ) == maximum)
  {
    newBaseValue = changeBase(abs(changeZ));
    encodeValue(newBaseValue);
    if(z < 0)
    {

      press(NEG, AXIS_Z, encodedArray[3], encodedArray[2], encodedArray[1], encodedArray[0]); 
    }
    else
    {

      press(POS, AXIS_Z, encodedArray[3], encodedArray[2], encodedArray[1], encodedArray[0]);
    }
  }  
  
  //Update stored angle array
  oldAngles[0] = x;
  oldAngles[1] = y;
  oldAngles[2] = z;

}


//Convert number to a new base(5)
int changeBase(int changeAngle){

  int rem, i=1, newBase=0;
  while (changeAngle!=0)
  {
    rem=changeAngle%5;
    changeAngle/=5;
    newBase+=rem*i;
    i*=10;
  }
  return newBase;    
}  

//Encode values as Function keys
void encodeValue(int value){
  int valueDigit;
//  
//    if (value <= 4){
//      encodedArray[1] = VAL_0;
//      encodedArray[2] = VAL_0;
//      encodedArray[3] = VAL_0;
//    }
//      else if (value > 4 && value <= 44){
//      encodedArray[2] = VAL_0;
//      encodedArray[3] = VAL_0;
//    }
//      else if (value > 44 && value <= 444){
//      encodedArray[3] = VAL_0;
//    }
      
  for (int i=0; i<4; i++){
    valueDigit = value%10;
    switch (valueDigit){
    case 0:
      encodedArray[i] = VAL_0;
      break;

    case 1: 
      encodedArray[i] = VAL_1;
      break;

    case 2:
      encodedArray[i] = VAL_2;
      break;

    case 3:
      encodedArray[i] = VAL_3;
      break;

    case 4:
      encodedArray[i] = VAL_4;
      break;
    
    default:
      encodedArray[i] = 0x04; //Check for Errors
      break;
    }
    value = value/10;
  }

}

//send raw HID report
void press(byte dir, byte axis, byte val1, byte val2, byte val3, byte val4)
{
  byte nullByte = 0x0;

  Serial.write(0xFD);
  Serial.write(0x9);
  Serial.write(0x1);
  Serial.write(0x06); //ALT & SHIFT
  Serial.write(nullByte);
  Serial.write(dir);
  Serial.write(axis);
  Serial.write(val1);
  Serial.write(val2);
  Serial.write(val3);
  Serial.write(val4);  
  
  Serial.write(0xFD);
  Serial.write(0x9);
  Serial.write(0x1);
  Serial.write(nullByte);
  Serial.write(nullByte);
  Serial.write(nullByte);
  Serial.write(nullByte);
  Serial.write(nullByte);
  Serial.write(nullByte);
  Serial.write(nullByte);
  Serial.write(nullByte);    
}

