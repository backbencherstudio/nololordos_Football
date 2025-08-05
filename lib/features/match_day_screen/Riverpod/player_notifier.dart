import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nololordos/features/match_day_screen/Riverpod/player_state_model.dart';
import 'package:nololordos/features/home_screen (Rooster view)/Riverpod/playerProvider.dart';
import 'package:nololordos/features/Team_Selection_screen/Riverpod/selection_provider.dart'; 

final playerListProvider =
    StateNotifierProvider<PlayerListNotifier, List<PlayerData>>(
  (ref) {
    final players = ref.watch(playersProvider); // Watch the playersProvider to listen to updates
    final selectedTeam = ref.watch(selectionProvider); // Watch the selected team

    // Filter players based on selected team
    final filteredPlayers = players
        .where((p) => p['team'] == selectedTeam) // Filter by team
        .map((p) => PlayerData(name: p['name'])) // Convert to PlayerData
        .toList();

    return PlayerListNotifier(filteredPlayers); 
  },
);

class PlayerListNotifier extends StateNotifier<List<PlayerData>> {
  PlayerListNotifier(List<PlayerData> initialPlayers)
      : super(initialPlayers); 

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

  void updateMatchName(int index, String matchName) {
    final updated = [...state];
    updated[index].matchName = matchName;
    state = updated;
  }

  void updateTeams(int index, String teamOne, String teamTwo) {
    final updated = [...state];
    updated[index].teamOne = teamOne;
    updated[index].teamTwo = teamTwo;
    state = updated;
  }

  void updateTeamScores(int index, String teamOneScore, String teamTwoScore) {
    final updated = [...state];
    updated[index].teamOneScore = teamOneScore;
    updated[index].teamTwoScore = teamTwoScore;
    state = updated;
  }

  void updateDate(int index, String date) {
    final updated = [...state];
    updated[index].date = date;
    state = updated;
  }
}
