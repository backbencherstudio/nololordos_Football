import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nololordos/core/theme/theme_extension/app_colors.dart';

class AppInputDecorationTheme {
  static InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(horizontal:20.w, vertical:9.h ),
    filled: true,
    fillColor: AppColors.fillcolor,
    hintStyle: GoogleFonts.roboto(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: Color(0xff777980),
    ),
    labelStyle: GoogleFonts.poppins(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: Color(0xff777980),
    ),
    prefixIconColor: Color(0xffffffff),
    suffixIconColor: Color(0xffffffff),
    errorStyle: GoogleFonts.poppins(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: Colors.red,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.r),
      borderSide: BorderSide.none
    ),
    enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.r),
                  borderSide: BorderSide.none


    ),
    focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.r),
                        borderSide: BorderSide.none


    ),
    disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.r),
                        borderSide: BorderSide.none


    ),
    errorBorder:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.r),
                        borderSide: BorderSide.none


    ),
  );
}
