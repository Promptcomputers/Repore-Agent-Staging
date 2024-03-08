import 'package:flutter/material.dart';
import 'package:repore_agent/lib.dart';

class CompleteProfileQuickActionWidget extends StatelessWidget {
  final void Function()? onTap;
  final String icon;
  final String title;
  final String subtitle;
  final bool isVerified;
  const CompleteProfileQuickActionWidget({
    required this.onTap,
    required this.icon,
    required this.subtitle,
    required this.title,
    required this.isVerified,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding:
            EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h, bottom: 20.h),
        decoration: BoxDecoration(
          color: isVerified
              ? AppColors.homeContainerBorderColor
              : AppColors.whiteColor,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isVerified
                ? AppColors.textFormFieldBorderColor
                : AppColors.homeContainerBorderColor,
            width: 0.5.w,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.homeContainerBorderColor,
              blurRadius: 3.r,
              // spreadRadius: 10.r,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 2.h),
                  child: isVerified
                      ? Image.asset(AppIcon.checkIcon)
                      : Image.asset(icon),
                ),
                XBox(5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyle.satoshiFontText(
                        context,
                        AppColors.primaryTextColor,
                        14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    // YBox(5.h),
                    Text(
                      subtitle,
                      style: AppTextStyle.satoshiFontText(
                        context,
                        AppColors.headerTextColor2,
                        14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            isVerified
                ? SizedBox()
                : Icon(
                    Icons.arrow_forward_ios,
                    size: 14.sp,
                    color: AppColors.notificationHeaderColor,
                  ),
          ],
        ),
      ),
    );
  }
}
