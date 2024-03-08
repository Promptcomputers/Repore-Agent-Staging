import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:repore_agent/lib.dart';

class LoadingSpinner extends StatelessWidget {
  final Widget child;
  final String? loadingText;
  // final double? height;
  const LoadingSpinner(
      {required this.child,
      this.loadingText,
      // this.height,
      super.key});

  ///TODO: Check foodcourt loading for creating order
  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayColor: AppColors.primaryTextColor.withOpacity(1.0),
      overlayOpacity: 1.0,
      overlayWidget: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 230.w,
              alignment: Alignment.center,
              padding: EdgeInsets.only(
                  top: 30.h, left: 20.w, right: 20.w, bottom: 30.h),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                children: [
                  //TODO: The animation is not allowing the overlay to show
                  // AvatarGlow(
                  //   endRadius: 20.0,
                  //   glowColor: AppColors.buttonBgColor2,
                  //   duration: Duration(milliseconds: 2000),
                  //   child: Image.asset(AppIcon.logoMark),
                  // ),
                  Image.asset(AppIcon.logoMark),
                  YBox(5.h),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                    child: Text(
                      loadingText ?? 'Currently working on your request',
                      style: AppTextStyle.satoshiFontText(
                        context,
                        AppColors.headerTextColor1,
                        16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // overlayWidget: const Center(
      //   child: CircularProgressIndicator(
      //     color: AppColors.primaryColor,
      //   ),
      // ),
      child: child,
    );
  }
}
