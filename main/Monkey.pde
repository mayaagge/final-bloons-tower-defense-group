class Monkey {
  PVector position;
  float range = 200;
  int cooldown = 9, timer = 0;
  PImage img;

  Monkey(PImage img, float x, float y) {
    this.img = img;
    this.position = new PVector(x, y);
  }

  void update(ArrayList<Bloon> bloons, ArrayList<Projectile> projectiles) {
    if (timer > 0) {
      timer--;
      return;
    }
    for (Bloon b : bloons) {
      if (position.dist(b.position) < range) {
        PVector vel = PVector.sub(b.position, position).normalize().mult(5);
        projectiles.add(new Projectile(position.copy(), vel, 10, 1, 25));
        timer = cooldown;
        break;
      }
    }
  }

  void display() {
    image(img, position.x - 20, position.y - 20, 40, 40);
    noFill();
    stroke(0, 100);
    ellipse(position.x, position.y, range * 2, range * 2);
  }

  void setPosition(float x, float y) {
    position.set(x, y);
  }
}
