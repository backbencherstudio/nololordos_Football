import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nololordos/core/constant/icons.dart';
import 'package:nololordos/core/theme/theme_extension/app_colors.dart';

class CustomButtons extends StatelessWidget {
  final String title;
  final String icon;
  final void Function()? onTap;
  const CustomButtons({super.key,
  required this.title,
  required this.icon,
  required this.onTap,
  
  });

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 75.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90.r),
          color: AppColors.secondary,
        ),
      
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(icon),
            SizedBox(width: 10.w),
            Text(
              title,
              style: style.titleSmall!.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
