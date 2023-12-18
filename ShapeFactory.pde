public class Shape {
  public int numVertices;
  public Vec2[] vertices;
  public Vec2 position;
  public Vec2 momentum = new Vec2(0,0);
  public double angular_momentum;
  public double angle;
  public double mass = 1.0;
  public double inertia = mass*(200*200+200*200)/12;
  public boolean isStatic = false;
  public CollideInfo info = new CollideInfo();
  public double total_torque;
  public Vec2 total_force = new Vec2(0,0);
  
  public Shape(int numVertices, Vec2[] vertices, Vec2 position, float angle){
    this.numVertices = numVertices;
    this.vertices = vertices;
    this.position = position;
    this.angle = angle;
  }
  
  public Vec2[] global(){
    Vec2[] global = new Vec2[this.numVertices];
    double theta = this.angle;
    for (int i = 0; i < this.numVertices; i++){
      global[i] = new Vec2(this.vertices[i].x, this.vertices[i].y);
      double temp_x = global[i].x;
      double temp_y = global[i].y;
      global[i].x = temp_x * Math.cos(theta) - temp_y * Math.sin(theta);
      global[i].y = temp_x * Math.sin(theta) + temp_y * Math.cos(theta);
      global[i].add(this.position);
    }
    return global;
  }
}

public class ShapeFactory {
  public ShapeFactory(){
    
  }
  
  public Shape new_shape(int numVertices, double width, double height, Vec2 pos, float angle){
    Vec2 vertices[] = new Vec2[numVertices];
    
    double theta = 2.0 * Math.PI / (double)numVertices;
    double rotation = theta / 2.0;
    
    for (int i = 0; i < numVertices; i++){
      double currentRotation = rotation + theta * (numVertices - 1 - i);
      
      double x = width/2.0 * Math.cos(currentRotation);
      double y = height/2.0 * Math.sin(currentRotation);;
      vertices[i] = new Vec2(x, y);
    }
    return new Shape(numVertices, vertices, pos, angle);
  }
  
  public Shape new_rect(double w, double h, Vec2 pos, float angle){
    Vec2 vertices[] = new Vec2[4];
    vertices[0] = new Vec2(w/2.0, h/2.0);
    vertices[1] = new Vec2(w/2.0, -h/2.0);
    vertices[2] = new Vec2(-w/2.0, -h/2.0);
    vertices[3] = new Vec2(-w/2.0, h/2.0);
    Shape output = new Shape(4, vertices, pos, angle);
    output.inertia = output.mass*(w*w+h*h)/12;
    return output;
  }
  
  public Shape new_rect(double mass, double w, double h, Vec2 pos, float angle){
    Vec2 vertices[] = new Vec2[4];
    vertices[0] = new Vec2(w/2.0, h/2.0);
    vertices[1] = new Vec2(w/2.0, -h/2.0);
    vertices[2] = new Vec2(-w/2.0, -h/2.0);
    vertices[3] = new Vec2(-w/2.0, h/2.0);
    Shape output = new Shape(4, vertices, pos, angle);
    output.mass = mass;
    output.inertia = output.mass*(w*w+h*h)/12;
    return output;
  }
  
  public Shape new_tri(double w, double h, Vec2 pos, float angle){
    Vec2 vertices[] = new Vec2[3];
    vertices[0] = new Vec2(0.0, 3*h/5.0);
    vertices[1] = new Vec2(w/2.0, -2*h/5.0);
    vertices[2] = new Vec2(-w/2.0, -2*h/5.0);
    Shape output = new Shape(3, vertices, pos, angle);
    output.inertia = output.mass*(w*w+h*h)/12;
    return output;
  }
}
