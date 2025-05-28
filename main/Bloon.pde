class Bloon {
  ArrayList<PVector> path;
  int pathIndex = 0;
  PVector position;
  float speed;
  int health, reward, damage;
  String type;

  Bloon(ArrayList<PVector> path, int index, float offset, String type) {
    this.path = path;
    this.type = type;
    this.pathIndex = index;
    position = path.get(0).copy().add(offset, 0);
    if (type.equals("red")) {
      speed = 1.5;
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
}
