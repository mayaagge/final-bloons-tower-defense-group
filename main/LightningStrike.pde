class LightningStrike {
  ArrayList<PVector> positions;
  int duration = 10;

  LightningStrike(ArrayList<PVector> positions) {
    this.positions = positions;
  }

  void display() {
    stroke(180, 0, 255); 
    strokeWeight(7);
    for (int i = 0; i < positions.size() - 1; i++) {
      line(positions.get(i).x, positions.get(i).y, positions.get(i+1).x, positions.get(i+1).y);
    }
    strokeWeight(1);
  }
}
