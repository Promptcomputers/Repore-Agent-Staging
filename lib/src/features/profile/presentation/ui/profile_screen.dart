import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore_agent/lib.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userVm = ref.watch(getUserDetailsProvider);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.primarybgColor,
        appBar: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: Text(
            'Profile',
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
            padding: EdgeInsets.only(
                top: 50.h, left: 20.w, right: 20.w, bottom: 30.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 56.w,
                        height: 56.h,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Center(
                          child: Text(
                            '${getStringFirstLetter(capitalizeFirstLetter(userVm.asData?.value.data.firstname ?? ''))}${getStringFirstLetter(capitalizeFirstLetter(userVm.asData?.value.data.lastname ?? ''))}',
                            style: AppTextStyle.interFontText(
                              context,
                              AppColors.primaryColor,
                              16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    YBox(5),
                    Align(
                      alignment: Alignment.center,
                      //TODO: NUll value, tell golden to retunr last name
                      child: Text(
                        '${capitalizeFirstLetter(userVm.asData?.value.data.firstname ?? '')} ${capitalizeFirstLetter(userVm.asData?.value.data.lastname ?? '')}',
                        style: AppTextStyle.satoshiFontText(
                          context,
                          AppColors.primaryTextColor,
                          16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    YBox(5),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        capitalizeFirstLetter(
                            userVm.asData?.value.data.email ?? ''),
                        style: AppTextStyle.satoshiFontText(
                          context,
                          AppColors.primaryTextColor,
                          14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    YBox(40),
                    Container(
                      padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.r),
                          topRight: Radius.circular(16.r),
                        ),
                        border: Border.all(
                          width: 1.w,
                          color: AppColors.notificationReadCardColor,
                        ),
                      ),
                      child: Column(
                        children: [
                          // GestureDetector(
                          //   onTap: () {
                          //     context
                          //         .pushNamed(AppRoute.editProfileScreen.name);
                          //   },
                          //   child: Padding(
                          //     padding: EdgeInsets.only(left: 20.w),
                          //     child: Row(
                          //       children: [
                          //         Image.asset(AppIcon.editProfileIcon),
                          //         XBox(10.w),
                          //         Text(
                          //           'Edit Profile',
                          //           style: AppTextStyle.satoshiFontText(
                          //             context,
                          //             AppColors.headerTextColor1,
                          //             14.sp,
                          //             fontWeight: FontWeight.w500,
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          // Divider(height: 35.h),
                          GestureDetector(
                            onTap: () {
                              context.pushNamed(
                                  AppRoute.changePasswordScreen.name);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(left: 20.w),
                              child: Row(
                                children: [
                                  Image.asset(AppIcon.securityIcon),
                                  XBox(10),
                                  Text(
                                    'Change password',
                                    style: AppTextStyle.satoshiFontText(
                                      context,
                                      AppColors.headerTextColor1,
                                      14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(height: 35.h),
                          GestureDetector(
                            onTap: () {
                              context
                                  .pushNamed(AppRoute.bankDetailsScreen.name);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(left: 20.w),
                              child: Row(
                                children: [
                                  Image.asset(AppIcon.cardIcon),
                                  XBox(10),
                                  Text(
                                    'Bank details',
                                    style: AppTextStyle.satoshiFontText(
                                      context,
                                      AppColors.headerTextColor1,
                                      14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    context.pushReplacementNamed(
                      AppRoute.autoLogin.name,
                      queryParams: {
                        'email': PreferenceManager.email,
                        'firstName': PreferenceManager.firstName,
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Log out',
                        style: AppTextStyle.satoshiFontText(
                          context,
                          AppColors.redColor3,
                          14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      XBox(3),
                      Image.asset(
                        AppIcon.logOutIcon2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
