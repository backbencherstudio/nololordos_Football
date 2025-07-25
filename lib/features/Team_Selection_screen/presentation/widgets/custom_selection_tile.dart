import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nololordos/core/theme/theme_extension/app_colors.dart';

class CustomSelectionTile extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  final String logo;
  final bool isSelected;
  const CustomSelectionTile({super.key,
  required this.title,
  required this.logo,
  required this.onTap,
  required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
        final style = Theme.of(context).textTheme;

    return GestureDetector(
      onTap:onTap,
      child: Container(
       
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90.r),
          color:isSelected? AppColors.buttonAvtiveColor: AppColors.secondary
        ),
        child: Padding(
          padding:EdgeInsets.all(15.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(logo, height: 36.h,width: 36.w,),
              SizedBox(width: 10.w,),
              Text(title,
              style: style.titleSmall!.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.onPrimary,
              ),
              )
            ],
          ),
        ),
      ),
    );
  }
}