class Object {
  
  float o_yPos, o_height;
  
  Object()
  {
    o_yPos = 0;
    o_height = 10;
  }
  
  ArrayList getVertices(){return null;}
  
  void saveSTL(){}
  
  void drawSelf(){}
  void drawSelfTemporary(){}
  
  void addVertex(float pointX, float pointZ){}
  void drawLastPointIfInRange(int status) {}
  void setHeight(float theHeight){}
  
  void addCenter(float pointX, float pointZ){}
  PVector getCenterOfCircle(){ return null;}
  void setRadius(float radius){}
  
}
