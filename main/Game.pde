class Game{
private int lives;
private int money;
private int gameMode;
private boolean gameState;
 Game(){
  lives = 10;
  money = 2000;
  gameMode = 1;
}
 Game(int l, int $, int mode){
  lives = l;
  money = $;
  gameMode = mode;
}
void setGameState(boolean state){
  gameState = state;
}
boolean getGameState(){
  return gameState;
}
void setLives(int Lives){
  lives = Lives;
}
int getLives(){
  return lives;
}
void setMoney(int Money){
  money = Money;
}
int getMoney(){
  return money;
}
void setMode(int Mode){
  gameMode = Mode;
}
int getGameMode(){
  return gameMode;
}

void drawLives() {
  fill(255);
  stroke(0);
  rect(width - 150, 20, 120, 40); 
  fill(0);
  textSize(18);
  textAlign(CENTER, CENTER);
  text("Lives: " + lives, width - 90, 40);
}

void drawMoney() {
  fill(255);
  stroke(0);
  rect(width - 290, 20, 120, 40); 
  fill(0);
  textSize(18);
  textAlign(CENTER, CENTER);
  text("Money: " + money, width - 230, 40);
}
void drawRound(){
  fill(255);
  stroke(0);
  rect(width - 160, height - 60, 140, 40);
  
  fill(0);
  textSize(18);
  textAlign(CENTER, CENTER);
  text("Round " + (currroundInd + 1), width - 90, height - 40);
}
}
