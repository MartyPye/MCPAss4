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
  
  
}
