class Monkey {
  PVector position;
  float range = 200;
  int cooldown = 11, timer = 0;

  PImage img;
  String type;
  float projectileSpeed;
  int pierce;
  int damage;
  int cost;

  Monkey(PImage img, float x, float y, String type) {
    this.img = img;
    this.position = new PVector(x, y);
    this.type = type;
    setStats();
  }

  void setStats() {
    if (type.equals("Dart")) {
      range = 200;
      cooldown = 40;
      pierce = 1;
      damage = 1;
      projectileSpeed = 15;
      cost = 200;
    } else if (type.equals("Sniper")) {
      range = 2000;
      cooldown = 60;
      pierce = 3;
      damage = 1;
      projectileSpeed = 30;
      cost = 300;
    }
    if(type.equals("Engineer")){
      range = 200;
      cooldown = 40;
      pierce = 1;
      damage = 1;
      projectileSpeed = 15;
      cost = 600;
    }
    if(type.equals("Wizard")){
      range = 200;
      cooldown = 40;
      pierce = 1;
      damage = 1;
      projectileSpeed = 15;
      cost = 800;
  }
  }
void update(ArrayList<Bloon> bloons, ArrayList<Projectile> projectiles) {
  if (timer > 0) {
    timer--;
    return;
  }
  for (int i = 0; i < bloons.size(); i++) {
    Bloon b = bloons.get(i);

    if (!b.popped && !b.reachedEnd && position.dist(b.position) <= range) {
      PVector bloonVel = new PVector(0, 0);
      if (b.pathIndex < b.path.size() - 1) {
        PVector nextTarget = b.path.get(b.pathIndex + 1).copy();
        bloonVel = PVector.sub(nextTarget, b.position).normalize().mult(b.type.speed);
      }

      PVector futurePos = PVector.add(b.position, PVector.mult(bloonVel, position.dist(b.position) / (projectileSpeed * 2)));
      PVector vel = PVector.sub(futurePos, position).normalize().mult(projectileSpeed);
      if(type.equals("Wizard")){
        for(int j = 0; j > bloons.size()-1; j++){
          projectiles.add(new Projectile(bloons.get(j).position, vel, damage, pierce, 25));
      }
      }
      else{
      projectiles.add(new Projectile(position.copy(), vel, damage, pierce, 25));
      }
      timer = cooldown;
      break; 
    }
  }
}



  void display() {
    image(img, position.x - 20, position.y - 20, 40, 40);
    stroke(0, 100);
    if (this == draggedmonkeytemporarything) {
      if (isOnPath(position) || isOverlapping(position)) {
        stroke(255, 0, 0, 150);
      } else {
        stroke(0, 255, 0, 150);
      }
    }
    noFill();
    ellipse(position.x, position.y, (type.equals("Sniper") ? 50 : range * 2), (type.equals("Sniper") ? 50 : range * 2));
  }

  String getType() {
    return type;
  }

  void setPosition(float x, float y) {
    position.set(x, y);
  }
}
