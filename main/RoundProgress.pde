class RoundProgress {
  ArrayList<Round> rounds = new ArrayList<>();
  int currentRound = -1;
  ArrayList<PVector> path;

  RoundProgress(ArrayList<PVector> path) {
    this.path = path;
    setupRounds();
  }

  void setupRounds() {
    BloonType red = gimmeTheDamnBloonType("red");
    BloonType blue = gimmeTheDamnBloonType("blue");
    BloonType green = gimmeTheDamnBloonType("green");
    BloonType yellow = gimmeTheDamnBloonType("yellow");
    BloonType pink = gimmeTheDamnBloonType("pink");
    
    // YAYY ROUNDS
    ArrayList<BloonType> round1Types = new ArrayList<>();
    round1Types.add(red);
    ArrayList<Integer> round1Counts = new ArrayList<>();
    round1Counts.add(10);

    ArrayList<BloonType> round2Types = new ArrayList<>();
    round2Types.add(red);
    round2Types.add(blue);
    ArrayList<Integer> round2Counts = new ArrayList<>();
    round2Counts.add(10);
    round2Counts.add(5);

    ArrayList<BloonType> round3Types = new ArrayList<>();
    round3Types.add(blue);
    round3Types.add(green);
    ArrayList<Integer> round3Counts = new ArrayList<>();
    round3Counts.add(10);
    round3Counts.add(5);

    ArrayList<BloonType> round4Types = new ArrayList<>();
    round4Types.add(green);
    round4Types.add(yellow);
    ArrayList<Integer> round4Counts = new ArrayList<>();
    round4Counts.add(10);
    round4Counts.add(5);
    
    ArrayList<BloonType> round5Types = new ArrayList<>();
    round5Types.add(green);
    round5Types.add(blue);
    round5Types.add(red);
    ArrayList<Integer> round5Counts = new ArrayList<>();
    round5Counts.add(20);
    round5Counts.add(15);
    round5Counts.add(10);

    ArrayList<BloonType> round6Types = new ArrayList<>();
    round6Types.add(pink);
    round6Types.add(yellow);
    ArrayList<Integer> round6Counts = new ArrayList<>();
    round6Counts.add(15);
    round6Counts.add(10);

    ArrayList<BloonType> round7Types = new ArrayList<>();
    round7Types.add(yellow);
    round7Types.add(green);
    round7Types.add(blue);
    ArrayList<Integer> round7Counts = new ArrayList<>();
    round7Counts.add(15);
    round7Counts.add(10);
    round7Counts.add(5);
    
    ArrayList<BloonType> round8Types = new ArrayList<>();
    round8Types.add(yellow);
    round8Types.add(pink);
    round7Types.add(green);
    round7Types.add(blue);
    ArrayList<Integer> round8Counts = new ArrayList<>();
    round8Counts.add(15);
    round8Counts.add(5);
     round8Counts.add(15);
    round8Counts.add(5);


    rounds.add(new Round(1, round1Types, round1Counts));
    rounds.add(new Round(2, round2Types, round2Counts));
    rounds.add(new Round(3, round3Types, round3Counts));
    rounds.add(new Round(4, round4Types, round4Counts));
    rounds.add(new Round(5, round5Types, round5Counts));
    rounds.add(new Round(6, round6Types, round6Counts));
    rounds.add(new Round(7, round7Types, round7Counts));
    rounds.add(new Round(8, round8Types, round8Counts));
    rounds.add(new Round(9, round9Types, round9Counts));
    rounds.add(new Round(10, round10Types, round10Counts));


      }

  void startNextWave() {
    if (currentRound + 1 >= rounds.size()) return;
    if (bloons.size() > 0) return;
    currentRound++;
  }
}
