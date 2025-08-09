// score_book_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/Riverpod/scoreEntry_model.dart';
import 'package:uuid/uuid.dart';

final scoreBookProvider =
    StateNotifierProvider<ScoreBookNotifier, Map<String, List<ScoreEntry>>>(
  (ref) => ScoreBookNotifier(),
);

class ScoreBookNotifier extends StateNotifier<Map<String, List<ScoreEntry>>> {
  ScoreBookNotifier() : super(const {});

  List<ScoreEntry> _listFor(String playerId) => state[playerId] ?? const [];

  void addEntry({
    required String playerId,
    required String matchId,
    double goals = 0,
    double gl = 0,
    double agl = 0,
    double minusGl = 0,
    double minusAgl = 0,
    DateTime? at,
  }) {
    final entry = ScoreEntry(
      id: const Uuid().v4(),
      matchId: matchId,
      at: at ?? DateTime.now(),
      goals: goals,
      gl: gl,
      agl: agl,
      minusGl: minusGl,
      minusAgl: minusAgl,
    );

    final updated = Map<String, List<ScoreEntry>>.from(state);
    updated[playerId] = [..._listFor(playerId), entry];
    state = updated;
  }

  void updateEntry({
    required String playerId,
    required String entryId,
    double? goals,
    double? gl,
    double? agl,
    double? minusGl,
    double? minusAgl,
  }) {
    final list = _listFor(playerId);
    final idx = list.indexWhere((e) => e.id == entryId);
    if (idx == -1) return;

    final updatedEntry = list[idx].copyWith(
      goals: goals,
      gl: gl,
      agl: agl,
      minusGl: minusGl,
      minusAgl: minusAgl,
    );

    final updated = Map<String, List<ScoreEntry>>.from(state);
    final newList = [...list];
    newList[idx] = updatedEntry;
    updated[playerId] = newList;
    state = updated;
  }

  void removeEntry(String playerId, String entryId) {
    final list = _listFor(playerId);
    final newList = list.where((e) => e.id != entryId).toList();
    if (newList.length == list.length) return;

    final updated = Map<String, List<ScoreEntry>>.from(state);
    updated[playerId] = newList;
    state = updated;
  }

  void clearPlayer(String playerId) {
    if (!state.containsKey(playerId)) return;
    final updated = Map<String, List<ScoreEntry>>.from(state);
    updated.remove(playerId);
    state = updated;
  }

  void clearMatchForAll(String matchId) {
    final updated = <String, List<ScoreEntry>>{};
    for (final entry in state.entries) {
      updated[entry.key] =
          entry.value.where((e) => e.matchId != matchId).toList();
    }
    state = updated;
  }
}
