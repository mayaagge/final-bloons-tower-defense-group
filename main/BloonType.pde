class BloonType {
  PImage image;
  float speed;
  int health, reward, damage;
  String name;
  String childType;

  BloonType(String name, PImage image, float speed, int health, int reward, int damage, String childType) {
    this.name = name;
    this.image = image;
    this.speed = speed;
    this.health = health;
    this.reward = reward;
    this.damage = damage;
    this.childType = childType;
  }
}
