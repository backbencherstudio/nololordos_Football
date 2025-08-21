import 'package:flutter_riverpod/flutter_riverpod.dart';

/// UI-only selection (what box is currently highlighted per player)
/// Map<playerId, selectedScore?> — null = no selection
class SelectedScoreNotifier extends StateNotifier<Map<String, int?>> {
  SelectedScoreNotifier() : super({});

  void toggle(String playerId, int score) {
    final current = state[playerId];
    if (current == score) {
      state = { ...state, playerId: null }; // unselect same
    } else {
      state = { ...state, playerId: score }; // select new
    }
  }

  int? getSelected(String playerId) => state[playerId];

  void clearPlayer(String playerId) {
    if (!state.containsKey(playerId)) return;
    state = { ...state, playerId: null };
  }

  void clearAll() => state = {};
}

final selectedScoreProvider =
StateNotifierProvider<SelectedScoreNotifier, Map<String, int?>>(
      (ref) => SelectedScoreNotifier(),
);
final lastAddedProvider = StateProvider<Map<String, int?>>((ref) => {});