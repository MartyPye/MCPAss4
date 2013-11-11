class Polyline extends Object {
  ArrayList vertices = new ArrayList();
  
  void drawSelf()
  {
     //TODO VERENA: CREATE MESH OF "VERTICES" AND "o_height" 
     //fill(255);
     noFill();
     beginShape();
     for(int i=0; i< vertices.size()-2; i++){
       PVector firstPoint = (PVector) vertices.get(i);
       PVector secondPoint = (PVector) vertices.get(i+1);
       PVector thirdPoint = (PVector) vertices.get(i+2);
       vertex(firstPoint.x, firstPoint.y, firstPoint.z);
       vertex(secondPoint.x, secondPoint.y, secondPoint.z);
       vertex(firstPoint.x, firstPoint.y, firstPoint.z);
       vertex(thirdPoint.x, thirdPoint.y, thirdPoint.z);
       vertex(secondPoint.x, secondPoint.y, secondPoint.z);
       vertex(thirdPoint.x, thirdPoint.y, thirdPoint.z);
     }
     endShape();
     
     
     
  }
  
  void addVertex(float pointX, float pointZ)
  {
      println("adding");
      vertices.add(new PVector(pointX, pointZ, 0));
      vertices.add(new PVector(pointX, pointZ, this.o_height));
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
