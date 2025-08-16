import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:nololordos/core/constant/icons.dart';
import 'package:nololordos/core/constant/images.dart';
import 'package:nololordos/core/constant/padding.dart';
import 'package:nololordos/core/routes/route_name.dart';
import 'package:nololordos/core/theme/theme_extension/app_colors.dart';
import 'package:nololordos/features/Team_Selection_screen/Riverpod/selection_provider.dart';
import 'package:nololordos/features/history_screen/presentation/widgets/custom_row_info.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/Riverpod/editProvider.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/Riverpod/isDeleteProvider.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/Riverpod/playerProvider.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/presentation/widgets/def_goalScoreSheet.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/presentation/widgets/deletealart_box.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/presentation/widgets/fwd_goalScoreSheet.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/presentation/widgets/goalScoreSheet.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/presentation/widgets/mid_goalScoreSheet.dart';
import 'package:nololordos/features/import_export_screen/presentation/widgets/custom_buttons.dart';
import 'package:nololordos/features/match_day_screen/Riverpod/srProvider.dart';
import 'package:nololordos/features/match_day_screen/presentation/widgets/custom_icon_buttons.dart';

class RoosterViewScreen extends StatelessWidget {
  const RoosterViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 100.h),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: AppPadding.screenHorizontal,
            child: Consumer(
              builder: (context, ref, _) {
                final isDeletOn = ref.watch(isDeleteProvider);
                return isDeletOn
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Consumer(
                            builder: (context, ref, _) {
                              return CustomButtons(
                                hieght: 60.h,
                                title: 'Reset Stats',
                                color: AppColors.resetbuttonColor,
                                icon: "",
                                onTap: () {
                                  ref.read(playersProvider.notifier).resetAllValues();
                                  ref.read(matchCountProvider.notifier).state = 0.00; 
                                  ref.read(scoreCountPerMatch.notifier).state = 0; 
                                  
                                    ref.read(finalTRAverageProvider.notifier).state= 0.00;


                                },
                              );
                            },
                          ),
                          SizedBox(height: 16.h),
                          CustomButtons(
                            hieght: 60.h,
                            title: 'Delete Player',
                            color: AppColors.redColor.withValues(alpha: 0.1),
                            borderColor: AppColors.redColor,
                            textColor: AppColors.onError,
                            icon: "",

                            onTap: () {
                              deleteAlertDialogueBox(context);
                            },
                          ),
                        ],
                      )
                    : CustomButtons(
                        hieght: 60.h,
                        color: AppColors.buttonAvtiveColor,
                        title: '+ Add Player',
                        icon: "",
                        onTap: () {
                          context.push(RouteName.addPlayerScreen);
                        },
                      );
              },
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      body: Consumer(
        builder: (context, ref, _) {
          final isEditOn = ref.watch(isEditOnProvider);

          return Column(
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
                    if (isEditOn == false) ...[
                      CustomIconButtons(
                        onTap: () {
                          ref.watch(isEditOnProvider.notifier).state = true;
                        },
                        icon: AppIcons.remove,
                      ),
                    ],
                   if(isEditOn == true)...[
                     CustomIconButtons(
                      onTap: () {
                        ref
                            .read(isEditOnProvider.notifier)
                            .update((state) => false);
                        Fluttertoast.showToast(
                          msg: "Edit mode is ON",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                        debugPrint(
                          "\n\n edit provider -> ${ref.read(isEditOnProvider)}\n\n",
                        );
                      },
                      icon: AppIcons.pencilIcon,
                    ),
                    CustomIconButtons(
                      onTap: () {
                        ref
                            .read(isDeleteProvider.notifier)
                            .update((state) => !state); //toggle koraitse
                      },
                      icon: AppIcons.trashIcon,
                    ),
                   ]
                  ],
                ),
              ),
              SizedBox(height: 19.h),
              Consumer(
                builder: (context, ref, _) {
                  final teamName = ref.watch(selectionProvider);
                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryContainer,
                    ),
                    child: Consumer(
                      builder: (context, ref, _) {
                        final finalTR = ref.watch(finalTRAverageProvider);

                        return Padding(
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
                            score: "STR ${finalTR.toStringAsFixed(2)}",
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      //gk container
                      SizedBox(height: 24.h),
                      GoalScoreSheet(),
                      //def container
                      SizedBox(height: 24.h),
                      DefGoalscoresheet(),
                      //mid container
                      SizedBox(height: 24.h),
                      MidGoalscoresheet(),
                      SizedBox(height: 24.h),
                      //fwd container
                      FwdGoalscoresheet(),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 200.h),
            ],
          );
        },
      ),
    );
  }
}
