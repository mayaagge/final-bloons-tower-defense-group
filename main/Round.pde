class Round {
  int roundNum;
  ArrayList<BloonType> types;
  ArrayList<Integer> counts;  // how many of each bloon type left to spawn
  int currtype = 0;
  int timer = 0;
  int delay = 30;
  

  Round(int roundNum, ArrayList<BloonType> types, ArrayList<Integer> counts) {
    this.roundNum = roundNum;
    this.types = types;
    this.counts = new ArrayList<Integer>();
    for (int c : counts) {
      this.counts.add(c);
    }
  }
  
  boolean isFinished() {
    for (int c : counts) {
      if (c > 0) return false;
    }
    return true;
  }
  
    void updateSpawn(ArrayList<Bloon> gameBloons, ArrayList<PVector> path) {
    timer++;
    if (timer >= delay) {
      timer = 0;
      while (currtype < types.size() && counts.get(currtype) == 0) {
        currtype++;
      }
      if (currtype < types.size()) {
        BloonType bt = types.get(currtype);
        gameBloons.add(new Bloon(path, 0, bt));
        counts.set(currtype, counts.get(currtype) - 1);
      }
    }
  }

  void spawnBloons(ArrayList<Bloon> daBloons, ArrayList<PVector> path) {
    for (int i = 0; i < types.size(); i++) {
      for (int c = 0; c < counts.get(i); c++) {
        daBloons.add(new Bloon(path, 0, types.get(i)));
      }
    }
  }
}
