import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore_agent/lib.dart';

class ViewSingleTransactionScreen extends ConsumerWidget {
  const ViewSingleTransactionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.primarybgColor,
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text(
          'Receipt',
          style: AppTextStyle.josefinSansFont(
            context,
            AppColors.homeContainerBorderColor,
            20.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
        elevation: 0.0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.primaryColor, // <-- SEE HERE
          statusBarIconBrightness:
              Brightness.light, //<-- For Android SEE HERE (dark icons)
          statusBarBrightness:
              Brightness.dark, //<-- For iOS SEE HERE (dark icons)
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 30.h),
          child: Column(
            children: [
              Image.asset(AppIcon.credit),
              YBox(20),
              Text(
                formatCurrency("500"),
                // formatCurrency("${balanceVm.asData?.value.data ?? 0}"),
                style: AppTextStyle.satoshiFontText(
                  context,
                  AppColors.primaryTextColor,
                  28.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              YBox(2),
              Text(
                'Deposit',
                style: AppTextStyle.satoshiFontText(
                  context,
                  AppColors.headerTextColor2,
                  14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              YBox(40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ticket',
                    style: AppTextStyle.satoshiFontText(
                      context,
                      AppColors.headerTextColor2,
                      14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'Fix pipes',
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
        ),
      ),
    );
  }
}
