double countdown = 0.0;
int current = 0;

void clean(){
  shapes.clear();
  statics.clear();
  targets.clear();
}

void load1(){
  statics.add(factory.new_rect(20000, 200.0, new Vec2(1000, 1100.0),  0.0));
  
  shapes.add(factory.new_rect(50.0, 300.0, new Vec2(900, 849), 0.0));
  shapes.add(factory.new_rect(50.0, 300.0, new Vec2(1200, 849), 0.0));
  shapes.add(factory.new_tri(400.0, 100.0, new Vec2(1050, 655), PI));  
  
  targets.add(factory.new_rect(50.0, 50.0, new Vec2(1050, 850), 0.0));
}

void load2(){
  statics.add(factory.new_rect(20000, 200.0, new Vec2(0, 1100.0),  0.0));
  statics.add(factory.new_tri(200.0, 200.0, new Vec2(1500.0, 1000.0), PI));
  statics.add(factory.new_tri(200.0, 200.0, new Vec2(1000.0, 1000.0), PI));
  
  shapes.add(factory.new_rect(10.0, 600.0, 200.0, new Vec2(1250, 760), 0.0));
  
  targets.add(factory.new_rect(50.0, 50.0, new Vec2(1250, 950), 0.0));
}

void load3(){
  statics.add(factory.new_tri(200.0, 200.0, new Vec2(1500.0, 800.0), 0.0));
  statics.add(factory.new_tri(200.0, 200.0, new Vec2(1000.0, 1000.0), 0.0));
  statics.add(factory.new_tri(200.0, 200.0, new Vec2(1100.0, 600.0), 0.0));
  
  shapes.add(factory.new_rect(50.0, 300.0, new Vec2(1190, 360), 0.0));
  
  targets.add(factory.new_rect(50.0, 50.0, new Vec2(1500, 650), 0.0));
  targets.add(factory.new_rect(50.0, 50.0, new Vec2(1000, 850), 0.0));
  targets.add(factory.new_rect(50.0, 50.0, new Vec2(1100, 450), 0.0));
}

void load4(){
  statics.add(factory.new_rect(300.0, 200.0, new Vec2(1300, 1100), 0.0));
  statics.add(factory.new_tri(200.0, 500.0, new Vec2(1000.0, 900.0), PI));
  statics.add(factory.new_tri(200.0, 500.0, new Vec2(1500.0, 900.0), PI));
  
  shapes.add(factory.new_rect(40.0, 40.0, new Vec2(1200.0, 979.0), 0.0));
  shapes.add(factory.new_rect(40.0, 40.0, new Vec2(1200.0, 938.0), 0.0));
  shapes.add(factory.new_rect(40.0, 40.0, new Vec2(1200.0, 897.0), 0.0));
  
  shapes.add(factory.new_rect(40.0, 40.0, new Vec2(1350.0, 979.0), 0.0));
  shapes.add(factory.new_rect(40.0, 40.0, new Vec2(1350.0, 938.0), 0.0));
  shapes.add(factory.new_rect(40.0, 40.0, new Vec2(1350.0, 897.0), 0.0));
  
  shapes.add(factory.new_rect(190.0, 40.0, new Vec2(1275.0, 856.0), 0.0));
  
  targets.add(factory.new_rect(40.0, 40.0, new Vec2(1275.0, 979.0), 0.0));
  
  shapes.add(factory.new_rect(40.0, 40.0, new Vec2(1200.0, 815.0), 0.0));
  shapes.add(factory.new_rect(40.0, 40.0, new Vec2(1200.0, 774.0), 0.0));
  
  shapes.add(factory.new_rect(40.0, 40.0, new Vec2(1350.0, 815.0), 0.0));
  shapes.add(factory.new_rect(40.0, 40.0, new Vec2(1350.0, 774.0), 0.0));
  
  shapes.add(factory.new_rect(190.0, 40.0, new Vec2(1275.0, 733.0), 0.0));
  
  targets.add(factory.new_rect(40.0, 40.0, new Vec2(1275.0, 815.0), 0.0));
  
  
}

void loadNext(double delta){
  countdown -= delta;
  if (countdown <= 0.0){
    countdown = 5.0;
    current++;
    if (current == 1){
      clean();
      load1();
    }
    else if (current == 2){
      clean();
      load2();
    }
    else if (current == 3){
      clean();
      load3();
    }
    else if (current == 4){
      clean();
      load4();
    }
    else {
      
    }
  }
}
