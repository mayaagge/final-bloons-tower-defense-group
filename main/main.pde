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
String selectedMonkeyType = null; 
boolean selectingMonkey = false;
PImage dartMonkey;
PImage sniperMonkey;

ArrayList<Projectile> projectiles;
void setup() {
  size(1080, 720);
  
 //IMAGESSS
  mapBackground = loadImage("MonkeyMeadow.png");
  STARTSCREEN = loadImage("STARTSCREEN.png");
  LOSESCREEN = loadImage("LOSESCREEN.jpg");
  

  dartMonkey = loadImage("dartMonkey.png");
  sniperMonkey = loadImage("sniperMonkey.png");
  
  monkeys = new ArrayList<Monkey>();
  //monkeyImage = loadImage("Monkey.png");
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
    selectingMonkey = true;
    selectedMonkeyType = null;
    draggedmonkeytemporarything = null;
  }
}

void mousePressed() {
  if (selectingMonkey) {
    if (mouseY > 20 && mouseY < 60 && mouseX > 20 && mouseX < 140) {
      selectedMonkeyType = "Dart";
      draggedmonkeytemporarything = new Monkey(dartMonkey, mouseX, mouseY, "Dart");
      selectingMonkey = false;
      return;
    } else if (mouseY > 70 && mouseY < 110 && mouseX > 20 && mouseX < 140) {
      selectedMonkeyType = "Sniper";
      draggedmonkeytemporarything = new Monkey(sniperMonkey, mouseX, mouseY, "Sniper");
      selectingMonkey = false;
      return;
    }
  }

  if (draggedmonkeytemporarything != null) {
    PVector pos = new PVector(mouseX, mouseY);

    if (isOnPath(pos)) {
      println("Can't place monkey on the path!");
      return;
    }

    if (isOverlapping(pos)) {
      println("Can't place monkey on top of another!");
      return;
    }

    draggedmonkeytemporarything.setPosition(mouseX, mouseY);
    monkeys.add(draggedmonkeytemporarything);
    draggedmonkeytemporarything = null;
    selectedMonkeyType = null;
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
  if (selectingMonkey) {
    drawMonkeySelectionUI();
  }
}

void drawLives() {
  fill(0);
  textSize(24);
  textAlign(RIGHT, TOP);
  text("Lives: " + myGame.getLives(), width - 20, 20);
}

void drawMoney() {
  fill(0);
  textSize(24);
  textAlign(RIGHT, TOP);
  text("Moneys: " + myGame.getMoney(), width - 200, 20);
}

void drawMonkeySelectionUI() {
  fill(255);
  stroke(0);
  rect(20, 20, 120, 40);
  fill(0);
  textAlign(CENTER, CENTER);
  text("Dart Monkey", 80, 40);

  fill(255);
  stroke(0);
  rect(20, 70, 120, 40);
  fill(0);
  text("Sniper Monkey", 80, 90);

  fill(50, 50, 255, 100);
  textSize(14);
  text("Click to choose a monkey", width/2, height - 30);
}
boolean isOnPath(PVector pos) {
  for (PVector p : parameterize()) {
    if (PVector.dist(p, pos) < 20) {
      return true;
    }
  }
  return false;
}

boolean isOverlapping(PVector pos) {
  for (Monkey m : monkeys) {
    if (PVector.dist(pos, m.position) < 40) {
      return true;
    }
  }
  return false;
}
