// ignore_for_file: unnecessary_null_comparison, deprecated_member_use

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

class Goalscoresheet extends StatelessWidget {
  const Goalscoresheet({super.key});

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





  Consumer(
  builder: (context, ref, _) {
    final allPlayers = ref.watch(playersProvider);
    final selectedTeam = ref.watch(selectionProvider);
    final isDeleteOn = ref.watch(isDeleteProvider);
    
    // Track selection state for GK
    final selectAllGK = ref.watch(selectAllGKProvider); // "Select All" for GK
    final selectedGKPlayers = ref.watch(selectedGKPlayersProvider); // Track GK players individually

    // Filter goalkeepers by team
    final players = allPlayers
        .where((p) => p['position'] == "GK" || p['position'] == "Goalkeeper (GK)")
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
                  fillColor: MaterialStateProperty.all(selectAllGK ? AppColors.redColor : Colors.transparent), // Red when checked
                  value: selectAllGK, // "Select all" checkbox state for GK
                  onChanged: (bool? value) {
                    ref.read(selectAllGKProvider.notifier).state = value ?? false;
                    // Select/deselect all players based on "select all" checkbox
                    if (value ?? false) {
                      ref.read(selectedGKPlayersProvider.notifier).state =
                          List.generate(players.length, (index) => index); // Select all GK players
                    } else {
                      ref.read(selectedGKPlayersProvider.notifier).state = []; // Deselect all GK players
                    }
                  },
                ),
              ),
            ],
            Text("GK", style: style.bodyLarge!.copyWith()),
          ],
        ),
        SizedBox(height: isDeleteOn ? 2.5.h : 15.h),
        Container(width: isDeleteOn ? 180.w : 144.w, height: 1.h, color: Colors.white),
        SizedBox(height: isDeleteOn ? 2.h : 4.h),

        // Render goalkeepers with checkboxes
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
                        fillColor: MaterialStateProperty.all(selectedGKPlayers.contains(index) ? AppColors.redColor : Colors.transparent),
                        value: selectedGKPlayers.contains(index), // Individual checkbox state for GK
                    
                        onChanged: (bool? value) {
                          final selected = [...selectedGKPlayers];
                          if (value ?? false) {
                            selected.add(index); // Select goalkeeper
                          } else {
                            selected.remove(index); // Deselect goalkeeper
                          }
                          ref.read(selectedGKPlayersProvider.notifier).state = selected;

                          // If all goalkeepers are selected, update "select all" checkbox state
                          if (selected.length == players.length) {
                            ref.read(selectAllGKProvider.notifier).state = true; // All selected
                          } else {
                            ref.read(selectAllGKProvider.notifier).state = false; // Not all selected
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


          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
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

                      // Filter goalkeepers by team
                      final players = allPlayers
                          .where((p) => p['position'] == "GK" || p['position'] == "Goalkeeper (GK)")
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}