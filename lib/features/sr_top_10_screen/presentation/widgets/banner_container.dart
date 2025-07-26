import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nololordos/core/constant/images.dart';
import 'package:nololordos/core/theme/theme_extension/app_colors.dart';

class BannerContainer extends StatelessWidget {
  const BannerContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 123.h,
      width: 327.w,
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: BoxDecoration(
        color: AppColors.onSurface,
      ),
      child: Center(child: Image.asset(AppImages.imageTwo)),
    );
  }
}