// ignore_for_file: avoid_types_as_parameter_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nololordos/core/theme/theme_extension/app_colors.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/Riverpod/playerProvider.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/presentation/widgets/customBox_tile.dart';
import 'package:nololordos/features/match_day_screen/presentation/widgets/inputdecoration.dart';

class GkContainer extends StatelessWidget {
  const GkContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final players = ref.watch(playersProvider);

        return Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(color: AppColors.primaryContainer),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Column(
                  children: [
                    SizedBox(height: 11.5.h),
                    Text("GK"),
                    SizedBox(height: 7.h),
                    SizedBox(
                      width: 144.w,
                      child: Divider(
                        color: AppColors.containerTextColor,
                        thickness: 1.5,
                        indent: 0,
                        endIndent: 0,
                      ),
                    ),
                    SizedBox(height: 2.h),
               

                

                    ...List.generate(players.length, (index){
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 5.5.h),
                          height: 40.h,
                          width: 144.w,
                          child: TextFormField(
 initialValue: ref.watch(playersProvider)[index]['name'],
                             decoration: customInputDecoration(),
                          ),
                        );
                    })
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    horizontalMargin: 8.w,
                    columnSpacing: 8.w,
                    dataRowMinHeight: 50.h,
                    dataRowMaxHeight: 50.h,
                    columns: [
                      DataColumn(label: Text("SR")),
                      DataColumn(label: Text("GM")),
                      DataColumn(label: Text("GL")),
                      DataColumn(label: Text("AGL")),
                      DataColumn(label: Text("-GL")),
                      DataColumn(label: Text("-AGL")),
                    ],
                    rows: List.generate(
                      players.length, // Generate rows based on players
                      (index) {
                        final player = players[index];
                        return DataRow(
                          cells: [
                            DataCell(
                              CustomboxTile(
                                value: player['SR'] ?? '',
                                onChanged: (String value) {
                                  ref
                                      .read(playersProvider.notifier)
                                      .updatePlayer(index, 'SR', value);
                                },
                              ),
                            ),
                            DataCell(
                              CustomboxTile(
                                value: player['GM'] ?? '',
                                onChanged: (String value) {
                                  ref
                                      .read(playersProvider.notifier)
                                      .updatePlayer(index, 'GM', value);
                                },
                              ),
                            ),
                            DataCell(
                              CustomboxTile(
                                value: player['GL'] ?? '',
                                onChanged: (String value) {
                                  ref
                                      .read(playersProvider.notifier)
                                      .updatePlayer(index, 'GL', value);
                                },
                              ),
                            ),
                            DataCell(
                              CustomboxTile(
                                value: player['AGL'] ?? '',
                                onChanged: (String value) {
                                  ref
                                      .read(playersProvider.notifier)
                                      .updatePlayer(index, 'AGL', value);
                                },
                              ),
                            ),
                            DataCell(
                              CustomboxTile(
                                value: player['-GL'] ?? '',
                                onChanged: (String value) {
                                  ref
                                      .read(playersProvider.notifier)
                                      .updatePlayer(index, '-GL', value);
                                },
                              ),
                            ),
                            DataCell(
                              CustomboxTile(
                                value: player['-AGL'] ?? '',
                                onChanged: (String value) {
                                  ref
                                      .read(playersProvider.notifier)
                                      .updatePlayer(index, '-AGL', value);
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
