public class Game{
private int lives;
private int money;
private int gameMode;
private boolean gameState;
public Game(){
  lives = 100;
  money = 600;
  gameMode = 1;
}
public Game(int l, int $, int mode){
  lives = l;
  money = $;
  gameMode = mode;
}
public void setGameState(boolean state){
  gameState = state;
}
public boolean getGameState(){
  return gameState;
}
public void setLives(int Lives){
  lives = Lives;
}
public int getLives(){
  return lives;
}
public void setMoney(int Money){
  money = Money;
}
public int getMoney(){
  return money;
}
public void setMode(int Mode){
  gameMode = Mode;
}
public int getGameMode(){
  return gameMode;
}
