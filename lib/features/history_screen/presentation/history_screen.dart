import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nololordos/core/constant/icons.dart';
import 'package:nololordos/core/constant/padding.dart';
import 'package:nololordos/core/theme/theme_extension/app_colors.dart';
import 'package:nololordos/features/history_screen/Riverpod/date_time_provider.dart';
import 'package:nololordos/features/history_screen/presentation/widgets/custom_box_info.dart';
import 'package:nololordos/features/match_day_screen/Riverpod/matchProvider.dart';
import 'package:nololordos/features/match_day_screen/presentation/widgets/custom_icon_buttons.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  CustomIconButtons(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    icon: AppIcons.back,
                  ),
                  SizedBox(width: 12),

                  Text(
                    "History",
                    style: style.headlineLarge!.copyWith(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Image.asset("assets/icons/Icon.png", height: 58.h,width: 58.w,),//client uregnt chaise
                  Spacer(),

                  CustomIconButtons(
                    onTap: () async {
                      final selectedDate = ref.watch(selectedDateProvider);
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDate ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                            data: ThemeData.dark().copyWith(
                              primaryColor: AppColors.primaryContainer,
                              highlightColor: AppColors.primary,
                              buttonTheme: ButtonThemeData(
                                textTheme: ButtonTextTheme.primary,
                              ),
                              colorScheme:
                                  ColorScheme.dark(
                                        primary: AppColors.buttonAvtiveColor,
                                        onPrimary: AppColors.onPrimary,
                                        surface: AppColors.primaryContainer,
                                        onSurface: AppColors.onPrimary,
                                      )
                                      .copyWith(
                                        secondary: AppColors.buttonAvtiveColor,
                                      )
                                      .copyWith(
                                        background: AppColors.primaryContainer,
                                      ),
                            ),
                            child: child!,
                          );
                        },
                      );

                      if (pickedDate != null) {
                        ref.read(selectedDateProvider.notifier).state =
                            pickedDate;
                      }
                    },
                    icon: AppIcons.calendarIcon,
                  ),
                ],
              ),

              
              Consumer(
                builder: (context, ref , _) {
final data = ref.watch(matchHistoryProvider);

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 20.h),
                        child: CustomBoxInfo(
                          matchName: data[index].matchName,
                          scoreOne: data[index].teamOneScore,
                          scoreTwo: data[index].teamTwoScore,
                          teamOne:data[index].teamOne,
                          teamTwo: data[index].teamTwo,
                          date: data[index].date,
                        ),
                      );
                    },
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
