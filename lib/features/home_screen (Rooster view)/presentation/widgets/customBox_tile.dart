import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nololordos/features/match_day_screen/presentation/widgets/inputdecoration.dart';

class CustomboxTile extends StatelessWidget {
  final String value;
  final Function(String) onChanged;

  const CustomboxTile({super.key,
    required this.value,
    required this.onChanged,});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 4.w, right: 4.w, bottom: 4.h, ),
     height:50.h,
     width: 62.w,
     
      child: TextFormField(
        initialValue: value,
        decoration: customInputDecoration(),
      ),
    );
  }
}