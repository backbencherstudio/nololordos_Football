import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nololordos/core/constant/images.dart';
import 'package:nololordos/core/constant/padding.dart';
import 'package:nololordos/core/theme/theme_extension/app_colors.dart';
import 'package:nololordos/features/Team_Selection_screen/Riverpod/selection_provider.dart';
import 'package:nololordos/features/Team_Selection_screen/presentation/widgets/custom_Button.dart';
import 'package:nololordos/features/Team_Selection_screen/presentation/widgets/custom_container.dart';
import 'package:nololordos/features/Team_Selection_screen/presentation/widgets/custom_selection_tile.dart';

class TeamSelectionScreen extends StatelessWidget {
  const TeamSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    return Scaffold(
      body: Padding(
        padding: AppPadding.screenHorizontal,
        child: Column(
          children: [
            SizedBox(height: 90.h),
            Image.asset(AppImages.mainLogoWhite, width: 162.w, height: 31.h),
            SizedBox(height: 25.h),
            CustomContainer(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Consumer(
                  builder: (context, ref, _) {
                    final isSelected = ref.watch(selectionProvider);
                    return Column(
                      children: [
                        SizedBox(height: 55.h),
                        Text(
                          "Team Selection",
                          style: style.headlineLarge!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.onPrimary,
                          ),
                        ),
                        SizedBox(height: 35.h),
                        CustomSelectionTile(
                          title: 'AEK Athens',
                          logo: AppImages.teamAek,
                          onTap: () {
                            ref.read(selectionProvider.notifier).state =
                                'AEK Athens';
                          },
                          isSelected: isSelected == "AEK Athens",
                        ),
                        SizedBox(height: 20.h),

                        CustomSelectionTile(
                          title: 'Panathinaikos',
                          logo: AppImages.teamoenetik,
                          onTap: () {
                            ref.read(selectionProvider.notifier).state =
                                "Panathinaikos";
                          },
                          isSelected: isSelected == "Panathinaikos",
                        ),
                        Spacer(),
                        CustomButton(title: 'Next', onTap: () {}),
                        SizedBox(height: 25.h),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
