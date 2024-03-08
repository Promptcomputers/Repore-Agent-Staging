import 'package:flutter/material.dart';
import 'package:repore_agent/lib.dart';

class TicketListBuild extends StatelessWidget {
  final String title;
  final String subtitle;
  final String status;
  final Color titleColor;
  final Color bgColor;
  final Color statusBgColor;
  final Color statusTextColor;
  final String type;
  final void Function()? onTap;
  const TicketListBuild({
    required this.title,
    required this.subtitle,
    required this.status,
    required this.titleColor,
    required this.bgColor,
    required this.statusBgColor,
    required this.statusTextColor,
    required this.type,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding:
            EdgeInsets.only(left: 20.w, right: 20.w, top: 30.h, bottom: 30.h),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              capitalizeFirstLetter(title),
              // '$title ($type)',
              style: AppTextStyle.satoshiFontText(
                context,
                titleColor,
                18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            YBox(5.h),
            Text(
              type,
              // subtitle,
              style: AppTextStyle.satoshiFontText(
                context,
                titleColor,
                12.sp,
              ),
            ),
            YBox(10.h),
            Container(
              padding: EdgeInsets.only(
                top: 4.h,
                bottom: 4.h,
              ),
              width: 90.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.r),
                color: statusBgColor,
              ),
              child: Center(
                child: Text(
                  status,
                  style: AppTextStyle.satoshiFontText(
                    context,
                    statusTextColor,
                    12.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
