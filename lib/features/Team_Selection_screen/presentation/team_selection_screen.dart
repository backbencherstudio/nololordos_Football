import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nololordos/core/constant/padding.dart';
import 'package:nololordos/features/Team_Selection_screen/presentation/widgets/custom_container.dart';

class TeamSelectionScreen extends StatelessWidget {
  const TeamSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppPadding.screenHorizontal,
        child: Column(
          children: [
            SizedBox(height: 70.h),
            CustomContainer(child: Column(
              children: [
                Text("hello world")
              ],
            )),
          ],
        ),
      ),
    );
  }
}
