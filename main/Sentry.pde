class Sentry {
  PVector position;
  int cooldown = 20;
  int timer = 0;
  int lifetime = 300;
  float range = 150;
  Monkey parent; 

  Sentry(PVector pos, Monkey parent) {
    this.position = pos.copy();
    this.parent = parent;
  }

  void update(ArrayList<Bloon> bloons, ArrayList<Projectile> projectiles) {
    lifetime--;
    if (timer > 0) timer--;
    else {
      for (Bloon b : bloons) {
        if (!b.popped && !b.reachedEnd && position.dist(b.position) <= range) {
          PVector vel = PVector.sub(b.position, position).normalize().mult(10);
          projectiles.add(new Projectile(position.copy(), vel, 1, 1, 25));
          timer = cooldown;
          break;
        }
      }
    }
  }

  void display() {
    fill(50, 150, 255);
    stroke(0);
    ellipse(position.x, position.y, 20, 20);
  }
}
