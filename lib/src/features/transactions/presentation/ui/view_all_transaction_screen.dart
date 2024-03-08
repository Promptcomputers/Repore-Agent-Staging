import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:repore_agent/lib.dart';

class ViewAllTransactionScreen extends ConsumerWidget {
  const ViewAllTransactionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(getAllTransactionProvider);
    return Scaffold(
      backgroundColor: AppColors.primarybgColor,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Image.asset(
            AppIcon.backArrowIcon2,
          ),
        ),
        title: Text(
          'Transactions',
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
          child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(1.r),
                border: Border.all(
                  width: 1.w,
                  color: AppColors.notificationReadCardColor,
                ),
              ),
              child: vm.when(
                data: (value) {
                  return ListView.separated(
                    padding: EdgeInsets.only(
                        top: 15.h, left: 15.w, right: 15.w, bottom: 15.h),
                    itemCount: value.data.length,
                    separatorBuilder: (context, index) => YBox(20.h),
                    itemBuilder: (context, index) {
                      final item = value.data[index];

                      String formattedDate =
                          DateFormat("dd MMM, yyyy").format(item.createdAt);
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                item.type == 'CREDIT'
                                    ? AppIcon.creditIcon
                                    : AppIcon.debitIcon,
                                width: 40.w,
                                height: 40.h,
                              ),
                              XBox(10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.type == 'CREDIT'
                                        ? 'Deposit'
                                        : 'Withdrawal',
                                    style: AppTextStyle.satoshiFontText(
                                      context,
                                      AppColors.headerTextColor2,
                                      16.sp,
                                    ),
                                  ),
                                  Text(
                                    formattedDate,
                                    style: AppTextStyle.satoshiFontText(
                                      context,
                                      AppColors.headerTextColor2,
                                      14.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Text(
                            formatCurrency(item.amount),
                            style: AppTextStyle.satoshiFontText(
                              context,
                              AppColors.headerTextColor2,
                              16.sp,
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                error: (error, stackTrace) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          error.toString(),
                          // 'An Error occurred',
                          style: AppTextStyle.satoshiFontText(
                            context,
                            AppColors.buttonBgColor,
                            14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          ref.invalidate(getAllTransactionProvider);
                        },
                        child: Icon(Icons.refresh),
                      ),
                    ],
                  ),
                ),
                loading: () => const AppCircularLoading(),
              )),
        ),
      ),
    );
  }
}
