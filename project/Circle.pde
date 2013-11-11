class Circle extends Object {
  float o_radius;
  PVector o_center;
  
  void drawSelf()
  {
      AxisAlignedCylinder cyl = new ZAxisCylinder(new Vec3D(o_center.x,o_center.y,0),o_radius,o_height);
      gfx.cylinder(cyl,20,false);
  }
  
  void drawSelfTemporary()
  {
    float tempRadius = (int)sqrt(pow(o_center.x-relXCoo(mouseX),2)+pow(o_center.y-relYCoo(mouseY),2));
      AxisAlignedCylinder cyl = new ZAxisCylinder(new Vec3D(o_center.x,o_center.y,o_yPos),tempRadius,o_height);
      gfx.cylinder(cyl,20,false);
  }

  
  void addCenter(float pointX, float pointZ)
  {
      o_center = new PVector(pointX, pointZ);
  }
  
  void setRadius(float radius)
  {
      o_radius = radius;
  }
  
  PVector getCenterOfCircle()
  {
    return o_center;
  }

  
  /*
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
  
  void setHeight(float theHeight)
  {
    this.o_height = theHeight; 
    for (int i = 1; i < vertices.size(); i += 2) {
      PVector currentPoint = (PVector)vertices.get(i);
      currentPoint.z = this.o_height;
      vertices.set(i, currentPoint);  
    }
  }
  */
  
}
