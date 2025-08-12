// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nololordos/core/constant/padding.dart';
import 'package:nololordos/core/routes/route_name.dart';
import 'package:nololordos/core/theme/theme_extension/app_colors.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/Riverpod/playerProvider.dart';
import 'package:nololordos/features/import_export_screen/presentation/widgets/custom_buttons.dart';
import 'package:nololordos/features/match_day_screen/Riverpod/matchData_stateModel.dart';
import 'package:nololordos/features/match_day_screen/Riverpod/matchProvider.dart';
import 'package:nololordos/features/match_day_screen/Riverpod/player_notifier.dart';
import 'package:nololordos/features/match_day_screen/Riverpod/srProvider.dart';
import 'package:nololordos/features/match_day_screen/presentation/widgets/alert_dialogue_box.dart';
import 'package:nololordos/features/match_day_screen/presentation/widgets/custom_inputfields.dart';
import 'package:nololordos/features/match_day_screen/presentation/widgets/custom_score_inputBox.dart';

class MatchdayScreen extends ConsumerStatefulWidget {
  const MatchdayScreen({super.key});

  @override
  ConsumerState<MatchdayScreen> createState() => _MatchdayScreenState();
}

class _MatchdayScreenState extends ConsumerState<MatchdayScreen> {
  late TextEditingController matchNameController;
  late TextEditingController teamOneController;
  late TextEditingController teamTwoController;
  late TextEditingController teamOneScoreController;
  late TextEditingController teamTwoScoreController;

  @override
  void initState() {
    super.initState();
    matchNameController = TextEditingController();
    teamOneController = TextEditingController();
    teamTwoController = TextEditingController();
    teamOneScoreController = TextEditingController();
    teamTwoScoreController = TextEditingController();
  }

  @override
  void dispose() {
    matchNameController.dispose();
    teamOneController.dispose();
    teamTwoController.dispose();
    teamOneScoreController.dispose();
    teamTwoScoreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final players = ref.watch(playersProvider);

    //eihane filter kora lagboo
    final notifier = ref.read(playersProvider.notifier);

    return Scaffold(
      body: Padding(
        padding: AppPadding.screenHorizontal,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 55.h),
              CustomInputfields(
                matchName: matchNameController,
                teamOne: teamOneController,
                teamTwo: teamTwoController,
                scoreOne: teamOneScoreController,
                scoreTwo: teamTwoScoreController,
              
              ),
              SizedBox(height: 24.h),

              Column(
                children: List.generate(players.length, (index) {
                  final p = players[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: CustomScoreInputbox(
                      name: p.name,
                      goals: p.goals,
                      ownGoals: p.ownGoals,
                      selectedScore: p.selectedScore,
                      onNameChanged: (value) =>
                          notifier.updatePlayer(players[index].id, "NAME", value),
                      onIncrementGoals: () => notifier.incrementGoals(players[index].id),
                      onIncrementOwnGoals: () =>
                          notifier.incrementOwnGoals(players[index].id),
                    onScoreSelected: (score) {
  notifier.selectScore(players[index].id, score);

  toggleScore(ref, players[index].id, score);

  debugPrint(ref.watch(srProvider).toString());

final totals = getTotalScores(ref);
debugPrint(totals.toString());



 final scoresMap = ref.read(srProvider);

  final selectedPlayerIds = scoresMap.keys.toList();

   if (selectedPlayerIds.isNotEmpty) {
    final totalScore = selectedPlayerIds.fold<double>(0, (sum, playerId) {
      final scores = scoresMap[playerId] ?? [];
      return sum + scores.fold<double>(0, (pSum, s) => pSum + s);
    });

    final average = totalScore / selectedPlayerIds.length;
    ref.read(totalAverageSumProvider.notifier).state += average;

    ref.read(averageScoreProvider.notifier).state = average;

    debugPrint("Average score saved: $average");
  } else {
    ref.read(averageScoreProvider.notifier).state = 0.0;
    debugPrint("No players selected yet. Average reset to 0");
  }

},

                    ),
                  );
                }),
              ),

              CustomButtons(
                hieght: 60.h,
                title: '+ Add the list',
                icon: '',
                onTap:(){
                  context.push(RouteName.addPlayerScreen);
                }
                
                // () => 
                
                //notifier.addPlayer(),
              ),
              SizedBox(height: 20.h),

              CustomButtons(
                hieght: 60.h,
                color: AppColors.buttonAvtiveColor,
                title: 'Submit',
                icon: '',
                onTap: () {


                  ref.watch(matchCountProvider.notifier).state++;
                  final players = ref.read(
                    playerListProvider,
                  ); // get player data
                  final matchName = matchNameController.text;
                  final teamOne = teamOneController.text;
                  final teamTwo = teamTwoController.text;
                  final teamOneScore = teamOneScoreController.text;
                  final teamTwoScore = teamTwoScoreController.text;
                  final date = DateTime.now().toString().split(' ')[0];

                  final match = MatchData(
                    matchName: matchName,
                    teamOne: teamOne,
                    teamTwo: teamTwo,
                    teamOneScore: teamOneScore,
                    teamTwoScore: teamTwoScore,
                    date: date,
                    players: List.from(players),
                  );

                  ref.read(matchHistoryProvider.notifier).addMatch(match);
                  debugPrint("✅ Match Added: $matchName - $teamOne vs $teamTwo");
                  alertDialogueBox(context);
                },
              ),
              SizedBox(height: 140.h),
            ],
          ),
        ),
      ),
    );
  }
  void toggleScore(WidgetRef ref, String playerId, int score) {
  final current = ref.read(srProvider);
  final scores = current[playerId] ?? [];

  ref.read(srProvider.notifier).state = {
    ...current,
    playerId: scores.contains(score)
        ? scores.where((s) => s != score).toList() // remove score
        : [...scores, score], // add score
  };
}

// Function to get total scores for each player
Map<String, int> getTotalScores(WidgetRef ref) {
  final scoresMap = ref.read(srProvider);

  return scoresMap.map((playerId, scores) {
    final total = scores.fold(0, (sum, score) => sum + score);
    return MapEntry(playerId, total);
  });
}
}
