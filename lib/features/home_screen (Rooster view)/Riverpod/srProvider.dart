import 'package:flutter_riverpod/flutter_riverpod.dart';

final scoresCollectionProvider =
    StateNotifierProvider<ScoresCollectionNotifier, List<int>>(
  (ref) => ScoresCollectionNotifier(),
);
// The Notifier
class ScoresCollectionNotifier extends StateNotifier<List<int>> {
  ScoresCollectionNotifier() : super([]);

  // Add a single score
  void addScore(int score) {
    state = [...state, score];
  }

  // Add multiple scores at once
  void addScores(List<int> scores) {
    state = [...state, ...scores];
  }

  // Remove a score by index
  void removeScoreAt(int index) {
    if (index < 0 || index >= state.length) return;
    final newList = [...state]..removeAt(index);
    state = newList;
  }

  // Clear all scores
  void clearScores() {
    state = [];
  }
}

// The Provider


final totalScoreProvider = Provider<double>((ref) {
  final scores = ref.watch(scoresCollectionProvider);
  return scores.fold<int>(0, (a, b) => a + b).toDouble();
});

final srProvider = Provider<double>((ref) {
  final scores = ref.watch(scoresCollectionProvider);
  if (scores.isEmpty) return 0.0;
  final sum = scores.fold<int>(0, (a, b) => a + b);
  return double.parse((sum / scores.length).toStringAsFixed(2));
});