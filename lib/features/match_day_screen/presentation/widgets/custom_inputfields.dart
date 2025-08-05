import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nololordos/core/constant/icons.dart';
import 'package:nololordos/core/routes/route_name.dart';
import 'package:nololordos/core/theme/theme_extension/app_colors.dart';
//import 'package:nololordos/features/Team_Selection_screen/Riverpod/selection_provider.dart';
import 'package:nololordos/features/match_day_screen/presentation/widgets/custom_icon_buttons.dart';

class CustomInputfields extends StatefulWidget {
  final TextEditingController matchName;
  final TextEditingController teamOne;
  final TextEditingController teamTwo;
  final TextEditingController scoreOne;
  final TextEditingController scoreTwo;
  final TextEditingController? date;

  const CustomInputfields({super.key,
  required this.matchName,
  required this.teamOne,
  required this.teamTwo,
  required this.scoreOne,
  required this.scoreTwo,
  this.date
  
  });


  @override
  State<CustomInputfields> createState() => _CustomInputfieldsState();
}

class _CustomInputfieldsState extends State<CustomInputfields> {
  late TextEditingController matchName;
  late TextEditingController teamOne;
  late TextEditingController teamTwo;
  late TextEditingController scoreOne;
  late TextEditingController scoreTwo;
  TextEditingController? date;

  @override
  void initState() {
    super.initState();

    matchName = widget.matchName;
    teamOne = widget.teamOne;
    teamTwo = widget.teamTwo;
    scoreOne = widget.scoreOne;
    scoreTwo = widget.scoreTwo;
    date = widget.date;
  }
  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Match Day",
              style: style.headlineLarge!.copyWith(
                fontSize: 28.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 15.w),
            SvgPicture.asset(AppIcons.isolationIcon),
            Spacer(),
            CustomIconButtons(onTap: () {
              context.push(RouteName.historyScreen);
            }, icon: AppIcons.transactionIcon),
          ],
        ),
        SizedBox(height: 25.h),

        Text(
          "League Name",
          style: style.bodyMedium!.copyWith(fontWeight: FontWeight.w500),
        ),
       
        SizedBox(height: 8.h),

        TextFormField(controller: matchName,),


        SizedBox(height: 19.h),

        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Consumer(
                builder: (context, ref, _) {
                  //final teamName = ref.watch(selectionProvider);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Match",
                          style: style.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      TextFormField(
controller: teamOne,
                      ),
                    ],
                  );
                }
              ),
            ),
            SizedBox(width: 8.h),
            SizedBox(
              height: 40.h,
              child: Center(
                child: Text(
                  "VS",
                  style: style.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    "",
                    style: style.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextFormField(controller: teamTwo,),
                ],
              ),
            ),
          ],
        ),
     
        SizedBox(height: 19.h),
       
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Score",
                      style: style.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextFormField(controller: scoreOne,),
                ],
              ),
            ),
            SizedBox(width: 8.h),
            SizedBox(
              height: 40.h,
              child: Center(
                child: Text(
                  "VS",
                  style: style.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    "",
                    style: style.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextFormField(controller: scoreTwo,),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 19.h),

        Text(
          "Date",
          style: style.bodyMedium!.copyWith(fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8.h),

        TextFormField(
          controller: date,
        decoration: InputDecoration(
          suffixIcon:Padding(
            padding: const EdgeInsets.all(14.0),
            child: SvgPicture.asset(AppIcons.calendarIcon,
            height: 16.h,
            width: 16.w,
            color: AppColors.deActiveTextColor,
            ),
          ) ,
        ),
        ),
        
        SizedBox(height: 19.h),
      ],
    );
  }
}
