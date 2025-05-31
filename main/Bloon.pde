class Bloon {
  PImage explodeImage = loadImage("BloonExplode.png");
  PImage redBloon = loadImage("BloonRed.png");
  ArrayList<PVector> path;
  int pathIndex = 0;
  PVector position;
  float speed;
  int health, reward, damage;
  String type;
  boolean pop = false;
  int poptime = 0;
  
  Bloon(ArrayList<PVector> path, int index, float offset, String type) {
    this.path = path;
    this.type = type;
    this.pathIndex = index;
    position = path.get(0).copy().add(offset, 0);
    if (type.equals("red")) {
      speed = 10;
      health = 1;
      reward = 1;
      damage = 1;
    } else {
      speed = 2.0;
      health = 2;
      reward = 2;
      damage = 2;
    }
  }
  
  
  void update() {
  if (pathIndex < path.size() - 1) {
    PVector target = path.get(pathIndex + 1);
    PVector direction = target.copy();
    direction.sub(position);
    direction.normalize();
    direction.mult(speed);    
    position.add(direction);
    if (position.dist(target) < speed) {
      pathIndex++;
    }
  }
  if(poptime >= 1){
    poptime++;
  }
}

int getPopTime(){
  return poptime;
}

void popped() {
  pop = true;
  poptime = 1;
}


void display() {
  if (pathIndex == path.size() - 1 || pop == true) {
    image(explodeImage, position.x - 40, position.y - 40, 100, 100);
    poptime = 2;
    if(pathIndex == path.size() - 1) {
      myGame.setLives(myGame.getLives() - health);
    }
  } else {
    image(redBloon, position.x - 40, position.y - 40, 100, 100);
  }}
}
