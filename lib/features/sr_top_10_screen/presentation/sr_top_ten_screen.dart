import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nololordos/features/sr_top_10_screen/presentation/widgets/banner_container.dart';

class SrTopTenScreen extends StatelessWidget {
  const SrTopTenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 55.h,),
          Align(
            alignment: Alignment.center,
            child: BannerContainer()),
        ],
      ),
    );
  }
}