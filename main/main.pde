User user;
Game myGame;

PImage mapBackground;
PImage STARTSCREEN;
PImage LOSESCREEN;
static ArrayList<BloonType> allBloonTypes = new ArrayList<BloonType>();
ArrayList<Bloon> bloons = new ArrayList<Bloon>();
boolean gameStarted = false;
ArrayList<Monkey> monkeys;
Monkey draggedmonkeytemporarything = null;
PImage monkeyImage;


ArrayList<Projectile> projectiles;
void setup() {
  size(1080, 720);
  
 //IMAGESSS
  mapBackground = loadImage("MonkeyMeadow.png");
  STARTSCREEN = loadImage("STARTSCREEN.png");
  LOSESCREEN = loadImage("LOSESCREEN.jpg");
  
  //MONKEE
  monkeys = new ArrayList<Monkey>();
  monkeyImage = loadImage("Monkey.png");
  makePath();
  
  //BLOONS SETUP
  PImage redImg = loadImage("BloonRed.png");
  PImage blueImg = loadImage("BloonBlue.png");
  allBloonTypes.add(new BloonType("red", redImg, 4.5, 1, 1, 1, ""));
  allBloonTypes.add(new BloonType("blue", blueImg, 2.5, 2, 2, 1, "red"));
  
  //PROJ
  projectiles = new ArrayList<Projectile>();
  projectiles.add(new Projectile(new PVector(width/2, height/2), new PVector(2, 0), 10, 1, 25));
  myGame = new Game();
  myGame.setGameState(true);
}

static BloonType gimmeTheDamnBloonType(String name) {
  for (BloonType bt : allBloonTypes) {
    if (bt.name.equals(name)) {
      return bt;
    }
  }
  return null;
}

void keyPressed() {
  if (!gameStarted) {
    gameStarted = true;
    return;
  }
  
  if (key == 'a') {
    BloonType blueType = gimmeTheDamnBloonType("blue");
    bloons.add(new Bloon(path, 0, blueType));
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
  else if (myGame.getLives() <= 0) {
      background(50);
      image(LOSESCREEN, 0, 0, width, height);
      return;
  }
  
  ArrayList<Bloon> newBloons = new ArrayList<>();
  background(200);
  image(mapBackground, 0, 0, width, height);
  drawPath();
  myGame.drawLives();
  myGame.drawMoney();
  
  for (int i = bloons.size() - 1; i >= 0; i--) {
    Bloon b = bloons.get(i);
    if(b.getPopTime() >= 2){
      bloons.remove(i);
    }
    else{
      b.update();
      b.display();
    }
  }
  
  for(int i = projectiles.size()-1; i>=0;i--){
    Projectile proj = projectiles.get(i);
    if (proj.getPierce() <= 0) {
      projectiles.remove(i);
    } else {
      proj.update(newBloons);
      proj.display();
    }
    if (proj.position.y >= 700) {
      projectiles.remove(i);
    }
  }
  bloons.addAll(newBloons);
  
  for (Monkey m : monkeys) {
    m.update(bloons, projectiles);
    m.display();
  }

  if (draggedmonkeytemporarything != null) {
    draggedmonkeytemporarything.setPosition(mouseX, mouseY);
    draggedmonkeytemporarything.display();
  }
}
