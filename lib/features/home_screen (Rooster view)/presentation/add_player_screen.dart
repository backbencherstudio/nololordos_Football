// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nololordos/core/constant/icons.dart';
import 'package:nololordos/core/constant/padding.dart';
import 'package:nololordos/core/routes/route_name.dart';
import 'package:nololordos/core/theme/theme_extension/app_colors.dart';
import 'package:nololordos/features/Team_Selection_screen/Riverpod/selection_provider.dart';
import 'package:nololordos/features/Team_Selection_screen/presentation/widgets/custom_container.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/Riverpod/catagoryProvider.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/Riverpod/playerProvider.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/presentation/widgets/dropdown.dart';
import 'package:nololordos/features/import_export_screen/presentation/widgets/custom_buttons.dart';

class AddPlayerScreen extends ConsumerStatefulWidget {
  const AddPlayerScreen({super.key});

  @override
  _AddPlayerScreenState createState() => _AddPlayerScreenState();
}

class _AddPlayerScreenState extends ConsumerState<AddPlayerScreen> {
  final GlobalKey _positionKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    

    final selectedPosition = ref.watch(catagoryProvider);
    final selectedTeams = ref.watch(selectionProvider);
      final TextEditingController positionController = TextEditingController(
      text: selectedPosition.isEmpty ? 'Select Position' : selectedPosition,
    );
    final TextEditingController name = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: AppPadding.screenHorizontal,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 115.h),
              CustomContainer(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 25,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              
                              context.go(RouteName.roosterViewScreen);
                            },
                            child: SvgPicture.asset(AppIcons.xIcon)),
                        ),
                        Text(
                          "Add Player",
                          style: style.headlineLarge!.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 32.h),
          
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Player Name"),
                        ),
                        SizedBox(height: 8.h),
                        TextFormField(
                          controller: name,
                          decoration: InputDecoration(
                            fillColor: AppColors.fillcolorTwo,
                          ),
                        ),
                        SizedBox(height: 18.h),
          
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Position"),
                        ),
                        SizedBox(height: 8.h),
                        TextFormField(
                          readOnly: true,
                        
                          controller:positionController,
          
                          decoration: InputDecoration(
                            fillColor: AppColors.fillcolorTwo,
                            suffixIcon: Padding(
                              padding: EdgeInsets.only(
                                left: 5.w,
                                right: 20.w,
                                top: 15.h,
                                bottom: 15.h,
                              ),
                              child: GestureDetector(
                                key: _positionKey,
          
                                onTap: () {
                                  showNumberMenu(
                                    context,
                                    _positionKey,
                                    ref,
                                    catagoryProvider,
                                  );
                                },
                                child: SizedBox(
                                  height: 20.h,
                                  width: 20.w,
                                  child: SvgPicture.asset(AppIcons.dropDownIcon),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        CustomButtons(
                          title: "Add Player",
                        
                          icon: AppIcons.addIcon ,
                          onTap: () {
                            debugPrint("\n\n\ teams== >$selectedTeams\n\n\n");
 ref.read(playersProvider.notifier).addPlayer(
    selectedTeams ,           
    selectedPosition,              
    name.text.trim(), 

  );                                Navigator.pop(context);
                          },
                          hieght: 60.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
