import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nololordos/core/constant/icons.dart';
import 'package:nololordos/core/theme/theme_extension/app_colors.dart';
import 'package:nololordos/features/import_export_screen/presentation/widgets/custom_buttons.dart';
import '../../Riverpod/additional_provider.dart';

void alertDialogueBox(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      final style = Theme.of(context).textTheme;

      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Container(
          padding: EdgeInsets.all(20),
          width: 321.w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 20.w),
                  SvgPicture.asset(AppIcons.ratingsIcon),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(AppIcons.xIcon),
                  ),
                ],
              ),
              SizedBox(height: 30.h),

              // Show only the TR value
              Consumer(
                builder: (context, ref, _) {
                  final strList = ref.watch(strProvider);

                  if (strList.isEmpty) {
                    return Text(
                      "No matches recorded yet",
                      style: style.bodyMedium!.copyWith(
                        color: AppColors.onPrimary,
                      ),
                    );
                  }

                  // Only show the latest TR value after submission
                  final lastMatchTR = strList.isNotEmpty ? strList.last : 0.0;

                  return Text(
                    lastMatchTR.toStringAsFixed(2),
                    style: style.bodyMedium!.copyWith(
                      color: AppColors.onPrimary,
                    ),
                  );
                },
              ),

              Text(
                "Team Ratings",
                style: style.bodyMedium!.copyWith(color: AppColors.onPrimary),
              ),
              SizedBox(height: 24.h),

              CustomButtons(
                hieght: 60.h,
                color: AppColors.buttonAvtiveColor,
                title: 'Submit',
                icon: '',
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
