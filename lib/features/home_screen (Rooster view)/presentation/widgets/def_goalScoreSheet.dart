// ignore_for_file: unnecessary_null_comparison

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
          Consumer(
            builder: (context, ref, _) {
            final allPlayers = ref.watch(playersProvider);
            final selectedTeam = ref.watch(selectionProvider);
            final isDeleteOn = ref.watch(isDeleteProvider);

              // Filter Defenders by team
              final players = allPlayers
                  .where((p) => p['position'] == "DEF" || p['position'] == "Defender (DEF)")
                  .where((p) => selectedTeam != null && p['team'] == selectedTeam)
                  .toList();
              return Column(
                children: [
                  SizedBox(height: 11.h),
                       Row(
                    children: [
                      if(isDeleteOn==true)...[
Transform.scale(
                        scale: 1.1,
                        child: Checkbox(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100), // Circle shape
                          ),
                        checkColor: Colors.white, // Color of the check icon
                          fillColor: MaterialStateProperty.all(AppColors.redColor), // Red when checked
                          value: true, onChanged: (v){}),
                      ),                      ],
                  Text("DEF", style: style.bodyLarge!.copyWith()),
                    ],
                  ),
                  SizedBox(height:isDeleteOn == true? 2.5.h : 15.h),//15
                  Container(width:isDeleteOn?180.w :144.w, height: 1.h, color: Colors.white),
                  SizedBox(height:isDeleteOn?2.h: 4.h),


                  ...List.generate(players.length, (index) {
                    return Column(
                      children: [
                          Row(
                        children: [
                           if (index == 0) SizedBox(height: 2.h),

                       if(isDeleteOn==true)...[
Transform.scale(
                        scale: 1.1,
                        child: Checkbox(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100), // Circle shape
                          ),
                        checkColor: Colors.white, // Color of the check icon
                          fillColor: MaterialStateProperty.all(AppColors.redColor), // Red when checked
                          value: true, onChanged: (v){}),
                      ),                      ],
                        SizedBox(
                          height: 50.h,
                          width: 144.w,
                          child: TextFormField(
                            readOnly: true, //etare false kora lagbo

                            initialValue: players[index]['name'],
                            decoration: customInputDecoration(),
                          ),
                        ),
                        ],
                       )
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

                      // Filter Defenders by team
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
