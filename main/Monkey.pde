class Monkey {
  PVector position;
  float range;
  int cooldown, timer = 0;
  PImage img;
  String type;
  float projectileSpeed;
  int pierce;

  Monkey(PImage img, float x, float y, String type) {
    this.img = img;
    this.position = new PVector(x, y);
    this.type = type;
    setStats();
  }
  void setStats(){
    if (type.equals("Dart")) {
      range = 200;
      cooldown = 30;
      pierce = 1;
      projectileSpeed = 5;
    } else if (type.equals("Sniper")) {
      range = 300;
      cooldown = 90;
      pierce = 2;
      projectileSpeed = 10;
    }
  }
  void update(ArrayList<Bloon> bloons, ArrayList<Projectile> projectiles) {
    if (timer > 0) {
      timer--;
      return;
    }
    for (Bloon b : bloons) {
      if (position.dist(b.position) < range) {
        PVector bloonVel = new PVector(0, 0);
        if (b.pathIndex < b.path.size() - 1) {
          PVector nextTarget = b.path.get(b.pathIndex + 1).copy();
          bloonVel = PVector.sub(nextTarget, b.position).normalize().mult(b.speed);
        }
        PVector futurePos = PVector.add(b.position, PVector.mult(bloonVel, 10));
        PVector vel = PVector.sub(futurePos, position).normalize().mult(projectileSpeed);
        projectiles.add(new Projectile(position.copy(), vel, 10, 1, 25));
        timer = cooldown;
        break;
      }
    }
  }

  void display() {
    image(img, position.x - 20, position.y - 20, 40, 40);
    boolean isDragging = (this == draggedmonkeytemporarything);
    stroke(0, 100);
    if (isDragging) {
      if (isOnPath(position) || isOverlapping(position)) {
        stroke(255, 0, 0, 150); 
      } else {
        stroke(0, 255, 0, 150); 
      }
    }
    noFill();
    ellipse(position.x, position.y, range * 2, range * 2);
  }

  void setPosition(float x, float y) {
    position.set(x, y);
  }
}
