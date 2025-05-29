User user;
Game myGame;
PImage mapBackground;
ArrayList<Bloon> bloons;
boolean gameStarted = false;


ArrayList<Projectile> projectiles;
void setup() {
  size(1080, 720);
  mapBackground = loadImage("MonkeyMeadow.png");
  makePath();
  bloons = new ArrayList<Bloon>();
  bloons.add(new Bloon(path, 0, 0, "red"));

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

void keyPressed() {
  if (key == 'a') {
    bloons.add(new Bloon(path, 0, 0, "red"));
  }
}



void draw() {
  
   if (!gameStarted) {
    background(50);
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(32);
    text("Press any key to start", width/2, height/2);
    return;
  }
  
  background(200);
  image(mapBackground, 0, 0, width, height);
  drawPath();
  
  
  for (Bloon b : bloons) {
    b.update();
    b.display();
  }
  
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
