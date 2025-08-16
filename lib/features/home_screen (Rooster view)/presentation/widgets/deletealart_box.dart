import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nololordos/core/theme/theme_extension/app_colors.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/Riverpod/delete_provider_selection.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/Riverpod/isDeleteProvider.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/Riverpod/playerProvider.dart';
import 'package:nololordos/features/import_export_screen/presentation/widgets/custom_buttons.dart';

void deleteAlertDialogueBox(BuildContext context) {
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
             Text("Are you sure you\nwant to Delete ",
             textAlign: TextAlign.center,
             style: style.bodyLarge!.copyWith(
              color: AppColors.onPrimary
             ),
             ),
              SizedBox(height: 21.h,),
              
                                SizedBox(height: 24.h,),

                  Consumer(
                    builder: (context, ref,_) {
                      return CustomButtons(
                        hieght: 60.h,
                        color: AppColors.buttonAvtiveColor,
                        title: 'Yes',
                        icon: '',
                        onTap: () {
                                // Handle delete logic
                                  final deleteIds = ref.read(deletePlayerIdListProvider);
                                  ref.read(playersProvider.notifier).deletePlayersByIds(deleteIds);
                      
                                  ref.read(isDeleteProvider.notifier).state = false;
                                  ref.read(deletePlayerIdListProvider.notifier).state = [];
                      
                                  debugPrint("Deleted");
                                  Navigator.pop(context);
                        },
                      );
                    }
                  ),
SizedBox(height: 11.h,),
                   CustomButtons(
                    hieght: 60.h,
                    color: AppColors.primaryContainer,
                    title: 'No',
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
