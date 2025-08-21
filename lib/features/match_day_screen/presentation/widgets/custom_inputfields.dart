import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nololordos/core/constant/icons.dart';
import 'package:nololordos/core/routes/route_name.dart';
import 'package:nololordos/core/theme/theme_extension/app_colors.dart';
import 'package:nololordos/features/Team_Selection_screen/Riverpod/selection_provider.dart';

import 'custom_icon_buttons.dart';

// Provider for selected date
final selectedMatchDateProvider = StateProvider<DateTime?>((ref) => null);

class CustomInputfields extends ConsumerStatefulWidget {
  final TextEditingController matchName;
  final TextEditingController teamOne;
  final TextEditingController teamTwo;
  final TextEditingController scoreOne;
  final TextEditingController scoreTwo;

  const CustomInputfields({
    super.key,
    required this.matchName,
    required this.teamOne,
    required this.teamTwo,
    required this.scoreOne,
    required this.scoreTwo,
  });

  @override
  ConsumerState<CustomInputfields> createState() => _CustomInputfieldsState();
}

class _CustomInputfieldsState extends ConsumerState<CustomInputfields> {
  late TextEditingController matchName;
  late TextEditingController teamOne;
  late TextEditingController teamTwo;
  late TextEditingController scoreOne;
  late TextEditingController scoreTwo;
  late TextEditingController dateController;

  @override
  void initState() {
    super.initState();
    matchName = widget.matchName;
    teamOne = widget.teamOne;
    teamTwo = widget.teamTwo;
    scoreOne = widget.scoreOne;
    scoreTwo = widget.scoreTwo;
    dateController = TextEditingController();
  }

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

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
              style: style.headlineLarge?.copyWith(
                fontSize: 28.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 15.w),
            SvgPicture.asset(AppIcons.isolationIcon),
            const Spacer(),
            CustomIconButtons(
              onTap: () {
                context.push(RouteName.historyScreen);
              },
              icon: AppIcons.transactionIcon,
            ),
          ],
        ),
        SizedBox(height: 25.h),
        Text(
          "League Name",
          style: style.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: matchName,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter league name',
          ),
          validator: (value) =>
          (value == null || value.trim().isEmpty) ? 'Required' : null,
        ),
        SizedBox(height: 19.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Consumer(
                builder: (context, ref, _) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Match",
                          style: style.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      TextFormField(
                        controller: teamOne,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Team One',
                        ),
                        validator: (value) =>
                        (value == null || value.trim().isEmpty) ? 'Required' : null,
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(width: 8.h),
            SizedBox(
              height: 40.h,
              child: Center(
                child: Text(
                  "VS",
                  style: style.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SizedBox(width: 8.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),
                  TextFormField(
                    controller: teamTwo,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Team Two',
                    ),
                    validator: (value) =>
                    (value == null || value.trim().isEmpty) ? 'Required' : null,
                  ),
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
                      style: style.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextFormField(
                    controller: scoreOne,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Score One',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) return 'Required';
                      final n = int.tryParse(value.trim());
                      if (n == null || n < 0) return 'Enter valid non-negative number';
                      return null;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.h),
            SizedBox(
              height: 40.h,
              child: Center(
                child: Text(
                  "VS",
                  style: style.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SizedBox(width: 8.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),
                  TextFormField(
                    controller: scoreTwo,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Score Two',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) return 'Required';
                      final n = int.tryParse(value.trim());
                      if (n == null || n < 0) return 'Enter valid non-negative number';
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 19.h),
        Text(
          "Date",
          style: style.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: dateController,
          readOnly: true,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: 'Select date',
            suffixIcon: Padding(
              padding: const EdgeInsets.all(14.0),
              child: SvgPicture.asset(
                AppIcons.calendarIcon,
                height: 16,
                width: 16,
                color: AppColors.deActiveTextColor,
              ),
            ),
          ),
          onTap: () async {
            final selectedDate = ref.watch(selectedMatchDateProvider);
            final DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: selectedDate ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: ThemeData.dark().copyWith(
                    primaryColor: AppColors.primaryContainer,
                    highlightColor: AppColors.primary,
                    buttonTheme: const ButtonThemeData(
                      textTheme: ButtonTextTheme.primary,
                    ),
                    colorScheme: const ColorScheme.dark().copyWith(
                      primary: AppColors.buttonAvtiveColor,
                      onPrimary: AppColors.onPrimary,
                      surface: AppColors.primaryContainer,
                      onSurface: AppColors.onPrimary,
                      secondary: AppColors.buttonAvtiveColor,
                      background: AppColors.primaryContainer,
                    ),
                  ),
                  child: child!,
                );
              },
            );

            if (pickedDate != null) {
              ref.read(selectedMatchDateProvider.notifier).state = pickedDate;
              dateController.text =
              "${pickedDate.day.toString().padLeft(2, '0')}-"
                  "${pickedDate.month.toString().padLeft(2, '0')}-"
                  "${pickedDate.year}";
            }
          },
          validator: (value) =>
          (value == null || value.trim().isEmpty) ? 'Date is required' : null,
        ),
        SizedBox(height: 19.h),
      ],
    );
  }
}
