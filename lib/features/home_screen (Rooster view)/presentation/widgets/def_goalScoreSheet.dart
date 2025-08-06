// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nololordos/core/theme/theme_extension/app_colors.dart';
import 'package:nololordos/features/Team_Selection_screen/Riverpod/selection_provider.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/Riverpod/checkboxProvider.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/Riverpod/isDeleteProvider.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/Riverpod/playerProvider.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/presentation/widgets/customBox_tile.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/presentation/widgets/title.dart';
import 'package:nololordos/features/match_day_screen/presentation/widgets/inputdecoration.dart';

class DefGoalscoresheet extends StatelessWidget {
  const DefGoalscoresheet({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.only(left: 24.w, bottom: 20.h),
      decoration: BoxDecoration(color: AppColors.primaryContainer),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [




//================================================================================================================================================

//eikhane select er logic gula seeeeee eikhane delete er logic gula deya lagbe
   Consumer(
  builder: (context, ref, _) {
    final allPlayers = ref.watch(playersProvider);
    final selectedTeam = ref.watch(selectionProvider);
    final isDeleteOn = ref.watch(isDeleteProvider);
    final selectAllDef = ref.watch(selectAllDefProvider); // Track "select all" state for DEF
    final selectedDefenders = ref.watch(selectedDefPlayersProvider); // Track individual selected players for DEF

    // Filter defenders by team
    final players = allPlayers
        .where((p) => p['position'] == "DEF" || p['position'] == "Defender (DEF)")
        .where((p) => selectedTeam != null && p['team'] == selectedTeam)
        .toList();

    return Column(
      children: [
        SizedBox(height: 11.h),
        Row(
          children: [
            if (isDeleteOn) ...[
              Transform.scale(
                scale: 1.1,
                child: Checkbox(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100), // Circle shape
                  ),
                  checkColor: Colors.white, // Color of the check icon
                  fillColor: MaterialStateProperty.all(selectAllDef ? AppColors.redColor : Colors.transparent), // Red when checked
                  value: selectAllDef, // "Select all" checkbox state for DEF
                  onChanged: (bool? value) {
                    ref.read(selectAllDefProvider.notifier).state = value ?? false;
                    // Select/deselect all players based on "select all" checkbox
                    if (value ?? false) {
                      ref.read(selectedDefPlayersProvider.notifier).state =
                          List.generate(players.length, (index) => index); // Select all DEF players
                    } else {
                      ref.read(selectedDefPlayersProvider.notifier).state = []; // Deselect all DEF players
                    }
                  },
                ),
              ),
            ],
            Text("DEF", style: style.bodyLarge!.copyWith()),
          ],
        ),
        SizedBox(height: isDeleteOn ? 2.5.h : 15.h),
        Container(width: isDeleteOn ? 180.w : 144.w, height: 1.h, color: Colors.white),
        SizedBox(height: isDeleteOn ? 2.h : 4.h),

        // Render players with checkboxes
        ...List.generate(players.length, (index) {
          final player = players[index];
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
                        fillColor: MaterialStateProperty.all(selectedDefenders.contains(index) ? AppColors.redColor : Colors.transparent), // Red when checked
                        value: selectedDefenders.contains(index), // Individual checkbox state for DEF
                        onChanged: (bool? value) {
                          final selected = [...selectedDefenders];
                          if (value ?? false) {
                            selected.add(index); // Select defender
                          } else {
                            selected.remove(index); // Deselect defender
                          }
                          ref.read(selectedDefPlayersProvider.notifier).state = selected;

                          // If all defenders are selected, update "select all" checkbox state
                          if (selected.length == players.length) {
                            ref.read(selectAllDefProvider.notifier).state = true;
                          } else {
                            ref.read(selectAllDefProvider.notifier).state = false;
                          }
                        },
                      ),
                    ),
                  ],
                  SizedBox(
                    height: 50.h,
                    width: 144.w,
                    child: TextFormField(
                      readOnly: true, // Make the text field read-only
                      initialValue: player['name'],
                      decoration: customInputDecoration(),
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
      ],
    );
  },
),


//================================================================================================================================================
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Consumer(
                builder: (context,ref,_) {

                                        final isDeleteOn = ref.watch(isDeleteProvider);

                  return Column(
                    children: [
                       // if (isDeleteOn == true) ...[SizedBox(height: 5.5.h)],
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
                      Consumer(
                        builder: (context, ref, _) {
                          final allPlayers = ref.watch(playersProvider);
                          final selectedTeam = ref.watch(selectionProvider);
                  
                          // Filter defenders by team
                          final players = allPlayers
                              .where((p) => p['position'] == "DEF" || p['position'] == "Defender (DEF)")
                              .where((p) => selectedTeam != null && p['team'] == selectedTeam)
                              .toList();
                          return Column(
                            children: List.generate(players.length, (index) {
                              final player = players[index];
                              final globalIndex = allPlayers.indexOf(player);
                              return Row(
                                children: [
                                  CustomboxTile(
                                    value: player['SR'] ?? '',
                                    onChanged: (String value) {
                                      ref.read(playersProvider.notifier).updatePlayer(globalIndex, 'SR', value);
                                    },
                                  ),
                                  CustomboxTile(
                                    value: player['GM'] ?? '',
                                    onChanged: (String value) {
                                      ref.read(playersProvider.notifier).updatePlayer(globalIndex, 'GM', value);
                                    },
                                  ),
                                  CustomboxTile(
                                    value: player['GL'] ?? '',
                                    onChanged: (String value) {
                                      ref.read(playersProvider.notifier).updatePlayer(globalIndex, 'GL', value);
                                    },
                                  ),
                                  CustomboxTile(
                                    value: player['AGL'] ?? '',
                                    onChanged: (String value) {
                                      ref.read(playersProvider.notifier).updatePlayer(globalIndex, 'AGL', value);
                                    },
                                  ),
                                  CustomboxTile(
                                    value: player['-GL'] ?? '',
                                    onChanged: (String value) {
                                      ref.read(playersProvider.notifier).updatePlayer(globalIndex, '-GL', value);
                                    },
                                  ),
                                  CustomboxTile(
                                    value: player['-AGL'] ?? '',
                                    onChanged: (String value) {
                                      ref.read(playersProvider.notifier).updatePlayer(globalIndex, '-AGL', value);
                                    },
                                  ),
                                ],
                              );
                            }),
                          );
                        },
                      ),
                    ],
                  );
                }
              ),
            ),
          ),
        ],
      ),
    );
  }
}
