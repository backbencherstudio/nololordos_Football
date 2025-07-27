import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRowInfo extends StatelessWidget {
  final String icon;
  final String title;
  final String score; 
  final double? height;
  final double? width;
  const CustomRowInfo({super.key,
  required this.title,
  required this.icon,
  required this.score,
   this.height,
   this.width
  });

  @override
  Widget build(BuildContext context) {
            final style = Theme.of(context).textTheme;

    return Row(
      children: [
        Image.asset(icon,
        height: height?? 16.h,
        width:width?? 16.w,
        ),
        SizedBox(width: 8.w,),
        Text(title,
        style: style.bodyMedium!.copyWith(
          fontWeight: FontWeight.w500,
        ),
        ),
        Spacer(),
        Text(score,
         style: style.bodyMedium!.copyWith(
          fontWeight: FontWeight.w500,
        ),
        ),
      ],
    );
  }
}