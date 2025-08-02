import 'package:nololordos/features/match_day_screen/Riverpod/player_state_model.dart';

class MatchData {
  String matchName;
  String teamOne;
  String teamTwo;
  String teamOneScore;
  String teamTwoScore;
  String date;
  List<PlayerData> players; 

  MatchData({
    required this.matchName,
    required this.teamOne,
    required this.teamTwo,
    required this.teamOneScore,
    required this.teamTwoScore,
    required this.date,
    required this.players,
  });
}