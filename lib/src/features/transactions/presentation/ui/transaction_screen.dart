import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:repore_agent/lib.dart';

class TransactionScreen extends ConsumerWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(getAllTransactionProvider);
    final balanceVm = ref.watch(getUserBalanceProvider);

    return Scaffold(
      backgroundColor: AppColors.primarybgColor,
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
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
      body: Padding(
        padding:
            EdgeInsets.only(top: 30.h, left: 20.w, right: 20.w, bottom: 30.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total',
              style: AppTextStyle.satoshiFontText(
                context,
                AppColors.headerTextColor2,
                16.sp,
              ),
            ),
            Text(
              formatCurrency("${balanceVm.asData?.value.data ?? 0}"),
              style: AppTextStyle.satoshiFontText(
                context,
                AppColors.primaryTextColor,
                28.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            YBox(10),
            AppButton(
              bgColor: AppColors.whiteColor,
              borderColor: AppColors.homeContainerBorderColor,
              textColor: AppColors.primaryTextColor,
              buttonText: 'Withdraw',
              onPressed: () {
                context.pushNamed(AppRoute.withdrawal.name);
              },
            ),
            YBox(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Transactions',
                  style: AppTextStyle.satoshiFontText(
                    context,
                    AppColors.primaryTextColor,
                    16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                ///TODO: Hide this if transaction list is empty
                GestureDetector(
                  onTap: () {
                    ref.invalidate(getAllTransactionProvider);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ViewAllTransactionScreen();
                    }));
                  },
                  child: Text(
                    'View all',
                    style: AppTextStyle.satoshiFontText(
                      context,
                      AppColors.onboardingDotColor,
                      14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            YBox(10),
            vm.when(
              data: (value) {
                return value.data.isEmpty
                    ?
                    // EMPTY STATE
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 300.h,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            width: 1.w,
                            color: AppColors.notificationReadCardColor,
                          ),
                        ),
                        child: const EmptyNotificationStateWidget(
                          message: '',
                          title: 'No transactions yet',
                          height: 0,
                        ),
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        // height: 400.h,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            width: 1.w,
                            color: AppColors.notificationReadCardColor,
                          ),
                        ),
                        child: ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.only(
                              top: 30.h, left: 15.w, right: 15.w, bottom: 30.h),
                          itemCount:
                              value.data.length < 4 ? value.data.length : 4,
                          separatorBuilder: (context, index) => YBox(20.h),
                          itemBuilder: (context, index) {
                            final item = value.data[index];
                            String formattedDate = DateFormat("dd MMM, yyyy")
                                .format(item.createdAt);
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
                                    XBox(10.w),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                        ),
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
            ),
          ],
        ),
      ),
    );
  }
}

class Transactions {
  final String title;
  final String amount;
  final String date;
  final String imgUrl;

  Transactions({
    required this.title,
    required this.amount,
    required this.date,
    required this.imgUrl,
  });
}
