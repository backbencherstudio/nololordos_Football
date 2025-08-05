import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart'; // Import UUID package

/// Players provider with both team rosters
final playersProvider = StateNotifierProvider<PlayersNotifier, List<Map<String, dynamic>>>(
  (ref) => PlayersNotifier(),
);

class PlayersNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  PlayersNotifier()
      : super([
          // ✅ AEK Athens Goalkeepers with predefined IDs
          _player('AEK Athens', 'GK', 'THOMAS STRAKOSHA', "012a"),
          _player('AEK Athens', 'GK', 'ANGELOS ANGELOPOULOS', "011a"),
          _player('AEK Athens', 'GK', 'ALBERTO BRIGNOLI', "105d"),
          _player('AEK Athens', 'GK', 'MARIOS BALAMIOTIS', "846s"),

          // ✅ AEK Athens Defenders with predefined IDs
          _player('AEK Athens', 'DEF', 'HAROLD MOUKOUTI', "87c8"),
          _player('AEK Athens', 'DEF', 'STAVROS PILIOS', "484d"),
          _player('AEK Athens', 'DEF', 'LAZAROS ROTA', "970c"),
          _player('AEK Athens', 'DEF', 'ALEXANDER CALLENS', "54f5"),
          _player('AEK Athens', 'DEF', 'DOMAGOJ VIDA', "046f"),
          _player('AEK Athens', 'DEF', 'GERASIMOS MITOGLOU', "706g"),
          _player('AEK Athens', 'DEF', 'JAMES PENRICE', "462f"),
          _player('AEK Athens', 'DEF', 'MOSES ODUBAJO', "020k"),
          _player('AEK Athens', 'DEF', 'FILIPE RELVAS', "101l"),

          // ✅ AEK Athens Midfielders with predefined IDs
          _player('AEK Athens', 'MID', 'ORBELÍN PINEDA', "846q"),
          _player('AEK Athens', 'MID', 'PETROS MANTALOS', "793p"),
          _player('AEK Athens', 'MID', 'ROBERTO PEREYRA', "964w"),
          _player('AEK Athens', 'MID', 'NDONOLO ZAMBO', "030c"),
          _player('AEK Athens', 'MID', 'RAZVAN MARIN', "099t"),
          _player('AEK Athens', 'MID', 'DAMIAN SZYMAŃSKI', "020u"),
          _player('AEK Athens', 'MID', 'NIKLAS ELIASSON', "302a"),
          _player('AEK Athens', 'MID', 'ROBERT LJUBIČIĆ', "100r"),
          _player('AEK Athens', 'MID', 'PAOLO FERNÁNDEZ', "812g"),
          _player('AEK Athens', 'MID', 'ÉRIK LAMELA', "123e"),
          _player('AEK Athens', 'MID', 'ABOUBAKARY KOITA', "782f"),
          _player('AEK Athens', 'MID', 'JENS JONSSON', "362l"),
          _player('AEK Athens', 'MID', 'MIJAT GAĆINOVIĆ', "256s"),

          // ✅ AEK Athens Forwards with predefined IDs
          _player('AEK Athens', 'FWD', 'ÉRIK LAMELA', "054m"),
          _player('AEK Athens', 'FWD', 'DEREK KUTESA', "764x"),
          _player('AEK Athens', 'FWD', 'FRANTZDY PIERROT', "134c"),
          _player('AEK Athens', 'FWD', 'ANTHONY MARTIAL', "926b"),
          _player('AEK Athens', 'FWD', 'ELIAN SOSA', "352h"),
          _player('AEK Athens', 'FWD', 'DIMITRIS KALOSKAMIS', "568g"),
          _player('AEK Athens', 'FWD', 'ANTONIO ZINI', "912f"),

          // ✅ Panathinaikos Goalkeepers with predefined IDs
          _player('Panathinaikos', 'GK', 'YURI LODYGIN', "156a"),
          _player('Panathinaikos', 'GK', 'BARTŁOMIEJ DRĄGOWSKI', "652h"),
          _player('Panathinaikos', 'GK', 'ALBAN LAFONT', "289d"),
          _player('Panathinaikos', 'GK', 'KONSTANTINOS KOTSARIS', "873j"),

          // ✅ Panathinaikos Defenders with predefined IDs
          _player('Panathinaikos', 'DEF', 'GIORGOS VAGIANNIDIS', "492e"),
          _player('Panathinaikos', 'DEF', 'GIORGOS KYRIAKOPOULOS', "930f"),
          _player('Panathinaikos', 'DEF', 'AHMED TOUBA', "835m"),
          _player('Panathinaikos', 'DEF', 'ERIK PALMER-BROWN', "621l"),
          _player('Panathinaikos', 'DEF', 'INGI INGASON', "442c"),
          _player('Panathinaikos', 'DEF', 'AZZEDINE OUNAHI', "184r"),
          _player('Panathinaikos', 'DEF', 'TIN JEDVAJ', "018g"),
          _player('Panathinaikos', 'DEF', 'FILIP MLADENOVIĆ', "673k"),
          _player('Panathinaikos', 'DEF', 'ELTJON FIKAJ', "193x"),
          _player('Panathinaikos', 'DEF', 'GIANNIS KOTSIIRAS', "557p"),

          // ✅ Panathinaikos Midfielders with predefined IDs
          _player('Panathinaikos', 'MID', 'PEDRO CHIRIVELLA', "333d"),
          _player('Panathinaikos', 'MID', 'TETÊ', "572y"),
          _player('Panathinaikos', 'MID', 'TASOS BAKASETAS', "234m"),
          _player('Panathinaikos', 'MID', 'ADAM GNEZDA ČERIN', "924q"),
          _player('Panathinaikos', 'MID', 'DANIEL MANCINI', "490a"),
          _player('Panathinaikos', 'MID', 'NEMANJA MAKSIMOVIĆ', "109s"),
          _player('Panathinaikos', 'MID', 'MANOLIS SIOPIS', "265t"),
          _player('Panathinaikos', 'MID', 'FACUNDO PELLISTRI', "147j"),
          _player('Panathinaikos', 'MID', 'IOANNIS GAVRIIL BOKOS', "736k"),
          _player('Panathinaikos', 'MID', 'ADRIANO BREGU', "629f"),
          _player('Panathinaikos', 'MID', 'FILIP ĐURIČIĆ', "288z"),
          _player('Panathinaikos', 'MID', 'GIORGOS NIKAS', "501n"),

          // ✅ Panathinaikos Forwards with predefined IDs
          _player('Panathinaikos', 'FWD', 'FOTIS IOANNIDIS', "982c"),
          _player('Panathinaikos', 'FWD', 'KAROL ŚWIDERSKI', "673m"),
          _player('Panathinaikos', 'FWD', 'ALEXANDER JEREMEJEFF', "290s"),
        ]);

  /// Helper to create player map with unique ID
  static Map<String, dynamic> _player(String team, String position, String name, String id) {
    return {
      'team': team,
      'position': position,
      'name': name,
      'id': id, // Custom ID passed for each player
      'SR': '',
      'GM': '',
      'GL': '',
      'AGL': '',
      '-GL': '',
      '-AGL': '',
    };
  }

  /// Add new player with generated id
  void addPlayer(String team, String position, String name, [String? id]) {
    // If no custom ID is provided, generate a new UUID
    String generatedId = id ?? Uuid().v4();
    state = [...state, _player(team, position, name, generatedId)];
  }

  /// Update player stat
  void updatePlayer(int index, String key, String value) {
    final updated = [...state];
    updated[index][key] = value;
    state = updated;
  }

  // Delete players based on position and id
  void deletePlayerByPositionAndId(String position, String id) {
    state = state.where((player) {
      // Remove players who match the provided position and id
      return !(player['position'] == position && player['id'] == id);
    }).toList();
  }
}

/// Provider to track selected players for deletion

final deletePlayerIdListProvider = StateProvider<List<String>>((ref) => []);

/// Create a provider to handle deletion of players by position and ID
final playerDeletionProvider = StateNotifierProvider<PlayerDeletionNotifier, List<Map<String, dynamic>>>(
  (ref) => PlayerDeletionNotifier(ref.read(playersProvider.notifier)),
);

class PlayerDeletionNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  final PlayersNotifier playersNotifier;

  PlayerDeletionNotifier(this.playersNotifier) : super(playersNotifier.state);

  // Delete players based on position and id
  void deletePlayerByPositionAndId(String position, String id) {
    state = state.where((player) {
      // Remove players who match the provided position and id
      return !(player['position'] == position && player['id'] == id);
    }).toList();
  }
}
