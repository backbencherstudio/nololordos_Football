import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/Riverpod/player_info_model.dart';
import 'package:uuid/uuid.dart';

import 'delete_provider_selection.dart';

/// Players provider with both team rosters
final playersProvider =
StateNotifierProvider<PlayersNotifier, List<PlayerInfoModel>>(
      (ref) => PlayersNotifier(),
);

class PlayersNotifier extends StateNotifier<List<PlayerInfoModel>> {
  PlayersNotifier()
      : super(playersInfo);

  

  void addPlayer(String team, String position, String name, [String? id]) {
    final generatedId = id ?? const Uuid().v4();
    state = [...state, PlayerInfoModel(team: team, name: name,position: position,id: generatedId)];
  }

  void updatePlayer(int index, String value) {
    final updated = [...state];
    updated[index].name = value;
    state = updated;
  }

  void deletePlayersByIds(List<String> ids) {
    state = state.where((p) => !ids.contains(p.id)).toList();
  }

  /// This stays here to track selected IDs
  List<String> selectedIds = [];

  void togglePlayerSelection(String id) {
    if (selectedIds.contains(id)) {
      selectedIds.remove(id);
    } else {
      selectedIds.add(id);
    }
  }
}


/// Provider to manage select-all/unselect-all for team + position
final allPlayersTeamPositionSelectionProvider =
Provider.family<bool, Map<String, String>>((ref, data) {
  final players = ref.watch(playersProvider);
  final selectedIds = ref.watch(deletePlayerIdListProvider);

  final team = data['team']!;
  final position = data['position']!;

  // Get all IDs for team + position
  final ids = players
      .where((p) => p.team == team && p.position == position)
      .map((p) => p.id )
      .toList();

  if (ids.isEmpty) return false;

  // True only if all are selected
  return ids.every((id) => selectedIds.contains(id));
});

/// Method to toggle select-all
void toggleSelectAllPlayers(
    WidgetRef ref,
    String team,
    String position,
    ) {
  final players = ref.read(playersProvider);
  final selectedIds = ref.read(deletePlayerIdListProvider.notifier);

  final ids = players
      .where((p) => p.team == team && p.position == position)
      .map((p) => p.id)
      .toList();

  if (ids.isEmpty) return;

  final currentList = [...ref.read(deletePlayerIdListProvider)];
  final allSelected = ids.every((id) => currentList.contains(id));

  if (allSelected) {
    // Unselect all of them
    currentList.removeWhere((id) => ids.contains(id));
  } else {
    // Select all of them
    for (final id in ids) {
      if (!currentList.contains(id)) currentList.add(id);
    }
  }

  selectedIds.state = currentList;
}
