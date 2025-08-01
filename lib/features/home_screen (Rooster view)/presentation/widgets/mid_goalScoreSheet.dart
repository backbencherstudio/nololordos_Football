import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nololordos/core/theme/theme_extension/app_colors.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/Riverpod/playerProvider.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/presentation/widgets/customBox_tile.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/presentation/widgets/title.dart';
import 'package:nololordos/features/match_day_screen/presentation/widgets/inputdecoration.dart';

class MidGoalscoresheet extends StatelessWidget {
  const MidGoalscoresheet({super.key});

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
    final players = allPlayers.where((p) => p['position'] == "Midfielder (MID)").toList();
              return Column(
                children: [
                  SizedBox(height: 11.h),
                  Text("MID", style: style.bodyLarge!.copyWith()),
                  SizedBox(height: 15.h),
                  Container(width: 144.w, height: 1.h, color: Colors.white),
                  SizedBox(height: 2.h),

                  ...List.generate(players.length, (index) {
                    return Column(
                      children: [
                        if(index==0)
                        SizedBox(height: 2.h,),
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
    final players = allPlayers.where((p) => p['position'] == "Midfielder (MID)").toList();

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
