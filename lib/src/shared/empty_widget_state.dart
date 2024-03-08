import 'package:flutter/material.dart';
import 'package:repore_agent/lib.dart';

class EmptyNotificationStateWidget extends StatelessWidget {
  final String? message;
  final String? title;
  final double? height;
  const EmptyNotificationStateWidget({
    this.message,
    this.title,
    this.height,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(AppImages.notificationEmptyImage),
        YBox(height ?? 10.h),
        Text(
          title ?? 'Nothing to see here',
          style: AppTextStyle.josefinSansFont(
            context,
            AppColors.notificationHeaderColor,
            20.sp,
          ),
        ),
        YBox(height ?? 10.h),
        Text(
          message ?? 'There are no notifications here yet',
          style: AppTextStyle.satoshiFontText(
            context,
            AppColors.headerTextColor1,
            14.sp,
          ),
        ),
      ],
    );
  }
}
