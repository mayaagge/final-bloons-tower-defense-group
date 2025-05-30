class Bloon{
  PImage explodeImage = loadImage("BloonExplode.png");
  BloonType type;
  ArrayList<PVector> path;
  int pathIndex = 0;
  PVector position;
  int health;
  boolean pop = false;
  int poptime = 0;
  boolean reachedEnd = false;
  
  Bloon(ArrayList<PVector> path, float offset, BloonType type) {
    this.path = path;
    this.type = type;
    this.health = type.health;
    this.position = path.get(0).copy().add(offset, 0);
  }
  
  
  void update() {
  if (pathIndex < path.size() - 1) {
    PVector target = path.get(pathIndex + 1);
    PVector direction = target.copy();
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

void pop() {
  pop = true;
  poptime = 1;
  
  if(type.equals("blue")) {
    bloons.add(new Bloon(path, pathIndex, 0, "red"));
  }
}

void lowerHealth(int n) {
  if (popped || reachedEnd) return;

    health -= dmg;
    if (health <= 0) {
      pop();
    }
}

void display() {
  if (pathIndex == path.size() - 1 || pop == true) {
    image(explodeImage, position.x - 40, position.y - 40, 100, 100);
    poptime = 2;
    
    if(pathIndex == path.size() - 1) {
      myGame.setLives(myGame.getLives() - health);
    }
    
  } else {
    image(Bloon, position.x - 40, position.y - 40, 100, 100);
  }}
}
