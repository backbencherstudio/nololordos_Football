import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nololordos/core/theme/theme_extension/app_colors.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  const CustomButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90.r),
          color: AppColors.secondary,
        ),
        child: Padding(
          padding: EdgeInsets.all(10.r),
          child: Center(
            child: Text(
              title,
              style: style.bodyLarge!.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.onPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
