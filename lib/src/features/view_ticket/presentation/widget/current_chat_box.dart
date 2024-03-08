import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:repore_agent/lib.dart';

class CurrentUserChatBox extends StatelessWidget {
  final String msg;
  final String dateCreated;
  final String userName;
  final String attachment;
  final String type;
  final String invoiceId;
  final num invoiceTotal;
  final String subject;
  final String invoiceType;

  const CurrentUserChatBox({
    required this.msg,
    required this.dateCreated,
    required this.userName,
    required this.attachment,
    required this.type,
    required this.invoiceId,
    required this.invoiceTotal,
    required this.subject,
    required this.invoiceType,
    Key? key,
  }) : super(key: key);

  // 64d40d8094a8ff5adfca7ce5
  // 1691615570112

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (type == "INVOICE") ...[
          GestureDetector(
            onTap: () {
              context.pushNamed(
                AppRoute.invoicePreviewScreen.name,
                queryParams: {
                  'invoiceId': invoiceId,
                  'invoiceRef': '',
                  'subject': subject
                },
              );
            },
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.5),
              // BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
              padding: EdgeInsets.only(
                  left: 12.w, right: 12.w, top: 10.h, bottom: 10.h),
              decoration: BoxDecoration(
                color: AppColors.buttonBgColor2,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.r),
                  topRight: Radius.circular(20.r),
                  bottomLeft: Radius.circular(20.r),
                  bottomRight: Radius.circular(20.r),
                ),
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      dateCreated,
                      style: AppTextStyle.satoshiFontText(
                        context,
                        AppColors.primaryTextColor2,
                        12.sp,
                      ),
                    ),
                  ),
                  YBox(3),
                  Container(
                    padding: EdgeInsets.only(
                        left: 10.w, right: 10.w, top: 15.h, bottom: 15.h),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          invoiceType == "SERVICE"
                              ? AppIcon.invoiceServiceIcon
                              : AppIcon.invoiceAcquistionIcon,
                          width: 25.w,
                          height: 25.h,
                        ),
                        XBox(4),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Text(
                                subject,
                                style: AppTextStyle.satoshiFontText(
                                  context,
                                  AppColors.buttonBgColor2,
                                  16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              invoiceTotal == 0
                                  ? '0'
                                  : formatCurrency(invoiceTotal.toString()),
                              style: AppTextStyle.satoshiFontText(
                                context,
                                AppColors.headerTextColor1,
                                12.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ] else ...[
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.5,
            ),
            padding: EdgeInsets.only(
                left: attachment.isNotEmpty ? 8.w : 12.w,
                right: attachment.isNotEmpty ? 8.w : 12.w,
                top: 10.h,
                bottom: 10.h),
            decoration: BoxDecoration(
              color: AppColors.buttonBgColor2,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(20.r),
                bottomLeft: Radius.circular(20.r),
                bottomRight: Radius.circular(20.r),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      capitalizeFirstLetter(userName),
                      style: AppTextStyle.satoshiFontText(
                        context,
                        AppColors.homeContainerBorderColor,
                        14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      dateCreated,
                      style: AppTextStyle.satoshiFontText(
                        context,
                        AppColors.textFormFieldBorderColor,
                        12.sp,
                      ),
                    ),
                  ],
                ),
                YBox(5),

                if (attachment.isNotEmpty) ...[
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        width: 3.w,
                        color: AppColors.primaryColor.withOpacity(0.4),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: CachedNetworkImage(
                        width: 140.w,
                        height: 130.h,
                        fit: BoxFit.cover,
                        imageUrl:
                            "https://storage-promptcomputers.s3.us-east-2.amazonaws.com/$attachment",
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress),
                        ),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
                YBox(attachment.isNotEmpty ? 5 : 0),
                if (msg.isNotEmpty) ...[
                  Text(
                    msg,
                    // 'Hello, let get to work, SO that if you will get bet ethebe ieu he  ejbsgjkbkdjh dfhihi S',
                    style: AppTextStyle.satoshiFontText(
                      context,
                      AppColors.homeContainerBorderColor,
                      12.sp,
                    ),
                    softWrap: true,
                  ),
                ],

                // Text(
                //   msg.isEmpty ? attachment : msg,
                //   // 'Hello, let get to work, SO that if you will get bet ethebe ieu he  ejbsgjkbkdjh dfhihi S',
                //   style: AppTextStyle.bodyText(
                //     context,
                //     AppColors.homeContainerBorderColor,
                //     12.sp,
                //   ),
                //   softWrap: true,
                // ),
                //
                // Text(
                //   msg.isEmpty ? '' : msg,
                //   // 'Hello, let get to work, SO that if you will get bet ethebe ieu he  ejbsgjkbkdjh dfhihi S',
                //   style: AppTextStyle.bodyText(
                //     context,
                //     AppColors.homeContainerBorderColor,
                //     12.sp,
                //   ),
                //   softWrap: true,
                // ),
              ],
            ),
          ),
        ],
        XBox(5),
        Container(
          width: 30.w,
          height: 30.h,
          decoration: BoxDecoration(
            color: AppColors.buttonBgColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Center(
            child: Text(
              getStringFirstLetter(userName.toUpperCase()),
              style: AppTextStyle.satoshiFontText(
                context,
                AppColors.buttonBgColor,
                14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
