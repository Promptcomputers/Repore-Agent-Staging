import 'package:flutter/material.dart';
import 'package:repore_agent/lib.dart';

class NotificationListWidget extends StatelessWidget {
  // final String imgUrl;
  final String title;
  final String subtitle;
  final bool isRead;
  final void Function() onTap;
  const NotificationListWidget({
    Key? key,
    // required this.imgUrl,
    required this.title,
    required this.subtitle,
    required this.isRead,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            EdgeInsets.only(left: 20.w, right: 20.w, top: 25.h, bottom: 25.h),
        decoration: BoxDecoration(
          color: isRead == true
              ? AppColors.notificationReadColor
              : AppColors.notificationCardBorderColor.withOpacity(0.3),
          border: Border.all(
            width: 0.5.w,
            color: isRead == true
                ? AppColors.notificationReadColor
                : AppColors.notificationCardColor,
          ),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    // const SizedBox(),
                    Image.asset(AppImages.notificationMatchImage),
                    XBox(10),
                    Text(
                      title,
                      style: AppTextStyle.josefinSansFont(
                        context,
                        AppColors.primaryTextColor,
                        16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Row(
                    children: [
                      Text(
                        'View',
                        style: AppTextStyle.satoshiFontText(
                          context,
                          AppColors.headerTextColor1,
                          14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      XBox(2),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.headerTextColor1,
                          size: 15.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            YBox(5),
            Padding(
              padding: EdgeInsets.only(left: 30.w, right: 60.w),
              child: Text(
                subtitle,
                style: AppTextStyle.satoshiFontText(
                  context,
                  AppColors.headerTextColor1,
                  14.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
