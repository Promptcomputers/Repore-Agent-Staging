import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:repore_agent/lib.dart';
import 'package:repore_agent/src/features/ticket/presentation/widget/ticket_tab_bar.dart';

class TicketScreen extends ConsumerStatefulWidget {
  const TicketScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TicketScreenState();
}

class _TicketScreenState extends ConsumerState<TicketScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final _controller = TextEditingController();
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    final ticketVm = ref.watch(searchTicketProvider);
    final vm = ref.watch(getUserDetailsProvider);

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(searchTicketProvider);
      },
      child: Scaffold(
        key: _key,
        backgroundColor: AppColors.primarybgColor,
        appBar: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: Text(
            'Home',
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

        ///TODO: To fix, rewrite the logic, after loading the ticket if user isnot verifued show complete profile straight
        body: (vm.asData?.value.data.isAddressComplete == false) ||
                (vm.asData?.value.data.isPinProvided == false) ||
                (vm.asData?.value.data.stripeCustomerId == '') ||
                (vm.asData?.value.data.hasPasswordChanged == false)
            ? Padding(
                padding: EdgeInsets.only(top: 30.h, left: 20.w, right: 20.w),
                child: GestureDetector(
                  onTap: () {
                    context.pushNamed(AppRoute.completeProfileScreen.name);
                  },
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(
                            left: 20.w, right: 20.w, top: 20.h, bottom: 20.h),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: AppColors.homeContainerBorderColor,
                            width: 1.w,
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.pushNamed(
                                    AppRoute.completeProfileScreen.name);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Complete your profile',
                                    style: AppTextStyle.satoshiFontText(
                                      context,
                                      AppColors.headerTextColor1,
                                      14.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 14.sp,
                                    color: AppColors.notificationHeaderColor,
                                  ),
                                ],
                              ),
                            ),
                            YBox(5),
                            Text(
                              'Just a few more changes',
                              style: AppTextStyle.satoshiFontText(
                                context,
                                AppColors.headerTextColor2,
                                14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            YBox(5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                LinearPercentIndicator(
                                  percent: percentage(
                                      (vm.asData?.value.data.isPinProvided ==
                                          true),
                                      (vm.asData?.value.data
                                              .isAddressComplete ==
                                          true),
                                      (vm.asData?.value.data.isCardProvided ==
                                          true),
                                      (vm.asData?.value.data
                                              .hasPasswordChanged ==
                                          true)),
                                  // percent: 0.3,
                                  width: 250.w,
                                  lineHeight: 13.0,
                                  barRadius: Radius.circular(4.r),
                                  progressColor: AppColors.primaryColor2,
                                  backgroundColor:
                                      AppColors.notificationReadCardColor,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 0.0),
                                ),
                                Text(
                                  percentageText(
                                      (vm.asData?.value.data.isPinProvided ==
                                          true),
                                      (vm.asData?.value.data
                                              .isAddressComplete ==
                                          true),
                                      (vm.asData?.value.data.isCardProvided ==
                                          true),
                                      (vm.asData?.value.data
                                              .hasPasswordChanged ==
                                          true)),
                                  style: AppTextStyle.satoshiFontText(
                                    context,
                                    AppColors.primaryTextColor,
                                    14.sp,
                                    fontWeight: FontWeight.w500,
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
              )
            : ticketVm.when(
                // error: (error, stackTrace) => const SizedBox(),
                error: (error, stackTrace) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          // error.toString(),
                          'An Error occurred',
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
                          ref.invalidate(searchTicketProvider);
                        },
                        child: Icon(Icons.refresh),
                      ),
                    ],
                  ),
                ),
                loading: () => const AppCircularLoading(),
                data: (value) {
                  final data = value.data;
                  return data!.isEmpty
                      ? const Center(
                          child: EmptyNotificationStateWidget(
                            message:
                                'Hold on, you will soon be assigned tickets',
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(top: 20.h),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 20.w, right: 20.w),
                                child: AppTextField(
                                  controller: _controller,
                                  onChanged: (value) {
                                    if (_debounce?.isActive ?? false)
                                      _debounce!.cancel();
                                    _debounce = Timer(
                                      const Duration(seconds: 2),
                                      () {
                                        ///TODO: NOt wokring
                                        // Make your API request here using the text in the TextFormField
                                        ref
                                            .read(searchTicketProvider.notifier)
                                            .searchTicket(
                                                PreferenceManager.userId,
                                                _controller.text.trim());
                                      },
                                    );
                                  },
                                  filled: true,
                                  filledColor: AppColors.whiteColor,
                                  preffixIcon: const Icon(Icons.search),
                                  hintText: 'Search ID, ticket...',
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.r),
                                    borderSide: const BorderSide(
                                        color:
                                            AppColors.homeContainerBorderColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.r),
                                    borderSide: const BorderSide(
                                        color:
                                            AppColors.homeContainerBorderColor),
                                  ),
                                ),
                              ),
                              YBox(20),
                              Expanded(
                                child: TicketTabBar(
                                  data: data,
                                ),
                              ),
                            ],
                          ),
                        );
                },
              ),
      ),
    );
  }
}
