import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore_agent/lib.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class BottomNavBar extends ConsumerStatefulWidget {
  const BottomNavBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends ConsumerState<BottomNavBar> {
  AutoScrollController? scrollController;
  void _setScrollController(AutoScrollController controller) {
    scrollController = controller;
  }

  int pageIndex = 0;
  List<Widget> pageList = <Widget>[
    TicketScreen(),
    TransactionScreen(),
    NotificationScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageList[pageIndex],
      bottomNavigationBar: Container(
        height: 85.h,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              width: 1.w,
              color: AppColors.homeContainerBorderColor,
            ),
          ),
          // boxShadow: [
          //   BoxShadow(
          //     color: Color(0xFFE7E7E7),
          //     blurRadius: 25.0,
          //   )
          // ],
        ),
        child: ClipRRect(
          child: BottomNavigationBar(
            backgroundColor: AppColors.whiteColor,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.bottomNavBarTextColor,
            elevation: 20,
            unselectedLabelStyle: AppTextStyle.satoshiFontText(
              context,
              AppColors.primaryTextColor2,
              12.sp,
              fontWeight: FontWeight.w500,
            ),
            selectedLabelStyle: AppTextStyle.satoshiFontText(
              context,
              AppColors.bottomNavBarTextColor,
              12.sp,
              fontWeight: FontWeight.w700,
            ),
            currentIndex: pageIndex,
            onTap: (value) {
              // if (pageIndex == value) {
              //   if (value == 0) {
              //     scrollController?.animateTo(0.0,
              //         duration: const Duration(milliseconds: 400),
              //         curve: Curves.linear);
              //   }
              // }

              setState(() {
                pageIndex = value;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppIcon.ticketIcon,
                  width: 24.w,
                  height: 24.h,
                ),
                activeIcon: Image.asset(
                  AppIcon.ticketActiveIcon,
                  width: 24.w,
                  height: 24.h,
                  // color: AppColors.primaryColor,
                ),
                label: 'Ticket',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppIcon.ticketIcon,
                  width: 24.w,
                  height: 24.h,
                ),
                activeIcon: Image.asset(
                  AppIcon.ticketActiveIcon,
                  width: 24.w,
                  height: 24.h,
                  // color: AppColors.primaryColor,
                ),
                label: 'Transactions',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppIcon.notificationIcon,
                  width: 24.w,
                  height: 24.h,
                ),
                activeIcon: Image.asset(
                  AppIcon.notificationActiveIcon,
                  width: 24.w,
                  height: 24.h,
                ),
                label: 'Notification',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppIcon.profileIcon,
                  width: 24.w,
                  height: 24.h,
                ),
                activeIcon: Image.asset(
                  AppIcon.profileActiveIcon,
                  width: 24.w,
                  height: 24.h,
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
