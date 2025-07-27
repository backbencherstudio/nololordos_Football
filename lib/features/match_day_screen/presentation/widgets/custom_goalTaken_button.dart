import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nololordos/core/constant/icons.dart';
import 'package:nololordos/core/theme/theme_extension/app_colors.dart';

class CustomGoaltakenButton extends StatelessWidget {
  final void Function()? onTap;
  final bool isSelected;
  final String count;
  const CustomGoaltakenButton({
    super.key,
    required this.onTap,
    required this.isSelected,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 73.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),

          border: Border.all(color: AppColors.onPrimary, width: 1.w),
          color: isSelected ? AppColors.onPrimary : AppColors.primaryContainer,
        ),
        child: Padding(
          padding: EdgeInsets.all(8.r),
          // ignore: deprecated_member_use
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppIcons.goalpostIcon,
                color: isSelected ? AppColors.primary : AppColors.onPrimary,
              ),
              if (isSelected == true) ...[
                SizedBox(width: 8.w),

                Text(
                  count,
                  style: style.bodyMedium!.copyWith(
                    color: AppColors.subTextColor,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
