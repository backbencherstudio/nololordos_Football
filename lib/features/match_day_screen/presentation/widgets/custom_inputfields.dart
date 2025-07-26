import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nololordos/core/constant/icons.dart';
import 'package:nololordos/features/match_day_screen/presentation/widgets/custom_icon_buttons.dart';

class CustomInputfields extends StatefulWidget {
  const CustomInputfields({super.key});

  @override
  State<CustomInputfields> createState() => _CustomInputfieldsState();
}

class _CustomInputfieldsState extends State<CustomInputfields> {
  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Match Day",
              style: style.headlineLarge!.copyWith(
                fontSize: 28.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 15.w),
            SvgPicture.asset(AppIcons.isolationIcon),
            Spacer(),
            CustomIconButtons(onTap: () {}, icon: AppIcons.transactionIcon),
          ],
        ),
        SizedBox(height: 25.h),
        Text(
          "League Name",
          style: style.bodyMedium!.copyWith(fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8.h),
        TextFormField(),
        SizedBox(height: 19.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Match",
                      style: style.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextFormField(),
                ],
              ),
            ),
            SizedBox(width: 8.h),
            SizedBox(
              height: 40.h,
              child: Center(
                child: Text(
                  "VS",
                  style: style.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    "",
                    style: style.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextFormField(),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 19.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Score",
                      style: style.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextFormField(),
                ],
              ),
            ),
            SizedBox(width: 8.h),
            SizedBox(
              height: 40.h,
              child: Center(
                child: Text(
                  "VS",
                  style: style.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    "",
                    style: style.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextFormField(),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 19.h),

        Text(
          "Date",
          style: style.bodyMedium!.copyWith(fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8.h),

        TextFormField(),
        SizedBox(height: 19.h),
      ],
    );
  }
}
