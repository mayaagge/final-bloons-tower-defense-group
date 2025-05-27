ArrayList<PVector> path = new ArrayList<PVector>();
void makePath(color clr){
  for(int i = 0; i < width; i+= 5){
    path.add(0, new PVector(i, 100));
  }
  fill(clr);
  for(PVector pos : path){
    rect(pos.x, pos.y, pos.x+20, pos.y+5);
  }
}  
  
