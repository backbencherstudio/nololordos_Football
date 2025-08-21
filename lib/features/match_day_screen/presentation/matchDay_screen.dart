import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nololordos/core/constant/padding.dart';
import 'package:nololordos/core/routes/route_name.dart';
import 'package:nololordos/core/theme/theme_extension/app_colors.dart';
import 'package:nololordos/features/Team_Selection_screen/Riverpod/selection_provider.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/Riverpod/playerProvider.dart';
import 'package:nololordos/features/import_export_screen/presentation/widgets/custom_buttons.dart';
import 'package:nololordos/features/match_day_screen/Riverpod/matchData_stateModel.dart';
import 'package:nololordos/features/match_day_screen/Riverpod/matchProvider.dart';
import 'package:nololordos/features/match_day_screen/Riverpod/player_notifier.dart';
import 'package:nololordos/features/match_day_screen/Riverpod/selection_score_provider.dart';
import 'package:nololordos/features/match_day_screen/presentation/widgets/alert_dialogue_box.dart';
import 'package:nololordos/features/match_day_screen/presentation/widgets/custom_inputfields.dart';
import 'package:nololordos/features/match_day_screen/presentation/widgets/custom_score_inputBox.dart';
import '../Riverpod/srProvider.dart';

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

  final _formKey = GlobalKey<FormState>(); // Form key for validation

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

  void _clearAllFields() {
    matchNameController.clear();
    teamOneController.clear();
    teamTwoController.clear();
    teamOneScoreController.clear();
    teamTwoScoreController.clear();
    // Reset the date in provider
    ref.read(selectedMatchDateProvider.notifier).state = null;
  }


  @override
  Widget build(BuildContext context) {
    final players = ref.watch(playersProvider);
    final selectedTeam = ref.watch(selectionProvider);
    final notifier = ref.read(playersProvider.notifier);

    final filteredPlayers = players.where((p) {
      return p.team == selectedTeam;
    }).toList();

    final selectedScoresUI = ref.watch(selectedScoreProvider);

    return Scaffold(
      body: Padding(
        padding: AppPadding.screenHorizontal,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey, // Attach the form key here
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

                // Player selection and score input fields
                Column(
                  children: List.generate(filteredPlayers.length, (index) {
                    final p = filteredPlayers[index];
                    final selectedForThisPlayer =
                    selectedScoresUI[p.id]; // int? or null

                    return Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: CustomScoreInputbox(
                        name: p.name,
                        goals: p.goals,
                        ownGoals: p.ownGoals,
                        selectedScore: selectedForThisPlayer,
                        onNameChanged: (value) =>
                            notifier.updatePlayer(p.id, "NAME", value),
                        onIncrementGoals: () => notifier.incrementGoals(p.id),
                        onIncrementOwnGoals: () =>
                            notifier.incrementOwnGoals(p.id),
                        onScoreSelected: (score) {
                          ref
                              .read(selectedScoreProvider.notifier)
                              .toggle(p.id, score);

                          final map = ref.read(srProvider);
                          final list = List<int>.from(map[p.id] ?? const <int>[]);

                          final lastAddedMap = ref.read(lastAddedProvider);
                          final lastAdded = lastAddedMap[p.id];

                          debugPrint(
                            "👉 Tap on player: ${p.id}, score tapped: $score",
                          );
                          debugPrint("   Current list before: $list");
                          debugPrint("   Last added was: $lastAdded");

                          if (lastAdded == score &&
                              list.isNotEmpty &&
                              list.last == score) {
                            // undo ONLY the most recent addition
                            list.removeLast();
                            ref.read(lastAddedProvider.notifier).state = {
                              ...lastAddedMap,
                              p.id: null,
                            };

                            debugPrint("❌ Undo last score ($score) for ${p.id}");
                          } else {
                            // new add
                            list.add(score);
                            ref.read(lastAddedProvider.notifier).state = {
                              ...lastAddedMap,
                              p.id: score,
                            };

                            debugPrint("✅ Added score ($score) for ${p.id}");
                          }

                          // write back updated list
                          ref.read(srProvider.notifier).state = {
                            ...map,
                            p.id: list,
                          };

                          debugPrint("   Updated list after: $list");

                          // recompute averages
                          final scoresMap = ref.read(srProvider);
                          final selectedPlayerIds = scoresMap.keys.toList();

                          if (selectedPlayerIds.isNotEmpty) {
                            final totalScore = selectedPlayerIds.fold<double>(0, (
                                sum,
                                playerId,
                                ) {
                              final scores = scoresMap[playerId] ?? [];
                              return sum +
                                  scores.fold<double>(0, (pSum, s) => pSum + s);
                            });

                            final average = totalScore / selectedPlayerIds.length;

                            ref.read(totalAverageSumProvider.notifier).state +=
                                average;
                            ref.read(totalTRSumProvider.notifier).state +=
                                average;
                            ref.read(totalTRCountProvider.notifier).state++;
                            ref.read(averageScoreProvider.notifier).state =
                                average;

                            debugPrint("📊 Average for this tap: $average");
                            debugPrint(
                              "📊 Overall average now: ${ref.read(finalAverageProvider)}",
                            );
                          } else {
                            ref.read(averageScoreProvider.notifier).state = 0.0;
                            debugPrint(
                              "⚠️ No players selected → average reset to 0",
                            );
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
                  onTap: () {
                    context.push(RouteName.addPlayerScreen);
                  },
                ),
                SizedBox(height: 20.h),

                // Submit button with validation
                CustomButtons(
                  hieght: 60.h,
                  color: AppColors.buttonAvtiveColor,
                  title: 'Submit',
                  icon: '',
                  onTap: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      ref.watch(matchCountProvider.notifier).state++;

                      final players = ref.read(playerListProvider);
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

                      // Add match to matchHistoryProvider
                      ref.read(matchHistoryProvider.notifier).addMatch(match);

                      // Clear transient UI highlights
                      ref.read(selectedScoreProvider.notifier).clearAll();

                      // Optionally clear srProvider
                      ref.read(srProvider.notifier).state = {};

                      debugPrint(
                        "✅ Match Added: $matchName - $teamOne vs $teamTwo",
                      );
                      alertDialogueBox(context);
                      _clearAllFields();
                    }
                  },
                ),

                SizedBox(height: 140.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
