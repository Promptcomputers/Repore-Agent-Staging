import 'package:flutter/material.dart';
import 'package:repore_agent/src/components/utils/toast/src/animated_snack_bar.dart';
import 'package:repore_agent/src/components/utils/toast/src/types.dart';

showSuccessToast(BuildContext context, String massage) {
  AnimatedSnackBar.material(
    massage,
    type: AnimatedSnackBarType.success,
    //Change to top
    mobileSnackBarPosition: MobileSnackBarPosition.top,
  ).show(context);
}

showErrorToast(BuildContext context, String massage) {
  AnimatedSnackBar.material(
    massage,
    type: AnimatedSnackBarType.error,
    mobileSnackBarPosition: MobileSnackBarPosition.top,
  ).show(context);
}
