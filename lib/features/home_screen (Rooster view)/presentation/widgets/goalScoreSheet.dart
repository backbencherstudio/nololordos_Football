// ignore_for_file: unnecessary_null_comparison, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nololordos/core/theme/theme_extension/app_colors.dart';
import 'package:nololordos/features/Team_Selection_screen/Riverpod/selection_provider.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/Riverpod/isDeleteProvider.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/Riverpod/playerProvider.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/presentation/widgets/customBox_tile.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/presentation/widgets/title.dart';
import 'package:nololordos/features/match_day_screen/presentation/widgets/inputdecoration.dart';

import '../../Riverpod/delete_provider_selection.dart';

class GoalScoreSheet extends ConsumerWidget {
  const GoalScoreSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;
    final allPlayers = ref.watch(playersProvider);
    final selectedTeam = ref.watch(selectionProvider);
    final isDeleteOn = ref.watch(isDeleteProvider);


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
              SizedBox(height: 11.h),
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
                            'team': selectedTeam ,
                            'position': 'GK',
                          }),
                        ),
                        onChanged: (_) {
                          toggleSelectAllPlayers(ref, selectedTeam , 'GK');
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
              SizedBox(height: isDeleteOn ? 2.5.h : 15.h),
              Container(
                width: isDeleteOn ? 180.w : 144.w,
                height: 1.h,
                color: Colors.white,
              ),
              SizedBox(height: isDeleteOn ? 2.h : 4.h),

              // Render individual goalkeepers
              ...players.map((player) {
                final id = player.id ;
                final isSelected = ref
                    .watch(deletePlayerIdListProvider)
                    .contains(id);

                debugPrint('$id selected: $isSelected');
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
                                  debugPrint("Delete player IDs: ${ref.read(deletePlayerIdListProvider)}");
                                }

                            ),
                          ),
                        ],
                        SizedBox(
                          height: 50.h,
                          width: 144.w,
                          child: TextFormField(
                            readOnly: true,
                            initialValue: player.name,
                            decoration: customInputDecoration(),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }).toList(),
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
                      final globalIndex = allPlayers.indexOf(player);
                      return Row(
                        children: [
                          CustomboxTile(
                            value: player.sr ,
                            onChanged: (value) {
                              ref
                                  .read(playersProvider.notifier)
                                  .updatePlayer(globalIndex, value);
                            },
                          ),
                          CustomboxTile(
                            value: player.gm,
                            onChanged: (value) {
                              ref
                                  .read(playersProvider.notifier)
                                  .updatePlayer(globalIndex,  value);
                            },
                          ),
                          CustomboxTile(
                            value: player.gm,
                            onChanged: (value) {
                              ref
                                  .read(playersProvider.notifier)
                                  .updatePlayer(globalIndex,  value);
                            },
                          ),
                          CustomboxTile(
                            value: player.agl,
                            onChanged: (value) {
                              ref
                                  .read(playersProvider.notifier)
                                  .updatePlayer(globalIndex,  value);
                            },
                          ),
                          CustomboxTile(
                            value: player.minusGl,
                            onChanged: (value) {
                              ref
                                  .read(playersProvider.notifier)
                                  .updatePlayer(globalIndex,  value);
                            },
                          ),
                          CustomboxTile(
                            value: player.minusAgl,
                            onChanged: (value) {
                              ref
                                  .read(playersProvider.notifier)
                                  .updatePlayer(globalIndex,  value);
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
