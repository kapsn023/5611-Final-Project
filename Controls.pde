boolean atStart = true;
boolean drawArrow = false;
Vec2 start = new Vec2(0,0);
Vec2 end = new Vec2(0,0);

int maxLen = 500;
Vec2 chamber = new Vec2(10, 930);

void shoot(){
  int len = min(maxLen, (int)start.distanceTo(end));
  Vec2 trajectory = end.new_sub(start);
  trajectory.normalize();
  trajectory.mul(len);
  
  Shape projectile = factory.new_rect(40.0, 40.0, new Vec2(chamber.x, chamber.y), -PI/2); 
  projectile.mass = 0.5;
  projectile.momentum = trajectory.new_mul(projectile.mass);
  //projectile.angular_momentum =  projectile.inertia;
  shapes.add(projectile);
}

void mouseDragged(){
  drawArrow = true;
  if (atStart){
      start = new Vec2((double)mouseX, (double)mouseY);
    atStart = false;
  }
  else{
    end = new Vec2((double)mouseX, (double)mouseY);
  }
}

void mouseReleased(){
  drawArrow = false;
  atStart = true;
  
  end = new Vec2((double)mouseX, (double)mouseY);
  shoot();
}


void drawArrow(int cx, int cy, int len, float angle){
  pushMatrix();
  translate((float) chamber.x, (float) chamber.y);
  rotate(angle);
  line(len,0,0, 0);
  translate(len, 0);
  line(0, 0,  - 8, -8);
  line(0, 0,  - 8, 8);
  popMatrix();
}
