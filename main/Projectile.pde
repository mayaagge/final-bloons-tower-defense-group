class Projectile {
  PVector position, velocity;
  int damage;
  int pierce;
  int attkRadius;

  Projectile(PVector pos, PVector vel, int damage, int pierce, int attkRadius) {
    position = pos;
    velocity = vel;
    this.damage = damage;
    this.pierce = pierce;
    this.attkRadius = attkRadius;
  }

  void update(ArrayList<Bloon> newBloons) {
    position.add(velocity);
    for (int i = 0; i < bloons.size(); i++) {
      Bloon b = bloons.get(i);
      if (!b.popped && !b.reachedEnd && position.dist(b.position) < attkRadius) {
        b.lowerHealth(damage, newBloons);
        pierce--;
        if (pierce <= 0) break;
      }
    }
  }

  int getPierce() {
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
}
