class Projectile {
  PVector position, velocity;
  int damage;

  Projectile(PVector pos, PVector vel, int level) {
    position = pos;
    velocity = vel;
    damage = level;
  }

  void update() {
    position.add(velocity);
  }
  void display() {
    pushMatrix();
    translate(position.x, position.y);
    float angle = atan2(velocity.y, velocity.x);
    rotate(angle);
    fill(100);
    triangle(10, 0, 5, -3, 5, 3);
    fill(80);
    rect(0, -1.5, 5, 3);
    fill(150, 0, 0);
    triangle(0, -3, -3, 0, 0, 3);
    popMatrix();
  }
}
