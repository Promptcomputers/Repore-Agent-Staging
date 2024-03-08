import 'package:flutter/material.dart';
import 'package:repore_agent/lib.dart';

class TicketTabBar extends StatefulWidget {
  final List<Datum>? data;
  const TicketTabBar({super.key, required this.data});

  @override
  State<TicketTabBar> createState() => _TicketTabBarState();
}

class _TicketTabBarState extends State<TicketTabBar>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 40.h,
                padding: EdgeInsets.only(
                  left: 20.w,
                  right: 20.w,
                ),
                width: MediaQuery.of(context).size.width,
                child: TabBar(
                  isScrollable: false,
                  controller: _tabController,
                  labelColor: AppColors.buttonBgColor,
                  labelStyle: AppTextStyle.satoshiFontText(
                    context,
                    AppColors.headerTextColor1,
                    14.sp,
                  ),
                  unselectedLabelStyle: AppTextStyle.satoshiFontText(
                    context,
                    AppColors.headerTextColor1,
                    14.sp,
                  ),
                  unselectedLabelColor: AppColors.headerTextColor1,
                  dividerColor: AppColors.primarybgColor,
                  labelPadding: EdgeInsets.zero,
                  indicatorPadding: EdgeInsets.zero,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: AppColors.buttonBgColor.withOpacity(0.2),
                  ),
                  tabs: const [
                    Tab(
                      child: Text(
                        'All',
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Ongoing',
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Completed',
                      ),
                    ),
                  ],
                ),
              ),
              YBox(10),
              Expanded(
                //TODO: Height and overflow issue
                // height: 480.h,
                // height: 600.h,

                child: TabBarView(
                  controller: _tabController,
                  children: [
                    AllTicketView(data: widget.data),
                    OnGoingTicketView(
                      data: widget.data!
                          .where((element) =>
                              element.status == TicketStatusType.ONGOING.name)
                          .toList(),
                    ),
                    CompletedTicketView(
                      data: widget.data!
                          .where((element) =>
                              element.status == TicketStatusType.CLOSED.name)
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
