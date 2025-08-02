import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(decoration: BoxDecoration(shape: BoxShape.circle),
    child:Icon(Icons.check) ,
    );
  }
}
