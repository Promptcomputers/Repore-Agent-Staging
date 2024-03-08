import 'package:flutter/material.dart';
import 'package:repore_agent/lib.dart';

class FormLabel extends StatelessWidget {
  final String text;
  const FormLabel({
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyle.satoshiFontText(
        context,
        AppColors.primaryTextColor,
        14.sp,
      ),
    );
  }
}
