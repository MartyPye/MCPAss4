class Polyline extends Object {
  ArrayList vertices = new ArrayList();
  
  void drawSelf()
  {
     //TODO VERENA: CREATE MESH OF "VERTICES" AND "o_height" 
     //fill(255);
     noFill();
     beginShape();
     for(int i=0; i< vertices.size()-1; i++){
       PVector firstPoint = (PVector) vertices.get(i);
       PVector secondPoint = (PVector) vertices.get(i+1);
       vertex(firstPoint.x, firstPoint.y, 0);
       vertex(secondPoint.x, secondPoint.y, 0);
       vertex(firstPoint.x, firstPoint.y, this.o_height);
       vertex(secondPoint.x, secondPoint.y, this.o_height);
     }
     endShape();
     
     
     
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
