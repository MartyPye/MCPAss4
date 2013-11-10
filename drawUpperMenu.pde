
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
    
    
}
