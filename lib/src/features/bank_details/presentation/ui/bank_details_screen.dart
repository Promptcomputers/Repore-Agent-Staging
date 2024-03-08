import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore_agent/lib.dart';

class BankDetailsScreen extends ConsumerWidget {
  const BankDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(getUserBankDetails);

    return Scaffold(
      backgroundColor: AppColors.primarybgColor,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () => context.pop(),
          // child: Icon(
          //   Icons.arrow_back_ios,
          //   color: AppColors.whiteColor,
          // )
          child: Image.asset(
            AppIcon.backArrowIcon2,
          ),
        ),
        title: Text(
          'Bank Details',
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
        child: vm.when(
          data: (value) {
            final dataF = value;
            return dataF.data.isEmpty
                ? Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const EmptyNotificationStateWidget(
                          title: 'No payment methods',
                          message: 'Add your active account ',
                        ),
                        YBox(20.h),
                        SizedBox(
                          width: 200.w,
                          child: AppButton(
                            buttonText: 'Add bank details',
                            onPressed: () {
                              context.pushNamed(
                                  AppRoute.addBankDetailsScreen.name);
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding:
                        EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: value.data.length,
                          separatorBuilder: (context, index) => YBox(20),
                          itemBuilder: (context, index) {
                            final item = value.data[index];
                            return BankDetailBuild(
                              item: item,
                            );
                          },
                        ),
                        AppButton(
                          buttonText: 'Add bank details',
                          onPressed: () {
                            context
                                .pushNamed(AppRoute.addBankDetailsScreen.name);
                          },
                        ),
                      ],
                    ),
                  );
          },
          loading: () => const AppCircularLoading(),
          error: (error, stackTrace) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  // error.toString(),
                  'An Error occurred',
                  style: AppTextStyle.satoshiFontText(
                    context,
                    AppColors.buttonBgColor,
                    14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    ref.invalidate(getUserBankDetails);
                  },
                  child: Icon(Icons.refresh),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
