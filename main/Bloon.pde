class Bloon {
  PImage explodeImage = loadImage("images/BloonExplode.png");
  BloonType type;
  ArrayList<PVector> path;
  int pathIndex = 0;
  PVector position;
  int health;
  boolean popped = false;
  int poptime = 0;
  boolean reachedEnd = false;
  
  //Yellow bloon burst speed logic stuff
  int burstTimer = 0;
  boolean isBursting = false;
  int burstDuration = 30; // frames
  int burstCooldown = 120; // frames between bursts

  Bloon(ArrayList<PVector> path, float offset, BloonType type) {
    this.path = path;
    this.type = type;
    this.health = type.health;
    this.position = path.get(0).copy().add(offset, 0);
  }

  Bloon(ArrayList<PVector> path, PVector position, BloonType type, int pathIndex) {
    this.path = path;
    this.pathIndex = pathIndex;
    this.type = type;
    this.health = type.health;
    this.position = position.copy();
  }

  void update() {
    if (popped) {
      poptime++;
      return;
    }
    
    //Yellow burstytt
    if (type.name.equals("yellow")) {
      burstTimer++;
    if (!isBursting && burstTimer > burstCooldown) {
      isBursting = true;
      burstTimer = 0;
    }
    if (isBursting && burstTimer > burstDuration) {
      isBursting = false;
      burstTimer = 0;
    }
  }

    if (pathIndex < path.size() - 1) {
      float speed = type.speed;
      if (isBursting) speed *= 2.5;
      
      PVector target = path.get(pathIndex + 1);
      PVector direction = PVector.sub(target, position).normalize().mult(speed);
      position.add(direction);
      if (position.dist(target) < speed) {
        pathIndex++;
      }
    } else {
      reachedEnd = true;
      poptime = 1;
      myGame.setLives(myGame.getLives() - type.damage);
    }
  }

  int getPopTime() {
    return poptime;
  }

void lowerHealth(int n, ArrayList<Bloon> newBloons) {
  if (popped || reachedEnd) return;
  if (n <= 0) return;

  health -= n;

  if (health <= 0) {
    popped = true;
    poptime = 1;
    myGame.setMoney(myGame.getMoney() + type.reward);

    if (type.childType != null && !type.childType.equals("")) {
      BloonType childType = main.gimmeTheDamnBloonType(type.childType);
      if (childType != null) {
        Bloon child = new Bloon(path, position.copy(), childType, pathIndex);
        newBloons.add(child);
      }
    }
  }
}



  void display() {
    if (popped || reachedEnd) {
      image(explodeImage, position.x - 40, position.y - 40, 100, 100);
    } else {
      image(type.image, position.x - 40, position.y - 40, 100, 100);
    }
  }
  float getProgress() {
    if (pathIndex >= path.size() - 1) return path.size(); // bloon is near the end
    float segmentLength = path.get(pathIndex).dist(path.get(pathIndex + 1)) + 0.01;
    float partialProgress = position.dist(path.get(pathIndex)) / segmentLength;
    return pathIndex + partialProgress;
  }
}
