import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nololordos/core/theme/theme_extension/app_colors.dart';

class CustomScroebox extends StatelessWidget {
 

  final void Function()? onTap;
  final String count;
  final bool isSelected;
  const CustomScroebox({
    super.key,
    required this.count,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child:
      
       Container(
        alignment: Alignment.center,
        height: 43.h,
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
    
          border: Border.all(color: AppColors.onPrimary, width: 1.w),
          color: isSelected ? AppColors.onPrimary : AppColors.primaryContainer,
        ),
        child: Text(
          count,
          style: style.labelSmall!.copyWith(
           color: isSelected? AppColors.surface: AppColors.containerTextColor,
           
          ),
        ),
      ),
    );
  }
}
