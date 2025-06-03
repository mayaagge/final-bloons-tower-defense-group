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
ArrayList<PVector> parameterize() {
  ArrayList<PVector> parameters = new ArrayList<>();
  for (int i = 0; i < path.size() - 1; i++) {
    PVector start = path.get(i).copy();
    PVector end = path.get(i + 1).copy();
    PVector distanceVector = PVector.sub(end, start);
    float distanceScalar = distanceVector.mag();
    for (float j = 0; j < distanceScalar; j += 5) {
      PVector point = PVector.add(start, PVector.mult(distanceVector.copy().normalize(), j));
      parameters.add(point);
    }
  }
  return parameters;
}

  
