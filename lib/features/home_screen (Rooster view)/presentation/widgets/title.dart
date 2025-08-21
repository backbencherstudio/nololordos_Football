import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Titles extends StatelessWidget {
  final String title;
  const Titles({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    return Column(
      children: [
        SizedBox(height: 11.h),
        Text(title, style: style.bodyLarge!.copyWith()),
        SizedBox(height: 15.h),
        Container(width: 62.w, height: 1.h, color: Colors.white),
        SizedBox(height: 2.h),
        SizedBox(height: 2.h),
      ],
    );
  }
}
