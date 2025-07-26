import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nololordos/core/constant/padding.dart';
import 'package:nololordos/features/match_day_screen/presentation/widgets/custom_inputfields.dart';
import 'package:nololordos/features/match_day_screen/presentation/widgets/custom_score_inputBox.dart';

class MatchdayScreen extends StatelessWidget {
  const MatchdayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final style = Theme.of(context).textTheme;

    return Scaffold(
      body: Padding(
        padding: AppPadding.screenHorizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 55.h),
            CustomInputfields(),
            SizedBox(height: 24.h,),
            CustomScoreInputbox(),
          ],
        ),
      ),
    );
  }
}
