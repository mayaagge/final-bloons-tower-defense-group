ArrayList<PVector> path = new ArrayList<PVector>();
void makePath(color clr){
  path.clear();
  for(int i = 0; i < width; i+= 5){
    path.add(0, new PVector(i, 100));
  }
  fill(clr);
  for(PVector pos : path){
    rect(pos.x, pos.y, 20, 5);
  }
}
void drawPath(){
  noStroke();
  for(PVector pos : path) {
    rect(pos.x, pos.y, 20, 5);
  }
}
  
