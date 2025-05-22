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
