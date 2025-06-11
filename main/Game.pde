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
  fill(0);
  textSize(24);
  textAlign(RIGHT, TOP);
  text("Lives: " + lives, width - 20, 20);
}

void drawMoney() {
  fill(0);
  textSize(24);
  textAlign(RIGHT, TOP);
  text("Moneys: " + money, width - 200, 20);
}
}
