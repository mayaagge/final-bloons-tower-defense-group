class Projectile{
  PVector position, velocity;
  int damage;
  Projectile(PVector pos, PVector vel, int damage){
    position = pos;
    velocity = vel;
    this.damage = damage;
  }
  void update(){
    position.add(velocity);
  }
  void display(){
    fill(0);
    noStroke();
    ellipse(position.x,position.y,5,5);
  }
}
