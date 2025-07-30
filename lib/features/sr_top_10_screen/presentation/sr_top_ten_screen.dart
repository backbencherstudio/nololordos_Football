// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nololordos/core/theme/theme_extension/app_colors.dart';
import 'package:nololordos/features/sr_top_10_screen/presentation/widgets/banner_container.dart';

class SrTopTenScreen extends StatelessWidget {
  const SrTopTenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> players = [
      {"name": "GIORGOS SAMARAS", "sr": 9.25},
      {"name": "ALEXANDROS CHRISTODOULOPO...", "sr": 9.12},
      {"name": "DIMITRIOS KOLOVETSIOS", "sr": 9.02},
      {"name": "MARIOS VASILEIOU-ANAGNOSTOPOULOS", "sr": 8.98},
      {"name": "NIKOS PAPADIMITRIOU", "sr": 8.36},
      {"name": "GIANNIS TZAVELLAS", "sr": 7.55},
      {"name": "MARIOS VASILEIOU-ANAGNOSTOPOULOS", "sr": 7.54},
      {"name": "ALEXANDROS CHRISTODOULOPO...", "sr": 6.90},
      {"name": "NIKOS PAPADIMITRIOU", "sr": 6.50},
      {"name": "GIORGOS SAMARAS", "sr": 6.48},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF111828),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 55.h),
             BannerContainer(),
            SizedBox(height: 20.h),

            // TABLE STARTS HERE
            FittedBox(
              child: Container(
                  
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.onPrimary),
                ),
                child: DataTable(
                  headingRowColor: MaterialStateProperty.all(
                    AppColors.columnHeadre,
                  ),
                  dataRowColor: MaterialStateProperty.all(
                    const Color(0xFF191C31),
                  ),
                  headingTextStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 22.sp,
                  ),
                  dataTextStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
              
                    fontSize: 16.sp,
                  ),
                  columnSpacing: 15,
                  horizontalMargin: 12,
                  columns: [
                    DataColumn(
                      label: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 12.h,
                        ),
                        child: Text("#", textAlign: TextAlign.center),
                      ),
                    ),
                    DataColumn(
                      label: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(color: Colors.white, width: 0.5),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 12.h,
                          ),
                          child: Text("Player", textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(color: Colors.white, width: 0.5),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 12.h,
                          ),
                          child: Text("SR", textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(color: Colors.white, width: 0.5),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 26.w,
                            vertical: 12.h,
                          ),
                          child: Text("Last 5"),
                        ),
                      ),
                    ),
                  ],
                  rows: players.asMap().entries.map((entry) {
                    int index = entry.key + 1;
                    var player = entry.value;
              
                    return DataRow(
                      cells: [
                        DataCell(
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(),
                            child: Text(
                              index.toString().padLeft(2, '0'),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        DataCell(
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  color: Colors.white,
                                  width: 0.5,
                                ),
                              ),
                            ),
                            child: Text(
                              player['name'],
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        DataCell(
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  color: Colors.white,
                                  width: 0.5,
                                ),
                              ),
                            ),
                            child: Text(
                              player['sr'].toString(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        DataCell(
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  color: Colors.white,
                                  width: 0.5,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                5,
                                (i) => Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 2,
                                  ),
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: AppColors.deActiveTextColor
                                        .withOpacity(0.2),
                                  ),
                                  child: const Text(
                                    "9",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
