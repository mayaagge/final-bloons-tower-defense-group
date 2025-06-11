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
int outOfMoney;
ArrayList<Projectile> projectiles;
ArrayList<Round> round;
RoundProgress RoundProgress;
Round currRound = null;
int currroundInd = -1;
int roundMessageTimer = 0;

void setup() {
  size(1080, 720);
  
 //IMAGESSS
  mapBackground = loadImage("images/MonkeyMeadow.png");
  STARTSCREEN = loadImage("images/STARTSCREEN.png");
  LOSESCREEN = loadImage("images/LOSESCREEN.jpg");
  

  dartMonkey = loadImage("images/dartMonkey.png");
  sniperMonkey = loadImage("images/sniperMonkey.png");
  
  monkeys = new ArrayList<Monkey>();
  //monkeyImage = loadImage("images/Monkey.png");
  makePath();
  
  //BLOONS SETUP
  PImage redImg = loadImage("images/BloonRed.png");
  PImage blueImg = loadImage("images/BloonBlue.png");
  PImage greenImg = loadImage("images/BloonGreen.png");
  PImage yellowImg = loadImage("images/BloonYellow.png");
  PImage pinkImg = loadImage("images/BloonPink.png");

  allBloonTypes.add(new BloonType("red", redImg, 4.5, 1, 10, 1, ""));
  allBloonTypes.add(new BloonType("blue", blueImg, 2.5, 2, 15, 1, "red"));
  allBloonTypes.add(new BloonType("green", greenImg, 3.0, 4, 20, 1, "blue"));
  allBloonTypes.add(new BloonType("yellow", yellowImg, 3.5, 8, 40, 1, "green"));
  allBloonTypes.add(new BloonType("pink", pinkImg, 4.5, 5, 6, 1, "green"));
  
  //PROJ
  projectiles = new ArrayList<Projectile>();
  projectiles.add(new Projectile(new PVector(width/2, height/2), new PVector(2, 0), 10, 1, 25));
  myGame = new Game();
  myGame.setGameState(true);
  
  //ROUND
  RoundProgress = new RoundProgress(path);
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
  /*
  if (key == 'w' || key == 'W') {
    if (currRound == null || currRound.isFinished() && bloons.isEmpty()) {
      currroundInd++;
      if (currroundInd < RoundProgress.rounds.size()) {
        currRound = RoundProgress.rounds.get(currroundInd);
      }
    }
  }
  
  
  if (key == 'a') {
    BloonType blueType = gimmeTheDamnBloonType("blue");
    bloons.add(new Bloon(path, 0, blueType));
  }
  if (key == 's') {
    BloonType greenType = gimmeTheDamnBloonType("green");
    bloons.add(new Bloon(path, 0, greenType));
  }
  if (key == 'd') {
    BloonType yellowType = gimmeTheDamnBloonType("yellow");
    bloons.add(new Bloon(path, 0, yellowType));
  }
  if (key == 'f') {
    BloonType pinkType = gimmeTheDamnBloonType("pink");
    bloons.add(new Bloon(path, 0, pinkType));
  }
  */
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
    if(draggedmonkeytemporarything.getType() != null){
      if(draggedmonkeytemporarything.getType().equals("Dart")){
        if(myGame.getMoney() >= 200){
          myGame.setMoney(myGame.getMoney() - 200);
          monkeys.add(draggedmonkeytemporarything);
          draggedmonkeytemporarything = null;
          selectedMonkeyType = null;
        }
        else{
          outOfMoney = 30;
          draggedmonkeytemporarything = null;
          selectedMonkeyType = null;
        }
    }
    else if(draggedmonkeytemporarything.getType().equals("Sniper")){
      if(myGame.getMoney() >= 300){
        myGame.setMoney(myGame.getMoney() - 300);
        monkeys.add(draggedmonkeytemporarything);
        draggedmonkeytemporarything = null;
        selectedMonkeyType = null;
      }
      else{
        outOfMoney = 30;
        draggedmonkeytemporarything = null;
        selectedMonkeyType = null;
      }
    }
  }
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
  
  ArrayList<Bloon> newBloons = new ArrayList<>();
  background(200);
  image(mapBackground, 0, 0, width, height);
  drawPath();
  myGame.drawLives();
  myGame.drawMoney();
  
  //ArrayList<Bloon> r1 = new ArrayList<>;
  //round.add(new Round(
  if (roundMessageTimer > 0) {
    fill(255, 255, 0);
    textSize(32);
    textAlign(CENTER, CENTER);
    text("Starting Round " + (currroundInd + 1), width / 2, height / 2 - 100);
    roundMessageTimer--;
  }
  if (currRound != null) {
    currRound.updateSpawn(bloons, path);
  }
  
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
  if (myGame.getLives() <= 0) {
    background(50);
    image(LOSESCREEN, 0, 0, width, height);
    return;
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
  sortBloonsByProgress(bloons);
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
  if ((currRound == null || currRound.isFinished()) && bloons.isEmpty()) {
    currroundInd++;
    if (currroundInd < RoundProgress.rounds.size()) {
      currRound = RoundProgress.rounds.get(currroundInd);
      roundMessageTimer = 120; 
    } else {
      currRound = null;
    }
  }
  if (outOfMoney > 0) {
    fill(255, 0, 0);
    textAlign(CENTER, CENTER);
    textSize(26);
    text("Not enough money!", width / 2, height - 60);
    outOfMoney--;
  }
}

void drawLives() {
  fill(0);
  textSize(24);
  textAlign(RIGHT, TOP);
  text("Lives: " + myGame.getLives(), width - 20, 20);
}

void drawMoney() {
  if(outOfMoney > 0){
    if(outOfMoney % 2 == 0){
      fill(255, 0, 0);
    }
    else{
    fill(0);
    }
    outOfMoney--;
  }
  else{
  fill(0);
  }
  textSize(24);
  textAlign(RIGHT, TOP);
  text("Money: " + myGame.getMoney(), width - 200, 20);
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
void sortBloonsByProgress(ArrayList<Bloon> bloonList) {
  for (int i = 0; i < bloonList.size(); i++) {
    for (int j = i + 1; j < bloonList.size(); j++) {
      if (bloonList.get(j).getProgress() > bloonList.get(i).getProgress()) {
        Bloon temp = bloonList.get(i);
        bloonList.set(i, bloonList.get(j));
        bloonList.set(j, temp);
      }
    }
  }
}
