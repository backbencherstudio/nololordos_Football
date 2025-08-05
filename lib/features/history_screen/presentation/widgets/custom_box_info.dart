import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nololordos/core/constant/images.dart';
import 'package:nololordos/core/theme/theme_extension/app_colors.dart';
import 'package:nololordos/features/history_screen/presentation/widgets/custom_row_info.dart';

class CustomBoxInfo extends StatelessWidget {
  final String teamOne;
  final String teamTwo;
  final String date;
  final String matchName;
  final String scoreOne;
  final String scoreTwo;


  const CustomBoxInfo({super.key,
  required this.matchName,
  required this.scoreOne,
  required this.scoreTwo,
  required this.teamOne,
  required this.teamTwo,
  required this.date,
  
  });

  @override
  Widget build(BuildContext context) {
                final style = Theme.of(context).textTheme;

    return Column(
      children: [
        Row(children: [Text( matchName,
         style: style.bodyLarge!.copyWith(
          fontWeight: FontWeight.w500,
        ),
        ), Spacer(), Text(date,
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
              
              CustomRowInfo(title: teamOne, icon:AppImages.teamAek, score: scoreOne),
            SizedBox(height: 12.h,),
              CustomRowInfo(title: teamTwo, icon:AppImages.teamoenetik, score: scoreTwo),
            ],
          ),
        ),
      ],
    );
  }
}
