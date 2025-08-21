// players_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'player_info_model.dart';
import 'delete_provider_selection.dart';

final playersProvider =
    StateNotifierProvider<PlayersNotifier, List<PlayerInfoModel>>(
      (ref) => PlayersNotifier(),
    );

class PlayersNotifier extends StateNotifier<List<PlayerInfoModel>> {
  PlayersNotifier() : super(playersInfo);

  void addPlayer(String team, String position, String name, [String? id]) {
    final generatedId = id ?? const Uuid().v4();
    state = [
      ...state,
      PlayerInfoModel(
        team: team,
        name: name,
        position: position,
        id: generatedId,
      ),
    ];
  }

  void updatePlayer(String id, String key, String value) {
    final index = state.indexWhere((p) => p.id == id);
    if (index == -1) return;

    final player = state[index];

    PlayerInfoModel updatedPlayer = switch (key) {
      'GOALS' => player.copyWith(goals: double.tryParse(value) ?? 0),
      'GM' => player.copyWith(gm: double.tryParse(value) ?? 0),
      'GL' => player.copyWith(gl: double.tryParse(value) ?? 0),
      'AGL' => player.copyWith(agl: double.tryParse(value) ?? 0),
      '-GL' => player.copyWith(minusGl: double.tryParse(value) ?? 0),
      '-AGL' => player.copyWith(minusAgl: double.tryParse(value) ?? 0),
      _ => player,
    };

    final updatedList = [...state];
    updatedList[index] = updatedPlayer;
    state = updatedList;
  }

  void resetAllValues() {
    state = playersInfo;
    selectedIds = [];
  }

  void incrementGoals(String id) {
    final index = state.indexWhere((p) => p.id == id);
    if (index == -1) return;

    final player = state[index];
    final newGoals = (player.goals == 15.0) ? 0.0 : player.goals + 1;

    final updatedPlayer = player.copyWith(goals: newGoals);

    final updatedList = [...state];
    updatedList[index] = updatedPlayer;
    state = updatedList;
  }

  void incrementOwnGoals(String id) {
    final index = state.indexWhere((p) => p.id == id);
    if (index == -1) return;

    final player = state[index];
    final newOwnGoals = player.ownGoals == 15 ? -1 : player.ownGoals + 1;

    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index)
          player.copyWith(ownGoals: newOwnGoals.toDouble())
        else
          state[i],
    ];
  }

  void selectScore(String id, int score) =>
      _updateById(id, (p) => p.copyWith(selectedScore: score));

  void updateMatchName(String id, String matchName) =>
      _updateById(id, (p) => p.copyWith(matchName: matchName));

  void updateTeams(String id, String teamOne, String teamTwo) =>
      _updateById(id, (p) => p.copyWith(teamOne: teamOne, teamTwo: teamTwo));

  void updateTeamScores(String id, String teamOneScore, String teamTwoScore) =>
      _updateById(
        id,
        (p) =>
            p.copyWith(teamOneScore: teamOneScore, teamTwoScore: teamTwoScore),
      );

  void updateDate(String id, String date) =>
      _updateById(id, (p) => p.copyWith(date: date));

  void _updateById(
    String id,
    PlayerInfoModel Function(PlayerInfoModel) updater,
  ) {
    final index = state.indexWhere((p) => p.id == id);
    if (index == -1) return;

    final updated = [...state];
    updated[index] = updater(updated[index]);
    state = updated;
  }

  void deletePlayersByIds(List<String> ids) {
    state = state.where((p) => !ids.contains(p.id)).toList();
  }

  List<String> selectedIds = [];

  void togglePlayerSelection(String id) {
    if (selectedIds.contains(id)) {
      selectedIds.remove(id);
    } else {
      selectedIds.add(id);
    }
  }
}

final allPlayersTeamPositionSelectionProvider =
    Provider.family<bool, Map<String, String>>((ref, data) {
      final players = ref.watch(playersProvider);
      final selectedIds = ref.watch(deletePlayerIdListProvider);

      final team = data['team']!;
      final position = data['position']!;

      final ids = players
          .where((p) => p.team == team && p.position == position)
          .map((p) => p.id)
          .toList();

      if (ids.isEmpty) return false;

      return ids.every((id) => selectedIds.contains(id));
    });

void toggleSelectAllPlayers(WidgetRef ref, String team, String position) {
  final players = ref.read(playersProvider);
  final selectedIdsNotifier = ref.read(deletePlayerIdListProvider.notifier);

  final ids = players
      .where((p) => p.team == team && p.position == position)
      .map((p) => p.id)
      .toList();

  if (ids.isEmpty) return;

  final currentList = [...ref.read(deletePlayerIdListProvider)];
  final allSelected = ids.every((id) => currentList.contains(id));

  if (allSelected) {
    currentList.removeWhere((id) => ids.contains(id));
  } else {
    for (final id in ids) {
      if (!currentList.contains(id)) currentList.add(id);
    }
  }

  selectedIdsNotifier.state = currentList;
}

//match count
final matchCountProvider = StateProvider<double>((_) => 0.00);

//ScoreCount

final scoreCountPerMatch = StateProvider<int>((ref) => 0);
