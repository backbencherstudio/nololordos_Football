import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nololordos/features/match_day_screen/Riverpod/player_state_model.dart';



final playerListProvider =
    StateNotifierProvider<PlayerListNotifier, List<PlayerData>>(
        (ref) => PlayerListNotifier());
        



class PlayerListNotifier extends StateNotifier<List<PlayerData>> {
  PlayerListNotifier() : super([]);

  void addPlayer() {
    state = [...state, PlayerData()];
  }

  void updateName(int index, String name) {
    final updated = [...state];
    updated[index].name = name;
    state = updated;
  }

  void incrementGoals(int index) {
    final updated = [...state];
    updated[index].goals++;
    state = updated;
  }

  void incrementOwnGoals(int index) {
    final updated = [...state];
    updated[index].ownGoals++;
    state = updated;
  }

  void selectScore(int index, int score) {
    final updated = [...state];
    updated[index].selectedScore = score;
    state = updated;
  }
}

