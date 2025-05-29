User user;
Game myGame;
PImage mapBackground;
PImage STARTSCREEN;
ArrayList<Bloon> bloons;
boolean gameStarted = false;
ArrayList<Monkey> monkeys;
Monkey draggedmonkeytemporarything = null;
PImage monkeyImage;


ArrayList<Projectile> projectiles;
void setup() {
  size(1080, 720);
  mapBackground = loadImage("MonkeyMeadow.png");
  STARTSCREEN = loadImage("STARTSCREEN.png");
  monkeys = new ArrayList<Monkey>();
  monkeyImage = loadImage("Monkey.png");
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
  if (!gameStarted) {
    gameStarted = true;
    return;
  }
  
  if (key == 'a') {
    bloons.add(new Bloon(path, 0, 0, "red"));
  }
  
  if (key == 'm' || key == 'M') {
    if (draggedmonkeytemporarything == null) {
      draggedmonkeytemporarything = new Monkey(monkeyImage, mouseX, mouseY);
    }
  }
}

void mousePressed() {
  if (draggedmonkeytemporarything != null) {
    monkeys.add(draggedmonkeytemporarything);
    draggedmonkeytemporarything = null;
  }
}



void draw() {
   if (!gameStarted) {
    background(50);
    image(STARTSCREEN, 0, 0, width, height);
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(32);
    text("Press any key to start", width/2, height/2);
    return;
  }
  
  background(200);
  image(mapBackground, 0, 0, width, height);
  drawPath();
  drawLives();
  
  
  for (int i = bloons.size() - 1; i >= 0; i--) {
    Bloon b = bloons.get(i);
    b.update();
    b.display();
  }
  
  for(int i = projectiles.size()-1; i>=0;i--){
    Projectile proj = projectiles.get(i);
    proj.update();
    proj.display();
    if (proj.position.y >= 700) {
      projectiles.remove(proj);
    }
  }
  
  for (Monkey m : monkeys) {
    m.update(bloons, projectiles);
    m.display();
  }

  if (draggedmonkeytemporarything != null) {
    draggedmonkeytemporarything.setPosition(mouseX, mouseY);
    draggedmonkeytemporarything.display();
  }
}

void drawLives() {
  fill(0);
  textSize(24);
  textAlign(RIGHT, TOP);
  text("Lives: " + myGame.getLives(), width - 20, 20);
}
