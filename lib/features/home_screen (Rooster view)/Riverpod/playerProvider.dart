import 'package:flutter_riverpod/flutter_riverpod.dart';


/// Players provider with both team rosters
final playersProvider = StateNotifierProvider<PlayersNotifier, List<Map<String, dynamic>>>(
  (ref) => PlayersNotifier(),
);

class PlayersNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  PlayersNotifier()
      : super([
          // ✅ AEK Athens Goalkeepers
          _player('AEK Athens', 'GK', 'THOMAS STRAKOSHA'),
          _player('AEK Athens', 'GK', 'ANGELOS ANGELOPOULOS'),
          _player('AEK Athens', 'GK', 'ALBERTO BRIGNOLI'),
          _player('AEK Athens', 'GK', 'MARIOS BALAMIOTIS'),

          // ✅ AEK Athens Defenders
          _player('AEK Athens', 'DEF', 'HAROLD MOUKOUTI'),
          _player('AEK Athens', 'DEF', 'STAVROS PILIOS'),
          _player('AEK Athens', 'DEF', 'LAZAROS ROTA'),
          _player('AEK Athens', 'DEF', 'ALEXANDER CALLENS'),
          _player('AEK Athens', 'DEF', 'DOMAGOJ VIDA'),
          _player('AEK Athens', 'DEF', 'GERASIMOS MITOGLOU'),
          _player('AEK Athens', 'DEF', 'JAMES PENRICE'),
          _player('AEK Athens', 'DEF', 'MOSES ODUBAJO'),
          _player('AEK Athens', 'DEF', 'FILIPE RELVAS'),

          // ✅ AEK Athens Midfielders
          _player('AEK Athens', 'MID', 'ORBELÍN PINEDA'),
          _player('AEK Athens', 'MID', 'PETROS MANTALOS'),
          _player('AEK Athens', 'MID', 'ROBERTO PEREYRA'),
          _player('AEK Athens', 'MID', 'NDONOLO ZAMBO'),
          _player('AEK Athens', 'MID', 'RAZVAN MARIN'),
          _player('AEK Athens', 'MID', 'DAMIAN SZYMAŃSKI'),
          _player('AEK Athens', 'MID', 'NIKLAS ELIASSON'),
          _player('AEK Athens', 'MID', 'ROBERT LJUBIČIĆ'),
          _player('AEK Athens', 'MID', 'PAOLO FERNÁNDEZ'),
          _player('AEK Athens', 'MID', 'ÉRIK LAMELA'),
          _player('AEK Athens', 'MID', 'ABOUBAKARY KOITA'),
          _player('AEK Athens', 'MID', 'JENS JONSSON'),
          _player('AEK Athens', 'MID', 'MIJAT GAĆINOVIĆ'),

          // ✅ AEK Athens Forwards
          _player('AEK Athens', 'FWD', 'ÉRIK LAMELA'),
          _player('AEK Athens', 'FWD', 'DEREK KUTESA'),
          _player('AEK Athens', 'FWD', 'FRANTZDY PIERROT'),
          _player('AEK Athens', 'FWD', 'ANTHONY MARTIAL'),
          _player('AEK Athens', 'FWD', 'ELIAN SOSA'),
          _player('AEK Athens', 'FWD', 'DIMITRIS KALOSKAMIS'),
          _player('AEK Athens', 'FWD', 'ANTONIO ZINI'),

          // ✅ Panathinaikos Goalkeepers
          _player('Panathinaikos', 'GK', 'YURI LODYGIN'),
          _player('Panathinaikos', 'GK', 'BARTŁOMIEJ DRĄGOWSKI'),
          _player('Panathinaikos', 'GK', 'ALBAN LAFONT'),
          _player('Panathinaikos', 'GK', 'KONSTANTINOS KOTSARIS'),

          // ✅ Panathinaikos Defenders
          _player('Panathinaikos', 'DEF', 'GIORGOS VAGIANNIDIS'),
          _player('Panathinaikos', 'DEF', 'GIORGOS KYRIAKOPOULOS'),
          _player('Panathinaikos', 'DEF', 'AHMED TOUBA'),
          _player('Panathinaikos', 'DEF', 'ERIK PALMER-BROWN'),
          _player('Panathinaikos', 'DEF', 'INGI INGASON'),
          _player('Panathinaikos', 'DEF', 'AZZEDINE OUNAHI'),
          _player('Panathinaikos', 'DEF', 'TIN JEDVAJ'),
          _player('Panathinaikos', 'DEF', 'FILIP MLADENOVIĆ'),
          _player('Panathinaikos', 'DEF', 'ELTJON FIKAJ'),
          _player('Panathinaikos', 'DEF', 'GIANNIS KOTSIIRAS'),

          // ✅ Panathinaikos Midfielders
          _player('Panathinaikos', 'MID', 'PEDRO CHIRIVELLA'),
          _player('Panathinaikos', 'MID', 'TETÊ'),
          _player('Panathinaikos', 'MID', 'TASOS BAKASETAS'),
          _player('Panathinaikos', 'MID', 'ADAM GNEZDA ČERIN'),
          _player('Panathinaikos', 'MID', 'DANIEL MANCINI'),
          _player('Panathinaikos', 'MID', 'NEMANJA MAKSIMOVIĆ'),
          _player('Panathinaikos', 'MID', 'MANOLIS SIOPIS'),
          _player('Panathinaikos', 'MID', 'FACUNDO PELLISTRI'),
          _player('Panathinaikos', 'MID', 'IOANNIS GAVRIIL BOKOS'),
          _player('Panathinaikos', 'MID', 'ADRIANO BREGU'),
          _player('Panathinaikos', 'MID', 'FILIP ĐURIČIĆ'),
          _player('Panathinaikos', 'MID', 'GIORGOS NIKAS'),

          // ✅ Panathinaikos Forwards
          _player('Panathinaikos', 'FWD', 'FOTIS IOANNIDIS'),
          _player('Panathinaikos', 'FWD', 'KAROL ŚWIDERSKI'),
          _player('Panathinaikos', 'FWD', 'ALEXANDER JEREMEJEFF'),
        ]);

  /// Helper to create player map
  static Map<String, dynamic> _player(String team, String position, String name) {
    return {
      'team': team,
      'position': position,
      'name': name,
      'SR': '',
      'GM': '',
      'GL': '',
      'AGL': '',
      '-GL': '',
      '-AGL': '',
    };
  }

  /// Add new player
  void addPlayer(String team, String position, String name) {
    state = [...state, _player(team, position, name)];
    //state = state.add(_player(team, position, name));
  }

  /// Update player stat
  void updatePlayer(int index, String key, String value) {
    final updated = [...state];
    updated[index][key] = value;
    state = updated;
  }
}
