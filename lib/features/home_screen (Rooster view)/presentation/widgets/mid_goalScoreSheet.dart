// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nololordos/core/theme/theme_extension/app_colors.dart';
import 'package:nololordos/features/Team_Selection_screen/Riverpod/selection_provider.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/Riverpod/delete_provider_selection.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/Riverpod/editProvider.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/Riverpod/isDeleteProvider.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/Riverpod/playerProvider.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/presentation/widgets/customBox_tile.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/presentation/widgets/title.dart';
import 'package:nololordos/features/match_day_screen/presentation/widgets/inputdecoration.dart';

class MidGoalscoresheet extends ConsumerStatefulWidget {
  const MidGoalscoresheet({super.key});

  @override
  _MidGoalscoresheetState createState() => _MidGoalscoresheetState();
}

class _MidGoalscoresheetState extends ConsumerState<MidGoalscoresheet> {
  // Map to hold TextEditingController for each player
  late Map<String, TextEditingController> controllers;

  @override
  void initState() {
    super.initState();
    // Initialize the controllers map
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

    // Filter midfielders by team
    final players = allPlayers
        .where(
          (p) =>
              (p.position == "MID" || p.position == "Midfielder (MID)") &&
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
              SizedBox(height: isDeleteOn ? 6.h : 11.h),
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
                                  'position': 'MID',
                                }),
                              )
                              ? AppColors.redColor
                              : Colors.transparent,
                        ),
                        value: ref.watch(
                          allPlayersTeamPositionSelectionProvider({
                            'team': selectedTeam,
                            'position': 'MID',
                          }),
                        ),
                        onChanged: (_) {
                          toggleSelectAllPlayers(ref, selectedTeam, 'MID');
                          debugPrint(
                            "Delete player IDs: ${ref.read(deletePlayerIdListProvider)}",
                          );
                        },
                      ),
                    ),
                  ],
                  Text("MID", style: style.bodyLarge),
                ],
              ),
              SizedBox(height: isDeleteOn ? 2.5.h : 15.h),
              Container(
                width: isDeleteOn ? 180.w : 144.w,
                height: 1.h,
                color: Colors.white,
              ),
              SizedBox(height: isDeleteOn ? 2.h : 4.h),

              // Render individual midfielders
              ...players.map((player) {
                final id = player.id;
                final isSelected = ref
                    .watch(deletePlayerIdListProvider)
                    .contains(id);

                debugPrint('$id selected: $isSelected');

                // Initialize controller for each player only once
                if (!controllers.containsKey(id)) {
                  controllers[id] = TextEditingController(text: player.name);
                }

                return Column(
                  children: [
                    SizedBox(height: isDeleteOn ? 1.h : null),
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
                          width: 144.w,
                          child: TextFormField(
                            controller: controllers[id],  // Use the player-specific controller
                            onChanged: (value) {
                              // Update the player's name when it changes
                              ref.read(playersProvider.notifier).updatePlayerName(player.id, value);
                            },
                            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                            readOnly: isEditon,  // Make it readonly if editing is off
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
            return Row(
              children: [
                CustomboxTile(
                  readOnlyValue: isEditon,
                  value: player.sr.toStringAsFixed(2),
                  onChanged: (value) {
                    ref
                        .read(playersProvider.notifier)
                        .updatePlayer(player.id, "SR", value);
                  },
                ),
                CustomboxTile(
                  readOnlyValue: isEditon,
                  value: player.gm.toStringAsFixed(2),
                  onChanged: (value) {
                    ref
                        .read(playersProvider.notifier)
                        .updatePlayer(player.id, "GM", value);
                  },
                ),
                CustomboxTile(
                  readOnlyValue: isEditon,
                  value: player.gl.toString(), // Assuming player.gl is the correct variable
                  onChanged: (value) {
                    ref
                        .read(playersProvider.notifier)
                        .updatePlayer(player.id, "GL", value);
                  },
                ),
                CustomboxTile(
                  readOnlyValue: isEditon,
                  value: player.agl.toStringAsFixed(2),
                  onChanged: (value) {
                    ref
                        .read(playersProvider.notifier)
                        .updatePlayer(player.id, "AGL", value);
                  },
                ),
                CustomboxTile(
                  readOnlyValue: isEditon,
                  value: player.minusGl.toStringAsFixed(2),
                  onChanged: (value) {
                    ref
                        .read(playersProvider.notifier)
                        .updatePlayer(player.id, "-GL", value);
                  },
                ),
                CustomboxTile(
                  readOnlyValue: isEditon,
                  value: player.minusAgl.toStringAsFixed(2),
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
)]));}}
