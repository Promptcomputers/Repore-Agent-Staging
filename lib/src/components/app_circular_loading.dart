import 'package:flutter/material.dart';
import 'package:repore_agent/lib.dart';

class AppCircularLoading extends StatelessWidget {
  const AppCircularLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.buttonBgColor,
      ),
    );
  }
}
