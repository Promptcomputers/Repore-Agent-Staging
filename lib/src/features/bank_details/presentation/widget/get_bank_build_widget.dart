import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:repore_agent/lib.dart';

class BankDetailBuild extends StatelessWidget {
  final GetBankDetailDatum item;
  const BankDetailBuild({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h, bottom: 20.h),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          width: 1.w,
          color: AppColors.homeContainerBorderColor,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: AppColors.notificationReadCardColor,
                child: Image.asset(AppIcon.walletIcon),
              ),
              XBox(20.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 210.w,
                    child: Text(
                      item.bankName,
                      style: AppTextStyle.interFontText(
                        context,
                        AppColors.notificationHeaderColor,
                        16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  YBox(5.h),
                  Text(
                    item.routingNo,
                    style: AppTextStyle.interFontText(
                      context,
                      AppColors.headerTextColor1,
                      14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                backgroundColor: Colors.transparent,
                barrierColor: AppColors.primaryColor.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.0.sp),
                  ),
                ),
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return CardOptionWidget(
                    item: item,
                  );
                },
              );
            },
            child: Icon(Icons.more_vert),
          )
        ],
      ),
    );
  }
}

class CardOptionWidget extends ConsumerWidget {
  final GetBankDetailDatum item;
  const CardOptionWidget({
    required this.item,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(deleteBankDetailProvider, (T, value) {
      if (value.hasValue) {
        showSuccessToast(context, 'Bank Detail Deleted Successfuly');
        context.loaderOverlay.hide();
        ref.invalidate(getUserBankDetails);
        context.pop();
      }
      if (value.hasError) {
        showErrorToast(context, value.error.toString());
        context.loaderOverlay.hide();
      }
    });
    return Container(
      padding: EdgeInsets.only(
        top: 30.w,
        right: 20.w,
        left: 20.w,
        bottom: 50.w,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFDFDFD),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Menu',
                style: AppTextStyle.satoshiFontText(
                  context,
                  AppColors.primaryTextColor,
                  16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: Icon(Icons.close),
              ),
            ],
          ),
          YBox(20),
          OptionsWidget(
            icon: Icons.check_circle_outline_outlined,
            text: 'Set as default',
            onTap: () {},
          ),
          YBox(20),
          OptionsWidget(
            icon: Icons.delete,
            text: 'Delete',
            onTap: () {
              log('i am ghere');
              ref
                  .read(deleteBankDetailProvider.notifier)
                  .deleteBankDetail(item.id);
            },
          ),
        ],
      ),
    );
  }
}

class OptionsWidget extends StatelessWidget {
  final IconData? icon;
  final String? text;
  final void Function()? onTap;
  const OptionsWidget({
    required this.icon,
    required this.text,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon ?? Icons.check_circle_outline_outlined,
            color: AppColors.headerTextColor2,
          ),
          XBox(10.w),
          Text(
            text ?? 'Set as default',
            style: AppTextStyle.satoshiFontText(
              context,
              AppColors.headerTextColor2,
              14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
