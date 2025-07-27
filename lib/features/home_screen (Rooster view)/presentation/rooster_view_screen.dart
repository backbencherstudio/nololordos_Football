import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nololordos/core/constant/icons.dart';
import 'package:nololordos/core/constant/images.dart';
import 'package:nololordos/core/constant/padding.dart';
import 'package:nololordos/core/theme/theme_extension/app_colors.dart';
import 'package:nololordos/features/Team_Selection_screen/Riverpod/selection_provider.dart';
import 'package:nololordos/features/history_screen/presentation/widgets/custom_row_info.dart';
import 'package:nololordos/features/import_export_screen/presentation/widgets/custom_buttons.dart';
import 'package:nololordos/features/match_day_screen/presentation/widgets/custom_icon_buttons.dart';

class RoosterViewScreen extends StatelessWidget {
  const RoosterViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: AppPadding.screenHorizontal,
          child: CustomButtons(
            hieght: 60.h,
            color: AppColors.buttonAvtiveColor,
            title: '+ Add Player',
            icon: '',
            onTap: () {},
          ),
        ),
      ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      body: Column(
        children: [
          SizedBox(height: 55.h),
          Padding(
            padding: AppPadding.screenHorizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  AppImages.mainLogoWhite,
                  width: 200.w,
                  height: 38.h,
                ),

                CustomIconButtons(onTap: () {}, icon: AppIcons.pencilIcon),
                CustomIconButtons(onTap: () {}, icon: AppIcons.trashIcon),
              ],
            ),
          ),
          SizedBox(height: 19.h),
          Consumer(
            builder: (context, ref, _) {
              final teamName = ref.watch(selectionProvider);
              return Container(
                decoration: BoxDecoration(color: AppColors.primaryContainer),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 12.h,
                  ),
                  child: CustomRowInfo(
                    title: teamName.toString(),
                    height: 36.h,
                    width: 36.w,
                    icon: teamName == "AEK Athens"
                        ? AppImages.teamAek
                        : AppImages.teamoenetik,
                    score: "STR 2.36",
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
