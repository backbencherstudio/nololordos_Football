import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nololordos/core/constant/icons.dart';
import 'package:nololordos/core/constant/padding.dart';
import 'package:nololordos/features/history_screen/presentation/widgets/custom_box_info.dart';
import 'package:nololordos/features/match_day_screen/presentation/widgets/custom_icon_buttons.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
        final style = Theme.of(context).textTheme;

    return Scaffold(
      body: Padding(
        padding: AppPadding.screenHorizontal,
        child: SingleChildScrollView(
          child: Column(
            children: [
                              SizedBox(height: 55.h),
          
               Row(
              children: [
                  CustomIconButtons(onTap: () {
                  Navigator.pop(context);
                }, icon: AppIcons.back),
                SizedBox(width: 12,),
            
                Text(
                  "History",
                  style: style.headlineLarge!.copyWith(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 15.w),
                SvgPicture.asset(AppIcons.iso),
                Spacer(),
                CustomIconButtons(onTap: () {
                  // calender
                }, icon: AppIcons.calendarIcon),
              ],
            ),
          
                ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index){
          return Padding(
            padding:  EdgeInsets.only(bottom: 20.h),
            child: CustomBoxInfo(),
          );
                })
          
          
            ],
          ),
        ),
      ),
    );
  }
}