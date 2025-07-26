import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nololordos/core/theme/theme_extension/app_colors.dart';
import 'package:nololordos/features/match_day_screen/presentation/widgets/custom_football_button.dart';
import 'package:nololordos/features/match_day_screen/presentation/widgets/custom_goalTaken_button.dart';
import 'package:nololordos/features/match_day_screen/presentation/widgets/inputdecoration.dart';

class CustomScoreInputbox extends StatelessWidget {
  const CustomScoreInputbox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 363.w,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: AppColors.primaryContainer,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                TextFormField(
                  decoration: customInputDecoration(hintText: "Player Name"),
                ),

                SizedBox(height: 10.h),
                Row(
                  children: [
                    Expanded(child: CustomFootballButton(onTap: () {}, isSelected: true)),
                    SizedBox(width: 8.w),
                    Expanded(child: CustomGoaltakenButton(onTap: () {}, isSelected: false)),
                  ],
                ),
              ],
            ),
          ),
          Expanded(child: Column(children: [Text("skhj")])),
        ],
      ),
    );
  }
}
