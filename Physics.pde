double e = 0.5;

void apply_force(Shape shape, Vec2 force, Vec2 applied_position){
  shape.total_force.add(force);
  Vec2 displacement = applied_position.new_sub(shape.position);
  shape.total_torque += cross(displacement,force);
}

void apply_friction(Shape s1, Shape s2, CollideInfo info){
  Vec2 v1 = s1.momentum.new_mul(1.0/s1.mass);
  Vec2 v2 = s2.momentum.new_mul(1.0/s2.mass);
  Vec2 relative_dir = v1.new_sub(v2).new_normalize();
  
  double magnitude = 10.0;
  Vec2 f1 = relative_dir.new_mul(-magnitude * s1.mass);
  Vec2 f2 = relative_dir.new_mul(magnitude * s2.mass);
  
  apply_force(s1, f1, info.hitPoint);
  apply_force(s2, f2, info.hitPoint);
}

void update_physics(Shape shape, double dt){
  shape.momentum.add(shape.total_force.new_mul(dt));
  Vec2 box_vel = shape.momentum.new_mul(1.0/shape.mass); 
  shape.position.add(box_vel.new_mul(dt));
  
    shape.angular_momentum += shape.total_torque * dt;
    double angular_velocity = shape.angular_momentum / shape.inertia;
    shape.angle += angular_velocity * dt;
  
  shape.total_force = new Vec2(0,0);
  shape.total_torque = 0.0;
}




void resolveStaticCollision(Shape shape, CollideInfo info){
  Vec2 r = info.hitPoint.new_sub(shape.position);
  Vec2 r_perp = perpendicular(r);
  Vec2 object_vel = shape.momentum.new_mul(1/shape.mass);
  double object_angular_speed = shape.angular_momentum/shape.inertia;
  Vec2 point_vel = object_vel.new_add(r_perp.new_mul(object_angular_speed));
  double j = -(1+e)*dot(point_vel, info.objectNormal);
  j /= (1/shape.mass + pow((float)dot(r_perp,info.objectNormal),2)/shape.inertia);

 
  Vec2 impulse = info.objectNormal.new_mul(j);
  shape.momentum.add(impulse);
  shape.angular_momentum += dot(r_perp,impulse);
  shape.position.add(info.objectNormal.new_mul(info.distance));
}

void resolveRigidCollision(Shape shape1, Shape shape2, CollideInfo info){
  Vec2 r1 = info.hitPoint.new_sub(shape1.position);
  Vec2 r_perp1 = perpendicular(r1);
  Vec2 r2 = info.hitPoint.new_sub(shape2.position);
  Vec2 r_perp2 = perpendicular(r2);
  Vec2 vAB = shape1.momentum.new_mul(1.0/shape1.mass).new_sub(shape2.momentum.new_mul(1.0/shape2.mass));
  double j = -(1+e)*dot(vAB,info.objectNormal);
  j /= (1/shape1.mass + 1/shape2.mass) * pow((float)dot(info.objectNormal,info.objectNormal),2)
  +(pow((float)dot(r_perp1, info.objectNormal), 2))/shape1.inertia+(pow((float)dot(r_perp1, info.objectNormal), 2))/shape2.inertia;
 
  Vec2 impulse = info.objectNormal.new_mul(j);
  shape1.momentum.add(impulse);
  shape1.angular_momentum += dot(r_perp1,impulse);
  
  impulse = info.objectNormal.new_mul(-j);
  shape2.momentum.add(impulse);
  shape2.angular_momentum += dot(r_perp2,impulse);
  
  shape1.position.add(info.objectNormal.new_mul(info.distance/2.0));
  shape2.position.add(info.objectNormal.new_mul(-info.distance/2.0));
}
