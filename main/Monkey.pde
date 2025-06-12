class Monkey {
  PVector position;
  float range = 200;
  int cooldown = 11, timer = 0;
  int sentryTimer = 180;
  boolean sentryDeployed = false;
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
  if(type.equals("Dartling")){
      range = 2000;
      cooldown = 5;
      pierce = 1;
      damage = 1;
      projectileSpeed = 25;
      cost = 800;
  }
  }
  void update(ArrayList<Bloon> bloons, ArrayList<Projectile> projectiles) {
    if (timer > 0) {
      timer--;
      return;
    }
  
    if (type.equals("Engineer")) {
      // Count this Engineer's active sentries
      int mySentryCount = 0;
      for (Sentry s : sentries) {
        if (s.parent == this) mySentryCount++;
      }
    
      // Deploy first sentry immediately on first update
      if (!sentryDeployed) {
        if (mySentryCount < 3) {
          sentries.add(new Sentry(position.copy().add(random(-30, 30), random(-30, 30)), this));
        }
        sentryDeployed = true;
        sentryTimer = 0;
      }
    
      // Spawn a new sentry every 180 frames (3 seconds), if under cap
      sentryTimer++;
      if (sentryTimer >= 180 && mySentryCount < 3) {
        sentries.add(new Sentry(position.copy().add(random(-30, 30), random(-30, 30)), this));
        sentryTimer = 0;
      }
    }




  
    for (Bloon b : bloons) {
      if (!b.popped && !b.reachedEnd && position.dist(b.position) <= range) {
        PVector bloonVel = new PVector(0, 0);
        if (b.pathIndex < b.path.size() - 1) {
          PVector nextTarget = b.path.get(b.pathIndex + 1).copy();
          bloonVel = PVector.sub(nextTarget, b.position).normalize().mult(b.type.speed);
        }
  
        PVector futurePos = PVector.add(b.position, PVector.mult(bloonVel, position.dist(b.position) / (projectileSpeed * 2)));
        PVector vel = PVector.sub(futurePos, position).normalize().mult(projectileSpeed);
  
        if (type.equals("Dartling")) {
          vel = PVector.add(PVector.sub(new PVector(mouseX, mouseY), position).normalize().mult(projectileSpeed), new PVector(5 - random(10), 5 - random(10))); 
          projectiles.add(new Projectile(position.copy(), vel, damage, pierce, 25));
        } 
        
        else if (type.equals("Wizard")) {
          ArrayList<Bloon> hit = new ArrayList<>();
          hit.add(b);
          Bloon current = b;
          for (int j = 0; j < 3; j++) {
            Bloon next = findNextBloon(current, bloons);
            if (next != null) {
              hit.add(next);
              next.lowerHealth(damage, new ArrayList<Bloon>());
              current = next;
            } else break;
          }
          ArrayList<PVector> chainPositions = new ArrayList<>();
          for (Bloon bHit : hit) chainPositions.add(bHit.position.copy());
          lightningStrikes.add(new LightningStrike(chainPositions));
        }
  
        else {
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
    ellipse(position.x, position.y, ((type.equals("Sniper") || type.equals("Dartling")) ? 50 : range * 2), ((type.equals("Sniper") || type.equals("Dartling"))? 50 : range * 2));
  }

  String getType() {
    return type;
  }

  void setPosition(float x, float y) {
    position.set(x, y);
  }
}
