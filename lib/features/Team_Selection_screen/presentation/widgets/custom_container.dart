import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nololordos/core/theme/theme_extension/app_colors.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  const CustomContainer({super.key,
  required this.child
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 560.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 16,
            right: 16,
            bottom: 0,
            child: Container(
              width: 279.w,
              height: 513.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
                color: AppColors.ternaryContainer,
              ),
            ),
          ),
          Positioned(
            top: 38,

            left: 6,
            right: 6,
            child: Container(
              width: 307.w,
              height: 510.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
                color: AppColors.secondaryContainer,
              ),
            ),
          ),
          ClipRRect(
            child: Container(
              width: 327.w,
              height: 500.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
                color: AppColors.primaryContainer,
              ),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
