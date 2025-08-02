import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nololordos/features/match_day_screen/Riverpod/matchData_stateModel.dart';

final matchHistoryProvider = StateNotifierProvider<MatchHistoryNotifier,List<MatchData>>((ref){
  return MatchHistoryNotifier();
});

class MatchHistoryNotifier extends StateNotifier<List<MatchData>>{
    
    MatchHistoryNotifier():super([]);
    void addMatch(MatchData match){
      state = [...state,match];
    }
    void clearHistory(){
      state = [];
    }
}