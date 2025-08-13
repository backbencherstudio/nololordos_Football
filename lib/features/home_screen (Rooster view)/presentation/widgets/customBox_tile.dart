import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nololordos/features/match_day_screen/presentation/widgets/inputdecoration.dart';

class CustomboxTile extends StatefulWidget {
  final String value;
  final Function(String) onChanged;

  const CustomboxTile({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<CustomboxTile> createState() => _CustomboxTileState();
}

class _CustomboxTileState extends State<CustomboxTile> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(covariant CustomboxTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update the text if value changed from outside
    if (oldWidget.value != widget.value) {
      _controller.text = widget.value;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 4.w, right: 4.w, bottom: 4.h),
      height: 49.8.h,
      width: 62.w,
      child: TextFormField(
        controller: _controller,
        decoration: customInputDecoration(),
        keyboardType: TextInputType.number,
        onChanged: widget.onChanged,
      ),
    );
  }
}
