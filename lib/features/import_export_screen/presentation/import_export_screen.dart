import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nololordos/core/constant/icons.dart';
import 'package:nololordos/core/constant/padding.dart';
import 'package:nololordos/core/theme/theme_extension/app_colors.dart';
import 'package:nololordos/features/Team_Selection_screen/presentation/widgets/custom_container.dart';
import 'package:nololordos/features/import_export_screen/presentation/widgets/custom_buttons.dart';
import 'package:nololordos/features/import_export_screen/presentation/widgets/custom_logo_container.dart';

class ImportExportScreen extends StatelessWidget {
  const ImportExportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    return Scaffold(
      body: Padding(
        padding: AppPadding.screenHorizontal,
        child: Column(
          children: [
            SizedBox(height: 90.h),
      
            CustomContainer(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  children: [
                    SizedBox(height: 45.h),
                    CustomLogoContainer(),
                    SizedBox(height: 24.h,),
                    Text(
                      "Import / Export",
                      style: style.headlineLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.onPrimary,
                      ),
                    ),
                    SizedBox(height: 35.h),
                    CustomButtons(title: 'Export JSON/CSV', icon: AppIcons.uploadIcon, onTap: () {  },),
                    SizedBox(height: 20.h),
                    CustomButtons(title: 'Import JSOW/CSV', icon: AppIcons.downloadIcon, onTap: () {  },),
                    SizedBox(height: 20.h),
                    CustomButtons(title: 'Export Logs', icon: AppIcons.bookDownloadIcon, onTap: () {  },),
                    SizedBox(height: 25.h),
                    
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
