import 'package:flutter/material.dart';
import 'package:repore_agent/lib.dart';

class AppButton extends StatelessWidget {
  final String buttonText;
  final Color? bgColor;
  final Color? textColor;
  final Color? borderColor;
  final double? textSize;
  final bool isLoading;
  final void Function()? onPressed;
  final FontWeight? fontWeight;
  const AppButton(
      {required this.buttonText,
      this.bgColor,
      this.textColor,
      this.onPressed,
      this.textSize,
      this.borderColor,
      this.isLoading = false,
      this.fontWeight,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: borderColor ?? AppColors.primaryColor2,
              width: 1.w,
            ),
            borderRadius: BorderRadius.circular(16.r),
          ),
          padding: EdgeInsets.only(top: 16.h, bottom: 16.h),
          backgroundColor: bgColor ?? AppColors.primaryColor2,
        ),
        onPressed: onPressed ?? () {},
        child: isLoading
            ? CircularProgressIndicator.adaptive(
                backgroundColor: AppColors.whiteColor,
              )
            : Text(
                buttonText,
                style: AppTextStyle.satoshiFontText(
                  context,
                  textColor ?? AppColors.whiteColor,
                  textSize ?? 16.sp,
                  fontWeight: fontWeight ?? FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
      ),
    );
  }
}
