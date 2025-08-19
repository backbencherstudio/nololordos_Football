class PlayerInfoModel {
  String team;
  String position;
  String name;
  String id;

  double sr;            // Change to double for easier calculation
  int gm;            // Change to double for easier calculation
  double gl;            // Goals (already double)
  double agl;           // Average Goals per Match (AGL)
  double minusGl;       // minusGL (changed to double)
  double minusAgl;      // minusAGL (changed to double)

  int goals;         // Goals scored by the player
  int ownGoals;      // Own goals scored by the player
  int selectedScore;    // Selected score (probably integer)
  String matchName;
  String teamOne;
  String teamTwo;
  String teamOneScore;
  String teamTwoScore;
  String date;

  PlayerInfoModel({
    required this.team,
    required this.position,
    required this.name,
    required this.id,
    this.sr = 0.0,
    this.gm = 0,
    this.gl = 0.00,
    this.agl = 0.00,
    this.minusGl = 0.0,
    this.minusAgl = 0.0,
    this.goals = 0,
    this.ownGoals = 0,
    this.selectedScore = 0,
    this.matchName = '',
    this.teamOne = '',
    this.teamTwo = '',
    this.teamOneScore = '',
    this.teamTwoScore = '',
    this.date = '',
  });

  // ✅ copyWith method to allow easier field updates
  PlayerInfoModel copyWith({
    String? team,
    String? position,
    String? name,
    String? id,
    double? sr,
    int? gm,
    double? gl,
    double? agl,
    double? minusGl,
    double? minusAgl,
    int? goals,
    int? ownGoals,
    int? selectedScore,
    String? matchName,
    String? teamOne,
    String? teamTwo,
    String? teamOneScore,
    String? teamTwoScore,
    String? date,
  }) {
    return PlayerInfoModel(
      team: team ?? this.team,
      position: position ?? this.position,
      name: name ?? this.name,
      id: id ?? this.id,
      sr: sr ?? this.sr,
      gm: gm ?? this.gm,
      gl: gl ?? this.gl,
      agl: agl ?? this.agl,
      minusGl: minusGl ?? this.minusGl,
      minusAgl: minusAgl ?? this.minusAgl,
      goals: goals ?? this.goals,
      ownGoals: ownGoals ?? this.ownGoals,
      selectedScore: selectedScore ?? this.selectedScore,
      matchName: matchName ?? this.matchName,
      teamOne: teamOne ?? this.teamOne,
      teamTwo: teamTwo ?? this.teamTwo,
      teamOneScore: teamOneScore ?? this.teamOneScore,
      teamTwoScore: teamTwoScore ?? this.teamTwoScore,
      date: date ?? this.date,
    );
  }
}



List<PlayerInfoModel> playersInfo = [
  // AEK Athens Goalkeepers
  PlayerInfoModel(team: 'AEK Athens', position: 'GK', name: 'THOMAS STRAKOSHA', id: "012a"),
  PlayerInfoModel(team: 'AEK Athens', position: 'GK', name: 'ANGELOS ANGELOPOULOS', id: "011a"),
  PlayerInfoModel(team: 'AEK Athens', position: 'GK', name: 'ALBERTO BRIGNOLI', id: "105d"),
  PlayerInfoModel(team: 'AEK Athens', position: 'GK', name: 'MARIOS BALAMIOTIS', id: "846s"),

  // AEK Athens Defenders
  PlayerInfoModel(team: 'AEK Athens', position: 'DEF', name: 'HAROLD MOUKOUTI', id: "87c8"),
  PlayerInfoModel(team: 'AEK Athens', position: 'DEF', name: 'STAVROS PILIOS', id: "484d"),
  PlayerInfoModel(team: 'AEK Athens', position: 'DEF', name: 'LAZAROS ROTA', id: "970c"),
  PlayerInfoModel(team: 'AEK Athens', position: 'DEF', name: 'ALEXANDER CALLENS', id: "54f5"),
  PlayerInfoModel(team: 'AEK Athens', position: 'DEF', name: 'DOMAGOJ VIDA', id: "046f"),
  
  // AEK Athens Midfielders
  PlayerInfoModel(team: 'AEK Athens', position: 'MID', name: 'ORBELÍN PINEDA', id: "846q"),
  PlayerInfoModel(team: 'AEK Athens', position: 'MID', name: 'PETROS MANTALOS', id: "793p"),
  PlayerInfoModel(team: 'AEK Athens', position: 'MID', name: 'ROBERTO PEREYRA', id: "964w"),
  PlayerInfoModel(team: 'AEK Athens', position: 'MID', name: 'NDONOLO ZAMBO', id: "030c"),
  PlayerInfoModel(team: 'AEK Athens', position: 'MID', name: 'RAZVAN MARIN', id: "099t"),

  // AEK Athens Forwards
  PlayerInfoModel(team: 'AEK Athens', position: 'FWD', name: 'ÉRIK LAMELA', id: "054m"),
  PlayerInfoModel(team: 'AEK Athens', position: 'FWD', name: 'DEREK KUTESA', id: "764x"),
  PlayerInfoModel(team: 'AEK Athens', position: 'FWD', name: 'FRANTZDY PIERROT', id: "134c"),
  PlayerInfoModel(team: 'AEK Athens', position: 'FWD', name: 'ANTHONY MARTIAL', id: "926b"),

  // Panathinaikos Goalkeepers
  PlayerInfoModel(team: 'Panathinaikos', position: 'GK', name: 'YURI LODYGIN', id: "156a"),
  PlayerInfoModel(team: 'Panathinaikos', position: 'GK', name: 'BARTŁOMIEJ DRĄGOWSKI', id: "652h"),
  PlayerInfoModel(team: 'Panathinaikos', position: 'GK', name: 'ALBAN LAFONT', id: "289d"),
  PlayerInfoModel(team: 'Panathinaikos', position: 'GK', name: 'KONSTANTINOS KOTSARIS', id: "873j"),

  // Panathinaikos Defenders
  PlayerInfoModel(team: 'Panathinaikos', position: 'DEF', name: 'GIORGOS VAGIANNIDIS', id: "492e"),
  PlayerInfoModel(team: 'Panathinaikos', position: 'DEF', name: 'GIORGOS KYRIAKOPOULOS', id: "930f"),
  PlayerInfoModel(team: 'Panathinaikos', position: 'DEF', name: 'AHMED TOUBA', id: "835m"),
  PlayerInfoModel(team: 'Panathinaikos', position: 'DEF', name: 'ERIK PALMER-BROWN', id: "621l"),
  PlayerInfoModel(team: 'Panathinaikos', position: 'DEF', name: 'INGI INGASON', id: "442c"),

  // Panathinaikos Midfielders
  PlayerInfoModel(team: 'Panathinaikos', position: 'MID', name: 'PEDRO CHIRIVELLA', id: "333d"),
  PlayerInfoModel(team: 'Panathinaikos', position: 'MID', name: 'TETÊ', id: "572y"),
  PlayerInfoModel(team: 'Panathinaikos', position: 'MID', name: 'TASOS BAKASETAS', id: "234m"),
  PlayerInfoModel(team: 'Panathinaikos', position: 'MID', name: 'ADAM GNEZDA ČERIN', id: "924q"),
  
  // Panathinaikos Forwards
  PlayerInfoModel(team: 'Panathinaikos', position: 'FWD', name: 'FOTIS IOANNIDIS', id: "982c"),
  PlayerInfoModel(team: 'Panathinaikos', position: 'FWD', name: 'KAROL ŚWIDERSKI', id: "673m"),
  PlayerInfoModel(team: 'Panathinaikos', position: 'FWD', name: 'ALEXANDER JEREMEJEFF', id: "290s"),
];