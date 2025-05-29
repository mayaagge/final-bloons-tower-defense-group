User user;
Game myGame;
PImage dart_monkey = loadImage("dart_monkey.pdf"); 
ArrayList<Projectile> projectiles;
void setup() {
  size(1080, 720);
  makePath(color(255,0,0));
  projectiles = new ArrayList<Projectile>();
  projectiles.add(new Projectile(new PVector(width/2, height/2), new PVector(2, 0), 10));
  myGame = new Game();
  myGame.setGameState(true);
  User user = new User("maa");
  println("Lives: " + myGame.getLives());
  println("Money: " + myGame.getMoney());
  println("Game Running: " + myGame.getGameState());
  println("Name: " + user.getName()); 
}
void draw() {
  background(200);
  drawPath();
  Monkey(dart_monkey, 100, 100);
  for(int i = projectiles.size()-1; i>=0;i--){
    Projectile proj = projectiles.get(i);
    proj.update();
    proj.display();
    if (proj.position.x < 0 || proj.position.x > width ||
        proj.position.y < 0 || proj.position.y > height) {
      projectiles.remove(proj);
    }
  }
}
