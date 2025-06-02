ArrayList<PVector> path = new ArrayList<PVector>();
void makePath() {
  path.clear();
  path.add(new PVector(0, 290));
  path.add(new PVector(520, 290));
  path.add(new PVector(520, 110));
  path.add(new PVector(340, 110));
  path.add(new PVector(340, 570));
  path.add(new PVector(160, 570));
  path.add(new PVector(160, 410));
  path.add(new PVector(160, 410));
  path.add(new PVector(665, 410));
  path.add(new PVector(665, 230));
  path.add(new PVector(800, 230));
  path.add(new PVector(800, 510));
  path.add(new PVector(470, 520));
  path.add(new PVector(470, 700));
}

void drawPath(){
  noStroke();
  for(PVector pos : path) {
    rect(pos.x, pos.y, 20, 5);
  }
}
ArrayList<PVector> parameterize(){
   noStroke();
   ArrayList<PVector> parameters = new ArrayList<>();
   for(int i = 0; i < path.size()-1; i++){
     PVector distanceVector = path.get(i+1).add(path.get(i).mult(-1));
     float distanceScalar = distanceVector.mag();
     for(int j = 0; j < distanceScalar; j += 5){
       parameters.add(path.get(i).add(distanceVector.mult(j / distanceScalar)));
     }
   }
   return parameters;    
       
   }

  
