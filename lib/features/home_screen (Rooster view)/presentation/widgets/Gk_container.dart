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
                    SizedBox(height: 10.h),
                    Text("GK"),
                    SizedBox(height: 15.h),
                    Container(
                      width: 144.w,
                      height: 2.h,
                      color: Colors.white,
                    ),
                    SizedBox(height: 2.h),

                    ...List.generate(players.length, (index) {
                      return SizedBox(
                       // margin: EdgeInsets.only(bottom: 2.h),
                        height: 50.h,
                        width: 144.w,
                        child: TextFormField(
                          initialValue: ref.watch(
                            playersProvider,
                          )[index]['name'],
                          decoration: customInputDecoration(),
                        ),
                      );
                    }),
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
                    dividerThickness: 2.4 .h,
                    columns: [
                      DataColumn(label: Text("SR")),
                      DataColumn(label: Text("GM")),
                      DataColumn(label: Text("GL")),
                      DataColumn(label: Text("AGL")),
                      DataColumn(label: Text("-GL")),
                      DataColumn(label: Text("-AGL")),
                    ],
                    rows: List.generate(
                      players.length, 
                      (index) {
                        final player = players[index];
                        return DataRow(
                          color: MaterialStateProperty.resolveWith<Color?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.blue; // Change to the color you want for selected rows
      }
      return Colors.transparent; // Default color (transparent)
    },
  ),
                          cells: [
                            DataCell(
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.transparent)
                                ),
                                child: CustomboxTile(
                                  value: player['SR'] ?? '',
                                  onChanged: (String value) {
                                    ref
                                        .read(playersProvider.notifier)
                                        .updatePlayer(index, 'SR', value);
                                  },
                                ),
                              ),
                            ),
                            DataCell(
                              Container(
                                 decoration: BoxDecoration(
                                  border: Border.all(color: Colors.transparent)
                                ),
                                child: CustomboxTile(
                                  value: player['GM'] ?? '',
                                  onChanged: (String value) {
                                    ref
                                        .read(playersProvider.notifier)
                                        .updatePlayer(index, 'GM', value);
                                  },
                                ),
                              ),
                            ),
                            DataCell(
                              Container(
                                 decoration: BoxDecoration(
                                  border: Border.all(color: Colors.transparent)
                                ),
                                child: CustomboxTile(
                                  value: player['GL'] ?? '',
                                  onChanged: (String value) {
                                    ref
                                        .read(playersProvider.notifier)
                                        .updatePlayer(index, 'GL', value);
                                  },
                                ),
                              ),
                            ),
                            DataCell(
                              Container(
                                 decoration: BoxDecoration(
                                  border: Border.all(color: Colors.transparent)
                                ),
                                child: CustomboxTile(
                                  value: player['AGL'] ?? '',
                                  onChanged: (String value) {
                                    ref
                                        .read(playersProvider.notifier)
                                        .updatePlayer(index, 'AGL', value);
                                  },
                                ),
                              ),
                            ),
                            DataCell(
                              Container(
                                 decoration: BoxDecoration(
                                  border: Border.all(color: Colors.transparent)
                                ),
                                child: CustomboxTile(
                                  value: player['-GL'] ?? '',
                                  onChanged: (String value) {
                                    ref
                                        .read(playersProvider.notifier)
                                        .updatePlayer(index, '-GL', value);
                                  },
                                ),
                              ),
                            ),
                            DataCell(
                              Container(
                                 decoration: BoxDecoration(
                                  border: Border.all(color: Colors.transparent)
                                ),
                                child: CustomboxTile(
                                  value: player['-AGL'] ?? '',
                                  onChanged: (String value) {
                                    ref
                                        .read(playersProvider.notifier)
                                        .updatePlayer(index, '-AGL', value);
                                  },
                                ),
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
