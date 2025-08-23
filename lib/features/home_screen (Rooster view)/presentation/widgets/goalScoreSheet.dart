// ignore_for_file: unnecessary_null_comparison, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nololordos/core/theme/theme_extension/app_colors.dart';
import 'package:nololordos/features/Team_Selection_screen/Riverpod/selection_provider.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/Riverpod/editProvider.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/Riverpod/isDeleteProvider.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/Riverpod/playerProvider.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/presentation/widgets/customBox_tile.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/presentation/widgets/title.dart';
import 'package:nololordos/features/match_day_screen/Riverpod/srProvider.dart';
import 'package:nololordos/features/match_day_screen/presentation/widgets/inputdecoration.dart';

import '../../Riverpod/delete_provider_selection.dart';
import '../../Riverpod/real_sr_provider.dart';

class GoalScoreSheet extends ConsumerStatefulWidget {
  const GoalScoreSheet({super.key});

  @override
  _GoalScoreSheetState createState() => _GoalScoreSheetState();
}

class _GoalScoreSheetState extends ConsumerState<GoalScoreSheet> {
  // Declare a map to store controllers for each player
  late Map<String, TextEditingController> controllers;

  @override
  void initState() {
    super.initState();
    // Initialize the controller map
    controllers = {};
  }

  @override
  void dispose() {
    // Dispose all controllers to avoid memory leaks
    controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    final allPlayers = ref.watch(playersProvider);
    final selectedTeam = ref.watch(selectionProvider);
    final isDeleteOn = ref.watch(isDeleteProvider);
    final isEditon = ref.watch(isEditOnProvider);

    debugPrint(isEditon.toString());
    // Filter goalkeepers by team
    final players = allPlayers
        .where(
          (p) =>
              (p.position == "GK" || p.position == "Goalkeeper (GK)") &&
              selectedTeam != null &&
              p.team == selectedTeam,
        )
        .toList();

    return Container(
      padding: EdgeInsets.only(left: 24.w, bottom: 20.h),
      decoration: BoxDecoration(color: AppColors.primaryContainer),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              SizedBox(height: isDeleteOn ? 7.h : 11.h),
              Row(
                children: [
                  if (isDeleteOn) ...[
                    Transform.scale(
                      scale: 1.1,
                      child: Checkbox(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.all(
                          ref.watch(
                                allPlayersTeamPositionSelectionProvider({
                                  'team': selectedTeam,
                                  'position': 'GK',
                                }),
                              )
                              ? AppColors.redColor
                              : Colors.transparent,
                        ),
                        value: ref.watch(
                          allPlayersTeamPositionSelectionProvider({
                            'team': selectedTeam,
                            'position': 'GK',
                          }),
                        ),
                        onChanged: (_) {
                          toggleSelectAllPlayers(ref, selectedTeam, 'GK');
                          debugPrint(
                            "Delete player IDs: ${ref.read(deletePlayerIdListProvider)}",
                          );
                        },
                      ),
                    ),
                  ],
                  Text("GK", style: style.bodyLarge),
                ],
              ),
              SizedBox(height: isDeleteOn ? 0.0.h : 15.h),
              Container(
                width: isDeleteOn ? 190.w : 144.w,
                height: 1.h,
                color: Colors.white,
              ),
              SizedBox(height: isDeleteOn ? 5.h : 4.h),

              ...players.map((player) {
                final id = player.id;
                final isSelected = ref
                    .watch(deletePlayerIdListProvider)
                    .contains(id);

                debugPrint('$id selected: $isSelected');

                if (!controllers.containsKey(id)) {
                  controllers[id] = TextEditingController(text: player.name);
                }

                return Column(
                  children: [
                    Row(
                      children: [
                        if (isDeleteOn) ...[
                          Transform.scale(
                            scale: 1.1,
                            child: Checkbox(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              checkColor: Colors.white,
                              fillColor: MaterialStateProperty.all(
                                isSelected
                                    ? AppColors.redColor
                                    : Colors.transparent,
                              ),
                              value: isSelected,
                              onChanged: (bool? value) {
                                if (value == true) {
                                  addPlayerId(ref, id);
                                } else {
                                  removePlayerId(ref, id);
                                }
                                debugPrint(
                                  "Delete player IDs: ${ref.read(deletePlayerIdListProvider)}",
                                );
                              },
                            ),
                          ),
                        ],
                        SizedBox(
                          height: 50.h,
                          width: 150.w,
                          child: TextFormField(
                            controller:
                                controllers[id], // Use the player-specific controller
                            onChanged: (value) {
                              // Update the player's name when it changes
                              ref
                                  .read(playersProvider.notifier)
                                  .updatePlayerName(player.id, value);
                            },
                            style: Theme.of(context).textTheme.labelLarge!
                                .copyWith(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                            readOnly:
                                isEditon, // Make it readonly if editing is off
                            decoration: customInputDecoration(),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
            ],
          ),

          // ---------------- Stats Columns ------------------
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  SizedBox(height: isDeleteOn ? 1.h : null),
                  Row(
                    children: [
                      Titles(title: "SR"),
                      Titles(title: "GM"),
                      Titles(title: "GL"),
                      Titles(title: "AGL"),
                      Titles(title: "-GL"),
                      Titles(title: "-AGL"),
                    ],
                  ),
                  Column(
                    children: List.generate(players.length, (index) {
                      final player = players[index];
                      final gmCount = ref.watch(matchCountProvider);
                      final allScoresMap = ref.watch(srProvider);
                      final playerScores = allScoresMap[player.id] ?? [];

                      // Fetch the SR value for the current player
                      final sr = ref.watch(realSrProvider)[player.id] ?? 0.0;  // Default to 0 if no SR value is set

                      final totalScore = playerScores.fold(
                        0,
                            (sum, s) => sum + s,
                      );
                      final averageScore = gmCount > 0
                          ? totalScore / gmCount
                          : 0;

                      return Row(
                        children: [
                          CustomboxTile(
                            readOnlyValue: isEditon,
                            value: sr.toStringAsFixed(2), // Display the SR value
                            onChanged: (value) {
                              ref
                                  .read(playersProvider.notifier)
                                  .updatePlayer(player.id, "sr", value);
                            },
                          ),
                          CustomboxTile(
                            readOnlyValue: isEditon,
                            value: gmCount.toString(),
                            onChanged: (value) {
                              ref
                                  .read(playersProvider.notifier)
                                  .updatePlayer(player.id, "GM", value);
                            },
                          ),
                          CustomboxTile(
                            readOnlyValue: isEditon,
                            value: player.goals.toString(),
                            onChanged: (value) {
                              ref
                                  .read(playersProvider.notifier)
                                  .updatePlayer(player.id, "GOALS", value);
                            },
                          ),
                          CustomboxTile(
                            readOnlyValue: isEditon,
                            value: (player.goals / (gmCount == 0 ? 1 : gmCount))
                                .toStringAsFixed(2),
                            onChanged: (value) {
                              ref
                                  .read(playersProvider.notifier)
                                  .updatePlayer(player.id, "AGL", value);
                            },
                          ),
                          CustomboxTile(
                            readOnlyValue: isEditon,
                            value: player.ownGoals.toString(),
                            onChanged: (value) {
                              ref
                                  .read(playersProvider.notifier)
                                  .updatePlayer(player.id, "-GL", value);
                            },
                          ),
                          CustomboxTile(
                            readOnlyValue: isEditon,
                            value:
                            (player.ownGoals / (gmCount == 0 ? 1 : gmCount)).toStringAsFixed(2),
                            onChanged: (value) {
                              ref
                                  .read(playersProvider.notifier)
                                  .updatePlayer(player.id, "-AGL", value);
                            },
                          ),
                        ],
                      );
                    }),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class GoalScoreSheet extends ConsumerStatefulWidget {
//   const GoalScoreSheet({super.key});

//   @override
//   _GoalScoreSheetState createState() => _GoalScoreSheetState();
// }

// class _GoalScoreSheetState extends ConsumerState<GoalScoreSheet> {
//   late TextEditingController gkName;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize the controller
//     gkName = TextEditingController();
//   }

//   @override
//   void dispose() {
//     // Dispose the controller to avoid memory leaks
//     gkName.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final style = Theme.of(context).textTheme;
//     final allPlayers = ref.watch(playersProvider);
//     final selectedTeam = ref.watch(selectionProvider);
//     final isDeleteOn = ref.watch(isDeleteProvider);
//  final isEditon = ref.watch(isEditOnProvider);

//  debugPrint(isEditon.toString());
//     // Filter goalkeepers by team
//     final players = allPlayers
//         .where(
//           (p) =>
//               (p.position == "GK" || p.position == "Goalkeeper (GK)") &&
//               selectedTeam != null &&
//               p.team == selectedTeam,
//         )
//         .toList();

//     return Container(
//       padding: EdgeInsets.only(left: 24.w, bottom: 20.h),
//       decoration: BoxDecoration(color: AppColors.primaryContainer),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Column(
//             children: [
//               SizedBox(height:isDeleteOn? 7.h: 11.h),
//               Row(
//                 children: [
//                   if (isDeleteOn) ...[
//                     Transform.scale(
//                       scale: 1.1,
//                       child: Checkbox(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(100),
//                         ),
//                         checkColor: Colors.white,
//                         fillColor: MaterialStateProperty.all(
//                           ref.watch(
//                                 allPlayersTeamPositionSelectionProvider({
//                                   'team': selectedTeam,
//                                   'position': 'GK',
//                                 }),
//                               )
//                               ? AppColors.redColor
//                               : Colors.transparent,
//                         ),
//                         value: ref.watch(
//                           allPlayersTeamPositionSelectionProvider({
//                             'team': selectedTeam,
//                             'position': 'GK',
//                           }),
//                         ),
//                         onChanged: (_) {
//                           toggleSelectAllPlayers(ref, selectedTeam, 'GK');
//                           debugPrint(
//                             "Delete player IDs: ${ref.read(deletePlayerIdListProvider)}",
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                   Text("GK", style: style.bodyLarge),
//                 ],
//               ),
//               SizedBox(height: isDeleteOn ? 0.0.h : 15.h),
//               Container(
//                 width: isDeleteOn ? 190.w : 144.w,
//                 height: 1.h,
//                 color: Colors.white,
//               ),
//               SizedBox(height: isDeleteOn ? 5.h : 4.h),

//               // Render individual goalkeepers
//               ...players.map((player) {
//                 final id = player.id;
//                 final isSelected = ref
//                     .watch(deletePlayerIdListProvider)
//                     .contains(id);

//                 debugPrint('$id selected: $isSelected');
//                                 gkName.text = player.name;

//                 return Column(
//                   children: [
//                     Row(
//                       children: [
//                         if (isDeleteOn) ...[
//                           Transform.scale(
//                             scale: 1.1,
//                             child: Checkbox(
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(100),
//                               ),
//                               checkColor: Colors.white,
//                               fillColor: MaterialStateProperty.all(
//                                 isSelected
//                                     ? AppColors.redColor
//                                     : Colors.transparent,
//                               ),
//                               value: isSelected,
//                               onChanged: (bool? value) {
//                                 if (value == true) {
//                                   addPlayerId(ref, id);
//                                 } else {
//                                   removePlayerId(ref, id);
//                                 }
//                                 debugPrint(
//                                   "Delete player IDs: ${ref.read(deletePlayerIdListProvider)}",
//                                 );
//                               },
//                             ),
//                           ),
//                         ],
//                         SizedBox(
//                           height: 50.h,
//                           width: 150.w,
//                           child: TextFormField(

//                             controller: gkName,
//                              onChanged: (value) {
// debugPrint(gkName.toString());
//                               ref.read(playersProvider.notifier).updatePlayerName(player.id, value);
//                             },
//                             style: Theme.of(context).textTheme.labelLarge!
//                                 .copyWith(
//                                   fontSize: 13.sp,
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                             readOnly:   isEditon,
//                          //  initialValue:player.name ,
//                             decoration: customInputDecoration(),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 );
//               }),
//             ],
//           ),

//           // ---------------- Stats Columns ------------------
//           Expanded(
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Column(
//                 children: [
//                   SizedBox(height: isDeleteOn? 1.h: null,),
//                   Row(
//                     children: [
//                       Titles(title: "SR"),
//                       Titles(title: "GM"),
//                       Titles(title: "GL"),
//                       Titles(title: "AGL"),
//                       Titles(title: "-GL"),
//                       Titles(title: "-AGL"),
//                     ],
//                   ),
//                   Column(
//                     children: List.generate(players.length, (index) {
//                     final player = players[index];
//                     final gmCount = ref.watch(matchCountProvider);
//                     final allScoresMap = ref.watch(
//                         srProvider,
//                       ); // Map<String, List<int>>
//                       final playerScores = allScoresMap[player.id] ?? [];
//                       final totalScore = playerScores.fold(
//                         0,
//                         (sum, s) => sum + s,
//                       );
//                       final averageScore = gmCount > 0
//                           ? totalScore / gmCount
//                           : 0;

//                       /// ref.read(totalAverageSumProvider.notifier).state += averageScore;

//                       return Row(
//                         children: [
//                           CustomboxTile(
//                             readOnlyValue: isEditon,
//                             // value: player.sr.toStringAsFixed(2),
//                             value: averageScore.toStringAsFixed(2),
//                             onChanged: (value) {
//                               ref
//                                   .read(playersProvider.notifier)
//                                   .updatePlayer(player.id, "sr", value);
//                             },
//                           ),

//                           CustomboxTile(
//                             readOnlyValue: isEditon,
//                             value: gmCount.toString(),
//                             onChanged: (value) {
//                               ref
//                                   .read(playersProvider.notifier)
//                                   .updatePlayer(player.id, "GM", value);
//                             },
//                           ),
//                           CustomboxTile(
//                             readOnlyValue: isEditon,
//                             value: player.goals.toString(),

//                             onChanged: (value) {
//                               ref
//                                   .read(playersProvider.notifier)
//                                   .updatePlayer(player.id, "GOALS", value);
//                             },
//                           ),
//                           CustomboxTile(
//                             readOnlyValue: isEditon,
//                             value: (player.goals / (gmCount == 0 ? 1 : gmCount))
//                                 .toStringAsFixed(2), // Calculate AGL here
//                             onChanged: (value) {
//                               ref
//                                   .read(playersProvider.notifier)
//                                   .updatePlayer(player.id, "AGL", value);
//                             },
//                           ),
//                           CustomboxTile(
//                             readOnlyValue: isEditon,
//                             value: player.ownGoals.toString(),
//                             onChanged: (value) {
//                               ref
//                                   .read(playersProvider.notifier)
//                                   .updatePlayer(player.id, "-GL", value);
//                             },
//                           ),
//                           CustomboxTile(
//                             readOnlyValue: isEditon,
//                             value:
//                                 (player.ownGoals / (gmCount == 0 ? 1 : gmCount))
//                                     .toStringAsFixed(2),
//                             onChanged: (value) {
//                               ref
//                                   .read(playersProvider.notifier)
//                                   .updatePlayer(player.id, "-AGL", value);
//                             },
//                           ),
//                         ],
//                       );
//                     }),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
