void setup() {
  size(1080, 720);
  Game newgame = new Game();
  User usr = new User("maa");
}
void draw() {
  background(200);
  Path.makePath(100);
}
