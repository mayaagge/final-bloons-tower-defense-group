class BloonType {
  PImage image;
  float speed;
  int health, reward, damage;
  String childType;

  BloonType(PImage image, float speed, int health, int reward, int damage, String childType) {
    this.image = image;
    this.speed = speed;
    this.health = health;
    this.reward = reward;
    this.damage = damage;
    this.childType = childType;
  }
}
