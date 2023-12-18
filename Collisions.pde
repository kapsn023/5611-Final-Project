class CollideInfo{
  public boolean hit = false;
  public Vec2 hitPoint = new Vec2(0,0);
  public Vec2 objectNormal =  new Vec2(0,0);
  public double distance = Double.MAX_VALUE;
}

public Vec2 normal(Vec2 p1, Vec2 p2){
  return new Vec2(-(p2.y - p1.y), p2.x - p1.x);
}

public CollideInfo collide(Shape s1, Shape s2){
  Vec2[] globals1 = s1.global();
  Vec2[] globals2 = s2.global();
  
  CollideInfo infoMax1 = new CollideInfo();
  CollideInfo infoMin1 = new CollideInfo();
  CollideInfo output = infoMax1;
  Vec2 maxPos = new Vec2(0, 0);
   Vec2 minPos = new Vec2(0, 0);
  
  for (int i = 0; i < s1.numVertices; i++){
    Vec2 normal;
    double max1, min1, max2, min2;
    if (i < s1.numVertices-1){
      normal = normal(globals1[i], globals1[i + 1]);
    }
    else {
      normal = normal(globals1[i], globals1[0]);
    }
    normal.normalize();
    max1 = -Double.MAX_VALUE;
    min1 = Double.MAX_VALUE;
    max2 = -Double.MAX_VALUE;
    min2 = Double.MAX_VALUE;
    // Find shape1's max and min points on current normal.
    for (int j = 0; j < s1.numVertices; j++){
      double candidate = dot(globals1[j], normal);
      if (candidate > max1) {
        max1 = candidate;
      }
      if (candidate < min1) {
        min1 = candidate;
      }
    }
    // Find shape2's max and min points on current normal.
    for (int j = 0; j < s2.numVertices; j++){
      double candidate = dot(globals2[j], normal);
      if (candidate > max2) {
        max2 = candidate;
        maxPos = globals2[j];
      }
      if (candidate < min2) {
        min2 = candidate;
        minPos = globals2[j];
      }
    }
    // Compare mins and maxs
    if (min1 > max2 || min2 > max1){
      infoMax1.hit = false;
      return infoMax1;
    }
    if (infoMax1.distance > (max2 - min1)){
      infoMax1.distance = (max2 - min1);
      infoMax1.objectNormal = new Vec2(normal.x, normal.y);
      infoMax1.hitPoint = new Vec2(maxPos.x, maxPos.y);
    }
    
    if (infoMin1.distance > (max1 - min2)){
      infoMin1.distance = (max1 - min2);
      infoMin1.objectNormal = new Vec2(normal.x, normal.y);
      infoMin1.hitPoint = new Vec2(minPos.x, minPos.y);
    }
    
  }
  for (int i = 0; i < s2.numVertices; i++){
    Vec2 normal;
    double max1, min1, max2, min2;
    if (i < s2.numVertices-1){
      normal = normal(globals2[i], globals2[i + 1]);
    }
    else {
      normal = normal(globals2[i], globals2[0]);
    }
    normal.normalize();
    max1 = -Double.MAX_VALUE;
    min1 = Double.MAX_VALUE;
    max2 = -Double.MAX_VALUE;
    min2 = Double.MAX_VALUE;
    // Find shape1's max and min points on current normal.
    for (int j = 0; j < s1.numVertices; j++){
      double candidate = dot(globals1[j], normal);
      if (candidate > max1) {
        max1 = candidate;
        maxPos = globals1[j];
      }
      if (candidate < min1) {
        min1 = candidate;
        minPos = globals1[j];
      }
    }
    // Find shape2's max and min points on current normal.
    for (int j = 0; j < s2.numVertices; j++){
      double candidate = dot(globals2[j], normal);
      if (candidate > max2) {
        max2 = candidate;
      }
      if (candidate < min2) {
        min2 = candidate;
      }
    }
    // Compare mins and maxs
    if (min1 > max2 || min2 > max1){
      infoMax1.hit = false;
      return infoMax1;
    }
    if (infoMax1.distance > (max1 - min2)){
      infoMax1.distance = (max1 - min2);
      infoMax1.objectNormal = new Vec2(normal.x, normal.y);
      infoMax1.hitPoint = new Vec2(maxPos.x, maxPos.y);
    }
    
    if (infoMin1.distance > (max2 - min1)){
      infoMin1.distance = (max2 - min1);
      infoMin1.objectNormal = new Vec2(normal.x, normal.y);
      infoMin1.hitPoint = new Vec2(minPos.x, minPos.y);
    }
    
  }
  double push = 1.0;
  if (infoMax1.distance < infoMin1.distance){
    output = infoMax1;
  }
  else if (infoMin1.distance <= infoMax1.distance){
    output = infoMin1;
  }
  if (dot((s1.position.new_sub(s2.position).new_normalize()), output.objectNormal) < 0){
      output.objectNormal.mul(-1);
  }
  
  apply_friction(s1, s2, output);
  output.hit = true;
  return output;
}
