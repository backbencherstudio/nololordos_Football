// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:nololordos/features/home_screen%20(Rooster%20view)/Riverpod/player_info_model.dart';
// import 'package:uuid/uuid.dart';

// import 'delete_provider_selection.dart';

// /// Players provider with both team rosters
// final playersProvider =
// StateNotifierProvider<PlayersNotifier, List<PlayerInfoModel>>(
//       (ref) => PlayersNotifier(),
// );

// class PlayersNotifier extends StateNotifier<List<PlayerInfoModel>> {
//   PlayersNotifier()
//       : super(playersInfo);

  

//   void addPlayer(String team, String position, String name, [String? id]) {
//     final generatedId = id ?? const Uuid().v4();
//     state = [...state, PlayerInfoModel(team: team, name: name,position: position,id: generatedId)];
//   }

//   void updatePlayer(int index, String value) {
//     final updated = [...state];
//     updated[index].name = value;
//     state = updated;
//   }


//   void deletePlayersByIds(List<String> ids) {
//     state = state.where((p) => !ids.contains(p.id)).toList();
//   }

//   /// This stays here to track selected IDs
//   List<String> selectedIds = [];

//   void togglePlayerSelection(String id) {
//     if (selectedIds.contains(id)) {
//       selectedIds.remove(id);
//     } else {
//       selectedIds.add(id);
//     }
//   }
// }


// /// Provider to manage select-all/unselect-all for team + position
// final allPlayersTeamPositionSelectionProvider =
// Provider.family<bool, Map<String, String>>((ref, data) {
//   final players = ref.watch(playersProvider);
//   final selectedIds = ref.watch(deletePlayerIdListProvider);

//   final team = data['team']!;
//   final position = data['position']!;

//   // Get all IDs for team + position
//   final ids = players
//       .where((p) => p.team == team && p.position == position)
//       .map((p) => p.id )
//       .toList();

//   if (ids.isEmpty) return false;

//   // True only if all are selected
//   return ids.every((id) => selectedIds.contains(id));
// });

// /// Method to toggle select-all
// void toggleSelectAllPlayers(
//     WidgetRef ref,
//     String team,
//     String position,
//     ) {
//   final players = ref.read(playersProvider);
//   final selectedIds = ref.read(deletePlayerIdListProvider.notifier);

//   final ids = players
//       .where((p) => p.team == team && p.position == position)
//       .map((p) => p.id)
//       .toList();

//   if (ids.isEmpty) return;

//   final currentList = [...ref.read(deletePlayerIdListProvider)];
//   final allSelected = ids.every((id) => currentList.contains(id));

//   if (allSelected) {
//     // Unselect all of them
//     currentList.removeWhere((id) => ids.contains(id));
//   } else {
//     // Select all of them
//     for (final id in ids) {
//       if (!currentList.contains(id)) currentList.add(id);
//     }
//   }

//   selectedIds.state = currentList;
// }
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/Riverpod/delete_provider_selection.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/Riverpod/player_info_model.dart';
import 'package:uuid/uuid.dart';


/// Players provider with both team rosters
final playersProvider =
StateNotifierProvider<PlayersNotifier, List<PlayerInfoModel>>(
  (ref) => PlayersNotifier(),
);

class PlayersNotifier extends StateNotifier<List<PlayerInfoModel>> {
  PlayersNotifier()
      : super(playersInfo);  // Initialize state with predefined list of players

  void addPlayer(String team, String position, String name, [String? id]) {
    final generatedId = id ?? const Uuid().v4();
    state = [
      ...state,
      PlayerInfoModel(team: team, name: name, position: position, id: generatedId)
    ];
  }

  // Function to update the player's name by index
  void updatePlayerName(int index, String name) {
    final updated = [...state];
    updated[index].name = name;
    state = updated;
  }

  // Function to increment a player's goals
  void incrementGoals(int index) {
    final updated = [...state];
    if (updated[index].goals == 15.0) {
      updated[index].goals = -1; // Reset goals if it reaches 15
    }
    updated[index].goals++;
    state = updated;
  }
void updatePlayer(int index, String key, String value) {
    final updated = [...state];
    switch (key) {
      case 'SR':
        updated[index].sr = value;
        break;
      case 'GM':
        updated[index].gm = value;
        break;
      case 'GL':
        updated[index].gl = value;
        break;
      case 'AGL':
        updated[index].agl = value;
        break;
      case '-GL':
        updated[index].minusGl = value;
        break;
      case '-AGL':
        updated[index].minusAgl = value;
        break;
      case 'name':
        updated[index].name = value;
        break;
      default:
        break;
    }
    state = updated;
  }
  // Function to increment a player's own goals
  void incrementOwnGoals(int index) {
    final updated = [...state];
    if (updated[index].ownGoals == 15) {
      updated[index].ownGoals = -1; // Reset own goals if it reaches 15
    }
   updated[index].ownGoals++;
    state = updated;
  }

  // Function to update the selected score for a player
  void selectScore(int index, int score) {
    final updated = [...state];
    updated[index].selectedScore = score;
    state = updated;
  }

  // Function to update the match name for a player
  void updateMatchName(int index, String matchName) {
    final updated = [...state];
    updated[index].matchName = matchName;
    state = updated;
  }

  // Function to update the teams playing the match for a player
  void updateTeams(int index, String teamOne, String teamTwo) {
    final updated = [...state];
    updated[index].teamOne = teamOne;
    updated[index].teamTwo = teamTwo;
    state = updated;
  }

  // Function to update the scores for both teams in a match
  void updateTeamScores(int index, String teamOneScore, String teamTwoScore) {
    final updated = [...state];
    updated[index].teamOneScore = teamOneScore;
    updated[index].teamTwoScore = teamTwoScore;
    state = updated;
  }

  // Function to update the match date for a player
  void updateDate(int index, String date) {
    final updated = [...state];
    updated[index].date = date;
    state = updated;
  }

  // Function to delete players by IDs
  void deletePlayersByIds(List<String> ids) {
    state = state.where((p) => !ids.contains(p.id)).toList();
  }

  /// This stays here to track selected IDs
  List<String> selectedIds = [];

  // Function to toggle player selection
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