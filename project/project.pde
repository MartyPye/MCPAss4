import toxi.geom.*;
import toxi.geom.mesh.*;
import java.util.Iterator;

// THE DIFFERENT STATUSES:
//  0: Waiting that the first thing is getting drawn
// 10: Currently drawing
// 20: Currently resizing the height of the object
// 30: Currently setting the yPos of the object
int status;

Object currentObject;
ArrayList objects = new ArrayList();
Vec2D rotation=new Vec2D();


void setup()
{
    size(1200,800,P3D);
    status = 0;
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
  for(int objectNr=0; objectNr<objects.size();objectNr++)
  {
    Object tempObject = (Object)objects.get(objectNr);
    tempObject.drawSelf();
    
  }
  
  if(currentObject != null){
     currentObject.drawSelf();
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
  if(status == 0){
    println("First Vertex set");
    status = 10;
    currentObject = new Polyline();
    currentObject.addVertex(relXCoo(mouseX),relYCoo(mouseY));
  } else if (status == 10){
    Polyline temp = (Polyline)currentObject;
    PVector tempV = (PVector)temp.vertices.get(0);
    float x = tempV.x;
    float y = tempV.y;
    if(abs(relXCoo(mouseX)-x)<5 && abs(relYCoo(mouseY)-y)<5 && temp.vertices.size()>1)
    {
      currentObject.addVertex(x,y);
      objects.add(currentObject);
      currentObject = null;
      status = 20;
      
      rotation.addSelf(PI/2.0,0);
      //camera(width/2.0, height, (height/2.0) / tan(PI*70.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
    } else {
      currentObject.addVertex(relXCoo(mouseX),relYCoo(mouseY));
    }
  } else {
    //NOTHING
    //In the other 2 states there is no mouse action
  }
  
}

void keyPressed() {
  if (key==ENTER) {
    //mesh.saveAsOBJ(sketchPath("doodle.obj"));
    //mesh.saveAsSTL(sketchPath("doodle.stl"));
    if(status == 20){
      //We finished setting the height of our current object
      
      //currentObject.o_height = What we get from the Arduino
      status = 30; 
    } else if(status == 30){
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
    }
  } 
}
