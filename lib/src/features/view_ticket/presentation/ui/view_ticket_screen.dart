import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore_agent/lib.dart';

class ViewTicketScreen extends ConsumerStatefulWidget {
  final String id;
  final String ref;
  final String title;
  const ViewTicketScreen(
      {required this.id, required this.ref, required this.title, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ViewTicketScreenState();
}

class _ViewTicketScreenState extends ConsumerState<ViewTicketScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        resizeToAvoidBottomInset: true,
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
              width: 40.w,
              height: 40.h,
            ),
          ),
          title: Text(
            widget.title,
            style: AppTextStyle.josefinSansFont(
              context,
              AppColors.homeContainerBorderColor,
              20.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: AppColors.primaryColor,
          elevation: 0.0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppColors.primaryColor, // <-- SEE HERE
            statusBarIconBrightness:
                Brightness.dark, //<-- For Android SEE HERE (dark icons)
            statusBarBrightness:
                Brightness.dark, //<-- For iOS SEE HERE (dark icons)
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BottomExpandedViewWidget(
              physics: NeverScrollableScrollPhysics(),
              color: AppColors.whiteColor,
              radius: 0.0,
              left: 0.0,
              bottom: 0.0,
              right: 0.0,
              top: 0.0,
              child: Container(
                padding: EdgeInsets.only(top: 15.h),
                // color: AppColors.homeContainerBorderColor,
                color: AppColors.primarybgColor,
                child: ViewTicketTabBar(
                  tabsText: const [
                    Tab(
                      child: Text(
                        'Chat',
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Details',
                      ),
                    ),
                  ],
                  tabViews: [
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: TicketMessageView(id: widget.id),
                    ),
                    ViewTicketDetailsView(id: widget.id),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
