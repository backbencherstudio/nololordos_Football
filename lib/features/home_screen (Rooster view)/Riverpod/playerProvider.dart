
import 'package:flutter_riverpod/flutter_riverpod.dart';

final playersProvider = StateNotifierProvider<PlayersNotifier, List<Map<String, dynamic>>>(
  (ref) => PlayersNotifier(),
);

class PlayersNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  PlayersNotifier() : super([]);

  void addPlayer(String name,String position) {
    state = [
      ...state,
      {
        'name': name,
        'position': position,
        'SR': '',
        'GM': '',
        'GL': '',
        'AGL': '',
        '-GL': '',
        '-AGL': '',
      }
    ];
  }

  void updatePlayer(int index, String key, String value) {
    final updatedPlayers = [...state];
    updatedPlayers[index][key] = value;
    state = updatedPlayers;
  }
}
