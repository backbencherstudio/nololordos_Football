import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nololordos/core/constant/images.dart';
import 'package:nololordos/core/theme/theme_extension/app_colors.dart';

class CustomLogoContainer extends StatelessWidget {
  const CustomLogoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 206.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: AppColors.onPrimary,
      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 22.w, vertical: 15.h),
        child: Image.asset(AppImages.logowhite),
      ),
    );
  }
}