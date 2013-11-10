class Polyline extends Object {
  ArrayList vertices = new ArrayList();
  
  void drawSelf()
  {
     //TODO VERENA: CREATE MESH OF "VERTICES" AND "o_height" 
  }
  
  void addVertex(float pointX, float pointZ)
  {
      println("adding");
      vertices.add(new PVector(pointX,pointZ));
  }
  
  void drawLastPointIfInRange(int status) {
    if(status == 10) {
      PVector tempV = (PVector)vertices.get(0);
      float x = tempV.x;
      float y = tempV.y;
      if(abs(relXCoo(mouseX)-x)<5 && abs(relYCoo(mouseY)-y)<5 && vertices.size()>1)
      {
        ellipse(x, y, 10, 10);
      } 
    }
  }
  
  
}
