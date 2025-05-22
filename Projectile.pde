class Projectile{
  PVector position, velocity;
  int damage;
  Projectile(PVector pos, PVector vel){
    position = pos;
    velocity = vel;
  }
  void update(){
    position.add(velocity);
  }
  void display(){
    fill(0);
    ellipse(position.x,position.y,5,5);
  }
}
