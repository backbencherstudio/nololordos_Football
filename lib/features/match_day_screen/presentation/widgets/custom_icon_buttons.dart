import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nololordos/core/theme/theme_extension/app_colors.dart';

class CustomIconButtons extends StatelessWidget {
  final void Function()? onTap;
  final String icon;
  const CustomIconButtons({super.key,
  required this.onTap,
  required this.icon
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap ,
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.onPrimary.withValues(alpha: 0.1),
        ),
        child: SvgPicture.asset(icon),
      ),
    );
  }
}