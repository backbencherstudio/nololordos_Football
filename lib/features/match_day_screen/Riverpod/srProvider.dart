import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/Riverpod/playerProvider.dart';

final srProvider = StateProvider<Map<String, List<int>>>((ref) {
  return {}; // playerId -> list of scores
});

void addScore(WidgetRef ref, String playerId, int score) {
  final current = ref.read(srProvider);

  // Get existing scores for this player
  final scores = current[playerId] ?? [];

  // Update the map
  ref.read(srProvider.notifier).state = {
    ...current,
    playerId: [...scores, score], // add new score
  };
}
final totalAverageSumProvider = StateProvider<double>((_) => 0.0);

final averageScoreProvider = StateProvider<double>((ref) => 0.0);
final finalAverageProvider = Provider<double>((ref) {
  final totalAvgSum = ref.watch(totalAverageSumProvider);
  final matchCount = ref.watch(matchCountProvider);

  if (matchCount == 0) return 0.0;
  return totalAvgSum / matchCount;
});