ArrayList<Shape> shapes;  
ArrayList<Shape> statics;
ArrayList<Shape> targets;
ShapeFactory factory;

Vec2 gravity = new Vec2(0.0, 150.0);
boolean state = false;

void setup(){
  size(1920, 1080);
  rectMode(CENTER);
  
  shapes = new ArrayList<Shape>();
  statics = new ArrayList<Shape>();
  targets = new ArrayList<Shape>();
  factory = new ShapeFactory();
  
  for (int i = 0; i < statics.size(); i++){
    statics.get(i).isStatic = true;
  }
}

void physics_update(double delta){
  for (int i = 0; i < shapes.size(); i++){
    apply_force(shapes.get(i), gravity.new_mul(shapes.get(i).mass), new Vec2(shapes.get(i).position.x,shapes.get(i).position.y-1));
    update_physics(shapes.get(i), delta);
    
    Vec2 center = new Vec2(1920.0/2.0, 1080.0/2.0);
    if (center.distanceTo(shapes.get(i).position) > 2500.0){
      shapes.remove(i);
    }
  }
}

void rigid_update(double delta){
  for (int i = 0; i < shapes.size(); i++){
    for (int j = i+1; j < shapes.size(); j++) {
      CollideInfo info1 = collide(shapes.get(i), shapes.get(j));
      if (info1.hit){
        resolveRigidCollision(shapes.get(i), shapes.get(j), info1);
      }
    }
  }
}

void static_update(double delta){
  for (int i = 0; i < shapes.size(); i++){
    for (int j = 0; j < statics.size(); j++) {
      CollideInfo info = collide(shapes.get(i), statics.get(j));
      if (info.hit){
        resolveStaticCollision(shapes.get(i), info);
      }
    }
  }
}

void target_update(){
  for (int i = 0; i < shapes.size(); i++){
    for (int j = 0; j < targets.size(); j++) {
      CollideInfo info1 = collide(shapes.get(i), targets.get(j));
      if (info1.hit){
        targets.remove(j);
      }
    }
  }
}

void draw(){
  double delta = 1.0/frameRate;
  println(frameRate);
  
  if (targets.size() == 0){
    loadNext(delta);
  }
  
  int subSteps = 100;
  for (int i = 0; i < subSteps; i++){
    
    static_update(delta/subSteps); //<>//
    rigid_update(delta/subSteps);
    physics_update(delta/subSteps);
    target_update();
  }
  
  background(color(119, 166, 237));
  
  for (int i = 0; i < shapes.size(); i++){
    fill(153);
    pushMatrix();
    translate((float)shapes.get(i).position.x, (float)shapes.get(i).position.y);
    rotate((float)shapes.get(i).angle);
    //rect(0, 0, 200, 200);
    beginShape();
    for (int j = 0; j < shapes.get(i).numVertices; j++){
      vertex((float)shapes.get(i).vertices[j].x, (float)shapes.get(i).vertices[j].y);
    }
    endShape(CLOSE);
    circle(0.0, 0.0, 5);
    popMatrix();
  }
  
  for (int i = 0; i < statics.size(); i++){
    fill(color(50, 175, 80));
    pushMatrix();
    translate((float)statics.get(i).position.x, (float)statics.get(i).position.y);
    rotate((float)statics.get(i).angle);
    //rect(0, 0, 200, 200);
    beginShape();
    for (int j = 0; j < statics.get(i).numVertices; j++){
      vertex((float)statics.get(i).vertices[j].x, (float)statics.get(i).vertices[j].y);
    }
    endShape(CLOSE);
    popMatrix();
  }
  
  for (int i = 0; i < targets.size(); i++){
    fill(color(255, 204, 0));
    pushMatrix();
    translate((float)targets.get(i).position.x, (float)targets.get(i).position.y);
    rotate((float)targets.get(i).angle);
    //rect(0, 0, 200, 200);
    beginShape();
    for (int j = 0; j < targets.get(i).numVertices; j++){
      vertex((float)targets.get(i).vertices[j].x, (float)targets.get(i).vertices[j].y);
    }
    endShape(CLOSE);
    popMatrix();
  }
  
  if (drawArrow){
    int len = min(maxLen, (int)start.distanceTo(end));
    float angle = (float) angleBetween(end.new_sub(start), new Vec2(1, 0));
    if (end.y > start.y){
      angle *= -1;
    }
    drawArrow((int) start.x, (int) start.y, len, -angle);
  }
}
