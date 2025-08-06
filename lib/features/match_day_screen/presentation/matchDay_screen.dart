// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nololordos/core/constant/padding.dart';
import 'package:nololordos/core/theme/theme_extension/app_colors.dart';
import 'package:nololordos/features/import_export_screen/presentation/widgets/custom_buttons.dart';
import 'package:nololordos/features/match_day_screen/Riverpod/matchData_stateModel.dart';
import 'package:nololordos/features/match_day_screen/Riverpod/matchProvider.dart';
import 'package:nololordos/features/match_day_screen/Riverpod/player_notifier.dart';
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
    final players = ref.watch(playerListProvider);
    final notifier = ref.read(playerListProvider.notifier);

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
                          notifier.updateName(index, value),
                      onIncrementGoals: () => notifier.incrementGoals(index as double),
                      onIncrementOwnGoals: () =>
                          notifier.incrementOwnGoals(index),
                      onScoreSelected: (score) =>
                          notifier.selectScore(index, score),
                    ),
                  );
                }),
              ),

              CustomButtons(
                hieght: 60.h,
                title: '+ Add the list',
                icon: '',
                onTap: () => notifier.addPlayer(),
              ),
              SizedBox(height: 20.h),

              CustomButtons(
                hieght: 60.h,
                color: AppColors.buttonAvtiveColor,
                title: 'Submit',
                icon: '',
                onTap: () {
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
}
