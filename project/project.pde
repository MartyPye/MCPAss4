import toxi.geom.*;
import toxi.geom.mesh.*;
import java.util.Iterator;
//import peasy.*;
import toxi.processing.*;
import processing.serial.*;



// THE DIFFERENT STATUSES:
//  0: Waiting that the first thing is getting drawn
// 10: Currently drawing
// 20: Currently resizing the height of the object
// 30: Currently setting the yPos of the object
int status;
int kindOfObject;

Object currentObject;
ArrayList objects = new ArrayList();
Vec2D rotation=new Vec2D();
ToxiclibsSupport gfx;

Serial myPort;  // Create object from Serial class


void setup()
{
  size(1200, 800, P3D);
  status = 0;
  kindOfObject = 0;
  gfx=new ToxiclibsSupport(this);
  
  String portName = Serial.list()[5]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
}


void draw()
{
  background(200);
  drawUpperButtons();
  lights();

  translate(width/2,height/2,0);
  rotateX(rotation.x);
  rotateY(rotation.y);

  //Draw all the objects we have
  for (int objectNr=0; objectNr<objects.size();objectNr++)
  {
    Object tempObject = (Object)objects.get(objectNr);
    if (status == 20) {
      float handHeight = getSensorValue();
      if (handHeight != 0) {
        tempObject.setHeight(10*handHeight);
        println("setting height to" + handHeight);
      }
    }
    tempObject.drawSelf();
  }

  if (currentObject != null) {
//    currentObject.drawSelf();
    currentObject.drawSelfTemporary();
    currentObject.drawLastPointIfInRange(status);
  }

}

float relXCoo(int x)
{
  return x-width/2;
}

float relYCoo(int y)
{
  return y-height/2;
}

void mouseClicked() {
  if (status == 0) {
    if(mouseX>width-160 && mouseX<width-20 && mouseY>60 && mouseY<100)
    {
       //We selected the Polyline
       kindOfObject = 0;
    } else if(mouseX>width-160 && mouseX<width-20 && mouseY>120 && mouseY<160)
    {
       //We selected the Circle
       kindOfObject = 1;
    } else if(kindOfObject == 0){
      println("WE CREATE A POLYLINE");
      println("First Vertex set");
      status = 10;
      currentObject = new Polyline();
      currentObject.addVertex(relXCoo(mouseX), relYCoo(mouseY));
    } else {
      println("WE CREATE A CIRCLE");
      println("Center set");
      currentObject = new Circle();
      currentObject.addCenter(relXCoo(mouseX), relYCoo(mouseY));
      status = 11;
    }
  } 
  else if (status == 10) {
    Polyline temp = (Polyline)currentObject;
    PVector tempV = (PVector)temp.vertices.get(0);
    float x = tempV.x;
    float y = tempV.y;
    if (abs(relXCoo(mouseX)-x)<5 && abs(relYCoo(mouseY)-y)<5 && temp.vertices.size()>1)
    {
      currentObject.addVertex(x, y);
      objects.add(currentObject);
      currentObject = null;
      status = 20;
      
      rotation.addSelf(PI/2.0,0);
      //camera(width/2.0, height, (height/2.0) / tan(PI*70.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
    } else {
      currentObject.addVertex(relXCoo(mouseX),relYCoo(mouseY));
    } 
  } 
  else if (status == 11) {
    PVector temp = (PVector)currentObject.getCenterOfCircle();
    float distance = (int)sqrt(pow(temp.x-relXCoo(mouseX),2)+pow(temp.y-relYCoo(mouseY),2));
    currentObject.setRadius(distance);
    objects.add(currentObject);
    currentObject = null;
    status = 20;
    rotation.addSelf(PI/2.0,0);
  } 
  else {
    //NOTHING
    //In the other 2 states there is no mouse action
  }
}

void keyPressed() {
  if (key==ENTER) {
    //mesh.saveAsOBJ(sketchPath("doodle.obj"));
    //mesh.saveAsSTL(sketchPath("doodle.stl"));
    if (status == 20) {
      //We finished setting the height of our current object

      //currentObject.o_height = What we get from the Arduino
      status = 30;
    } 
    else if (status == 30) {
      //We finished setting the y-Position of our current object

      //currentObject.o_yPos = What we get from the Arduino
      //    OR what we defined with the arrow-keys

      //objects.add(currentObject);
      status = 0;

      
      rotation.addSelf(-PI/2.0,0);
      //camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
    } else {
       //NOTHING 
       //In the other states we don't deal with ENTER

      //TODO: SET CAMERA TO THE TOP AGAIN
    } 
  }else if(key == 's' && status >= 20){
    
    for (int objectNr=0; objectNr<objects.size();objectNr++)
    {
      Object tempObject = (Object)objects.get(objectNr);
      tempObject.saveSTL();
    }
  }
}

  

float getSensorValue()
{
  float value = 0;
  
  if (myPort.available() > 0) {
      //    val = myPort.readBytesUntil('\n');    // read it and store it in val
      try {
        float bla = float(new String(myPort.readBytesUntil('\n')));
        println(bla); //print it out in the console
        value = bla;
      }
      catch (Exception e) {
      }
    }
  
  return value;  
    
}

