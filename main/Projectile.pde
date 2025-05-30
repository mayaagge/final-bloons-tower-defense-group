class Projectile {
  PVector position, velocity;
  int damage;
  int pierce;
  int attkRadius;

  Projectile(PVector pos, PVector vel, int level, int pierce, int attkRadius) {
    position = pos;
    velocity = vel;
    damage = level;
    this.pierce = pierce;
    this.attkRadius = attkRadius;
  }

  void update() {
    position.add(velocity);
    for (Bloon b : bloons) {
      if (position.dist(b.position) < attkRadius) {
        b.lowerHealth(1);
        pierce--;
      }
    }
  }
  
  int getPierce(){
    return pierce;
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
  
  boolean hits(Bloon b) {
    return position.dist(b.position) < attkRadius;
  }
}
