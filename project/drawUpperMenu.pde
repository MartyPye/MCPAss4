
void drawUpperButtons()
{
    
    noFill();
    if(status==10) fill(color(150));
    beginShape();
    vertex(0,0);
    vertex(width/3,0);
    vertex(width/3+20,20);
    vertex(width/3,40);
    vertex(0,40);
    vertex(0,0);
    endShape();
    
    textSize(32);
    fill(255);
    text("DRAWING", 120, 30); 
    
    noFill();
    if(status==20) fill(color(150));
    beginShape();
    vertex(width/3,0);
    vertex(2*width/3,0);
    vertex(2*width/3+20,20);
    vertex(2*width/3,40);
    vertex(width/3,40);
    vertex(width/3+20,20);
    vertex(width/3,0);
    endShape();

    textSize(32);
    fill(255);
    text("RESIZING", 520, 30);
    
    noFill();
    if(status==30) fill(color(150));
    beginShape();
    vertex(2*width/3,0);
    vertex(width,0);
    vertex(width,20);
    vertex(width,40);
    vertex(2*width/3,40);
    vertex(2*width/3+20,20);
    vertex(2*width/3,0);
    endShape();
    
    textSize(32);
    fill(255);
    text("MOVING", 920, 30);
    
    
    
    noFill();
    if(kindOfObject == 0) fill(color(150));
    beginShape();
    vertex(width-160,60);
    vertex(width-20,60);
    vertex(width-20,100);
    vertex(width-160,100);
    vertex(width-160,60);
    endShape();
    
    textSize(24);
    fill(255);
    text("Polyline", width-140, 90);
    
    noFill();
    if(kindOfObject == 1) fill(color(150));
    beginShape();
    vertex(width-160,120);
    vertex(width-20,120);
    vertex(width-20,160);
    vertex(width-160,160);
    vertex(width-160,120);
    endShape();
    
    textSize(24);
    fill(255);
    text("Circle", width-140, 150);
    
}
