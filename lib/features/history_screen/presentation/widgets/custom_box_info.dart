import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nololordos/core/constant/images.dart';
import 'package:nololordos/core/theme/theme_extension/app_colors.dart';
import 'package:nololordos/features/history_screen/presentation/widgets/custom_row_info.dart';

class CustomBoxInfo extends StatelessWidget {
  const CustomBoxInfo({super.key});

  @override
  Widget build(BuildContext context) {
                final style = Theme.of(context).textTheme;

    return Column(
      children: [
        Row(children: [Text("Champions League",
         style: style.bodyLarge!.copyWith(
          fontWeight: FontWeight.w500,
        ),
        ), Spacer(), Text("12/07/2025",
         style: style.bodyLarge!.copyWith(
          fontWeight: FontWeight.w500,
        ),
        )]),

        SizedBox(height: 8.h),

        Container(
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            border: Border.all(
              width: 0.5,
              color: AppColors.onPrimary.withValues(alpha: 0.2,)
            ),
            color: AppColors.primaryContainer,
          ),
          child: Column(
            children: [
              
              CustomRowInfo(title: 'AEK Athens', icon:AppImages.teamAek, score: '3'),
            SizedBox(height: 12.h,),
              CustomRowInfo(title: 'Panathinaikos', icon:AppImages.teamoenetik, score: '0'),
            ],
          ),
        ),
      ],
    );
  }
}
