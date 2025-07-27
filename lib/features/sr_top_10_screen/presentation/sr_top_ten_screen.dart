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
      {"name": "GIORGOS\nSAMARAS", "sr": 9.25},
      {"name": "ALEXANDROS\nCHRISTODOULOPO...", "sr": 9.12},
      {"name": "DIMITRIOSn\nKOLOVETSIOS", "sr": 9.02},
      {"name": "MARIOS\nVASILEIOU-ANAGNOSTOPOULOS", "sr": 8.98},
      {"name": "NIKOS\nPAPADIMITRIOU", "sr": 8.36},
      {"name": "GIANNIS\nTZAVELLAS", "sr": 7.55},
      {"name": "MARIOS\nVASILEIOU-ANAGNOSTOPOULOS", "sr": 7.54},
      {"name": "ALEXANDROS\nCHRISTODOULOPO...", "sr": 6.90},
      {"name": "NIKOS\nPAPADIMITRIOU", "sr": 6.50},
      {"name": "GIORGOS\nSAMARAS", "sr": 6.48},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF111828),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 55.h),
            const BannerContainer(),
            SizedBox(height: 20.h),

            // 📌 TABLE STARTS HERE
            FittedBox(
              child: DataTable(
                
                headingRowColor:
                    MaterialStateProperty.all(const Color(0xFF1F2937)),
                dataRowColor:
                    MaterialStateProperty.all(const Color(0xFF111828)),
                headingTextStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
                dataTextStyle: TextStyle(color: Colors.white, fontSize: 13.sp),
                columns: const [
                  DataColumn(label: Text("#")),
                  DataColumn(label: Text("Player")),
                  DataColumn(label: Text("SR")),
                  DataColumn(label: Text("Last 5")),
                ],
                rows: players.asMap().entries.map((entry) {
                  int index = entry.key + 1;
                  var player = entry.value;
              
                  return DataRow(
                    cells: [
                      DataCell(Text(index.toString().padLeft(2, '0'))),
                      DataCell(Text(
                        player['name'],
                        overflow: TextOverflow.ellipsis,
                      )),
                      DataCell(Text(player['sr'].toString())),
                      DataCell(
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(
                            5,
                            (i) => Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: AppColors.primaryContainer,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                    color: Colors.grey.shade600, width: 1),
                              ),
                              child: const Text(
                                "9",
                                style: TextStyle(color: Colors.white),
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
          ],
        ),
      ),
    );
  }
}
