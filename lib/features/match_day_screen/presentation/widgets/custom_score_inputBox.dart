import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nololordos/core/theme/theme_extension/app_colors.dart';
import 'package:nololordos/features/match_day_screen/presentation/widgets/custom_football_button.dart';
import 'package:nololordos/features/match_day_screen/presentation/widgets/custom_goalTaken_button.dart';
import 'package:nololordos/features/match_day_screen/presentation/widgets/custom_scroeBox.dart';
import 'package:nololordos/features/match_day_screen/presentation/widgets/inputdecoration.dart';

class CustomScoreInputbox extends StatelessWidget {
  final String name;
  final double goals;
  final double ownGoals;
  final int? selectedScore;

  final ValueChanged<String> onNameChanged;
  final VoidCallback onIncrementGoals;
  final VoidCallback onIncrementOwnGoals;
  final ValueChanged<int> onScoreSelected;

  const CustomScoreInputbox({
    super.key,
    required this.name,
    required this.goals,
    required this.ownGoals,
    required this.selectedScore,
    required this.onNameChanged,
    required this.onIncrementGoals,
    required this.onIncrementOwnGoals,
    required this.onScoreSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                  ),
                  initialValue: name,
                  onChanged: onNameChanged,
                  decoration: customInputDecoration(hintText: "Player Name"),
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Expanded(
                      child: CustomFootballButton(
                        count: goals.toString(),
                        onTap: onIncrementGoals,
                        isSelected: goals > 0,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: CustomGoaltakenButton(
                        count: ownGoals.toString(),
                        onTap: onIncrementOwnGoals,
                        isSelected: ownGoals > 0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 0.63,
                crossAxisSpacing: 4.h,
                mainAxisSpacing: 10.w,
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                final value = index + 1;
                return CustomScroebox(
                  count: value.toString(),
                  onTap: () => onScoreSelected(value),
                  isSelected: selectedScore == value,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
