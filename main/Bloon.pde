class Bloon{
  PImage explodeImage = loadImage("BloonExplode.png");
  BloonType type;
  ArrayList<PVector> path;
  int pathIndex = 0;
  PVector position;
  int health;
  boolean popped = false;
  int poptime = 0;
  boolean reachedEnd = false;
  
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
    myGame.setMoney(myGame.getMoney() + 1);
    return;
  }
  if (pathIndex < path.size() - 1) {
    PVector target = path.get(pathIndex + 1);
    PVector direction = PVector.sub(target, position).normalize().mult(type.speed);
    position.add(direction);
    if (position.dist(target) < type.speed) {
      pathIndex++;
    }
  }
  else {
      reachedEnd = true;
      poptime = 1;
      myGame.setLives(myGame.getLives() - type.damage);
    }
}

int getPopTime(){
  return poptime;
}

void pop(ArrayList<Bloon> newBloons) {
  popped = true;
  poptime = 1;
  
  if (type.childType != null || type.childType.equals("")) {
      BloonType child = main.gimmeTheDamnBloonType(type.childType);
      if (child != null) {
        newBloons.add(new Bloon(path, position.copy(), child, pathIndex));
      }
    }
}



void lowerHealth(int n, ArrayList<Bloon> newBloons) {
  if (popped || reachedEnd) return;

    health -= n;
    if (health <= 0) {
      pop(newBloons);
    }
}

void display() {
  if (popped || reachedEnd) {
      image(explodeImage, position.x - 40, position.y - 40, 100, 100);
    } else {
      image(type.image, position.x - 40, position.y - 40, 100, 100);
    }
  }
}
