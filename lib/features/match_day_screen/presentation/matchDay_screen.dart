import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nololordos/core/constant/padding.dart';
import 'package:nololordos/core/theme/theme_extension/app_colors.dart';
import 'package:nololordos/features/Team_Selection_screen/Riverpod/selection_provider.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/Riverpod/playerProvider.dart';
import 'package:nololordos/features/import_export_screen/presentation/widgets/custom_buttons.dart';
import 'package:nololordos/features/match_day_screen/Riverpod/matchData_stateModel.dart';
import 'package:nololordos/features/match_day_screen/Riverpod/matchProvider.dart';
import 'package:nololordos/features/match_day_screen/Riverpod/player_notifier.dart';
import 'package:nololordos/features/match_day_screen/Riverpod/srProvider.dart';
import 'package:nololordos/features/match_day_screen/presentation/widgets/alert_dialogue_box.dart';
import 'package:nololordos/features/match_day_screen/presentation/widgets/custom_inputfields.dart';
import 'package:nololordos/features/match_day_screen/presentation/widgets/custom_score_inputBox.dart';

import '../../home_screen (Rooster view)/Riverpod/real_sr_provider.dart';

// Provider to store the total score and match count per player
final playerTotalStatsProvider = StateProvider<Map<String, PlayerStats>>(
  (ref) => {},
);

class PlayerStats {
  double totalScore;
  int matchCount;

  PlayerStats({this.totalScore = 0.0, this.matchCount = 0});

  // Calculate the average rating per player
  double get averageRating => matchCount > 0 ? totalScore / matchCount : 0.0;
}

final strProvider = StateProvider<List<double>>((ref) => []);

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
    final selectedTeam = ref.watch(selectionProvider);

    final notifier = ref.read(playersProvider.notifier);
    final filteredPlayers = players.where((p) {
      return selectedTeam != null && p.team == selectedTeam;
    }).toList();

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
                children: List.generate(filteredPlayers.length, (index) {
                  final p = filteredPlayers[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: CustomScoreInputbox(
                      name: p.name,
                      goals: p.goals,
                      ownGoals: p.ownGoals,
                      selectedScore: p.selectedScore,
                      onNameChanged: (value) => notifier.updatePlayer(
                        filteredPlayers[index].id,
                        "NAME",
                        value,
                      ),
                      onIncrementGoals: () =>
                          notifier.incrementGoals(filteredPlayers[index].id),
                      onIncrementOwnGoals: () =>
                          notifier.incrementOwnGoals(filteredPlayers[index].id),
                      onScoreSelected: (score) {
                        handleScoreSelection(
                          ref,
                          filteredPlayers[index].id,
                          score,
                          notifier,
                        );
                      },
                    ),
                  );
                }),
              ),

              SizedBox(height: 20.h),

              CustomButtons(
                hieght: 60.h,
                color: AppColors.buttonAvtiveColor,
                title: 'Submit',
                icon: '',
                onTap: () {
                  handleSubmit(ref);
                },
              ),
              SizedBox(height: 140.h),
            ],
          ),
        ),
      ),
    );
  }

  /// Handle score selection logic
  void handleScoreSelection(
    WidgetRef ref,
    String playerId,
    int score,
    dynamic notifier,
  ) {
    final currentScoresMap = ref.read(srProvider);
    final currentPlayerScores = List<int>.from(
      currentScoresMap[playerId] ?? [],
    );
    final currentSelectedScore = ref
        .read(playersProvider)
        .firstWhere((p) => p.id == playerId)
        .selectedScore;

    if (score == currentSelectedScore && currentPlayerScores.isNotEmpty) {
      currentPlayerScores.removeLast();
      debugPrint(
        "Removed last element from player $playerId. List: $currentPlayerScores",
      );

      // Reset selectedScore to 0 explicitly (no highlighted score)
      notifier.selectScore(playerId, 0);
    } else {
      currentPlayerScores.add(score);
      debugPrint(
        "Added score $score to player $playerId. List: $currentPlayerScores",
      );

      notifier.selectScore(playerId, score);
    }

    // Update the scores map in provider
    ref.read(srProvider.notifier).state = {
      ...currentScoresMap,
      playerId: currentPlayerScores,
    };

    updateCurrentMatchTR(ref);

    debugPrint("Player $playerId final list: $currentPlayerScores");
    debugPrint(
      "Player $playerId selectedScore: ${ref.read(playersProvider).firstWhere((p) => p.id == playerId).selectedScore}",
    );
  }

  /// Calculate and update current match TR (Team Rating)
  void updateCurrentMatchTR(WidgetRef ref) {
    final scoresMap = ref.read(srProvider);
    final selectedPlayerIds = scoresMap.keys.where((playerId) {
      final scores = scoresMap[playerId] ?? [];
      return scores.isNotEmpty;
    }).toList();

    if (selectedPlayerIds.isNotEmpty) {
      final totalScore = selectedPlayerIds.fold<double>(0, (sum, playerId) {
        final scores = scoresMap[playerId] ?? [];
        return sum + scores.fold<double>(0, (pSum, s) => pSum + s);
      });

      final currentTR = totalScore / selectedPlayerIds.length;
      ref.read(averageScoreProvider.notifier).state = currentTR;

      debugPrint("Current match TR: $currentTR");
    } else {
      ref.read(averageScoreProvider.notifier).state = 0.0;
      debugPrint("No players with scores. TR reset to 0");
    }
  }

  /// On submit: Save match and update STR
  void handleSubmit(WidgetRef ref) {
    // Calculate final TR for this match
    final currentTR = ref.read(averageScoreProvider);

    if (currentTR <= 0) {
      // Show error if no valid TR
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select scores for players before submitting"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Add current TR to STR list
    final currentSTR = ref.read(strProvider);
    ref.read(strProvider.notifier).state = [...currentSTR, currentTR];
    ref.read(averageScoreProvider.notifier).state = currentTR;

    // Update match count
    ref.read(matchCountProvider.notifier).state++;

    // Prepare match data
    final players = ref.read(playerListProvider);
    final matchName = matchNameController.text;
    final teamOne = teamOneController.text;
    final teamTwo = teamTwoController.text;
    final teamOneScore = teamOneScoreController.text;
    final teamTwoScore = teamTwoScoreController.text;
    final date = DateTime.now().toString().split(' ')[0];

    // Update cumulative statistics
    ref.read(totalAverageSumProvider.notifier).state += currentTR;
    ref.read(totalTRSumProvider.notifier).state += currentTR;
    ref.read(totalTRCountProvider.notifier).state++;

    // Update final TR average for display in RoosterView
    final updatedSTR = ref.read(strProvider);
    final overallAverage = updatedSTR.isNotEmpty
        ? updatedSTR.reduce((a, b) => a + b) / updatedSTR.length
        : 0.0;
    ref.read(finalTRAverageProvider.notifier).state = overallAverage;

    // Create and save match
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
    debugPrint(
      "Match Added: $matchName - $teamOne vs $teamTwo, TR: $currentTR",
    );

    // Update player stats (total score and match count)
    final currentScoresMap = ref.read(srProvider);
    final playerStats = ref.read(playerTotalStatsProvider.notifier);

    currentScoresMap.forEach((playerId, scores) {
      final totalScore = scores.fold<double>(0, (sum, score) => sum + score);
      final numGames = scores.length;

      // Update player stats
      if (playerStats.state.containsKey(playerId)) {
        playerStats.state[playerId]!.totalScore += totalScore;
        playerStats.state[playerId]!.matchCount += numGames;
      } else {
        playerStats.state[playerId] = PlayerStats(
          totalScore: totalScore,
          matchCount: numGames,
        );
      }

      // Calculate SR for the player
      final sr = playerStats.state[playerId]!.totalScore / playerStats.state[playerId]!.matchCount;

      // Update the SR value for the current player in realSrProvider
      ref.read(realSrProvider.notifier).state = {
        ...ref.read(realSrProvider), // Retain existing SR values for other players
        playerId: sr, // Update SR for the current player
      };

      // Debug output for each player's total score and total match count
      debugPrint(
          "Player $playerId - Total Score: ${playerStats.state[playerId]!.totalScore}, Matches Played: ${playerStats.state[playerId]!.matchCount}, SR: $sr"
      );
    });


    // **RESET SELECTIONS AFTER SUBMISSION**

    // Clear current match selections (e.g., reset scores, selected players, etc.)
    ref.read(srProvider.notifier).state = {}; // Clear player scores
    ref.read(averageScoreProvider.notifier).state = 0.0; // Reset average score
    final notifier = ref.read(playersProvider.notifier);
    final allPlayers = ref.read(playersProvider);
    for (final player in allPlayers) {
      notifier.selectScore(
        player.id,
        0,
      ); // Reset selected score for all players
    }

    // Show alert dialog with STR data using your existing dialog
    alertDialogueBox(context);
  }

  /// Utility: Get total scores per player
  Map<String, int> getTotalScores(WidgetRef ref) {
    final scoresMap = ref.read(srProvider);
    return scoresMap.map((playerId, scores) {
      final total = scores.fold(0, (sum, score) => sum + score);
      return MapEntry(playerId, total);
    });
  }
}
