ArrayList<PVector> path = new ArrayList<PVector>();
void makePath(){
  for(int i = 0; i < width; i+= 5){
    path.add(0, new PVector(i, 100));
  }
}  

void drawPath(){
  for(PVector pos : path){
    rect(pos.x, pos.y, pos.x+20, pos.y+5);
  }
}
  
