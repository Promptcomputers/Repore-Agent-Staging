import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:repore_agent/lib.dart';

class InvoiceScreen extends ConsumerStatefulWidget {
  final String ticketId;
  final String invoiceTitle;
  final String customerName;
  const InvoiceScreen(
      {required this.ticketId,
      required this.invoiceTitle,
      required this.customerName,
      super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends ConsumerState<InvoiceScreen> {
  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(getAallInvoiceTicketProvider(widget.ticketId));
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
          'Invoices',
          style: AppTextStyle.josefinSansFont(
            context,
            AppColors.homeContainerBorderColor,
            20.sp,
            fontWeight: FontWeight.w600,
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
      body: SafeArea(
        child: vm.when(
          error: (error, stackTrace) => const SizedBox(),
          loading: () => const AppCircularLoading(),
          data: (value) {
            return value.data.isEmpty
                ? Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        EmptyNotificationStateWidget(
                          title: 'No Invoice yet',
                          message: '',
                        ),
                        SizedBox(
                          width: 174.w,
                          child: AppButton(
                            buttonText: 'Create Invoice',
                            onPressed: () {
                              showModalBottomSheet(
                                barrierColor:
                                    AppColors.primaryTextColor.withOpacity(1.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20.0.sp),
                                  ),
                                ),
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => InvoiceTypeBottomSheet(
                                  ticketId: widget.ticketId,
                                  invoiceTitle: widget.invoiceTitle,
                                  customerName: widget.customerName,
                                ),
                              );

                              // context.pushNamed(
                              //     AppRoute.createInvoiceScreen.name,
                              //     queryParams: {
                              //       'ticketId': widget.ticketId,
                              //       'invoiceTitle': widget.invoiceTitle,
                              //       'customerName': widget.customerName,
                              //     });
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding:
                        EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
                    child: ListView(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Invoices',
                              style: AppTextStyle.interFontText(
                                context,
                                AppColors.notificationHeaderColor,
                                20.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              width: 135.w,
                              height: 55.h,
                              child: AppButton(
                                buttonText: 'Create Invoice',
                                onPressed: () {
                                  showModalBottomSheet(
                                    barrierColor: AppColors.primaryTextColor
                                        .withOpacity(1.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20.0.sp),
                                      ),
                                    ),
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) =>
                                        InvoiceTypeBottomSheet(
                                      ticketId: widget.ticketId,
                                      invoiceTitle: widget.invoiceTitle,
                                      customerName: widget.customerName,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        YBox(20.h),
                        ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => YBox(10),
                          itemCount: value.data.length,
                          itemBuilder: (context, index) {
                            final item = value.data[index];
                            //TODO: handle the suffix th, nd st
                            String formattedDate = DateFormat("dd MMM, yyyy")
                                .format(item.createdAt);
                            // String formattedOrdinalDate =
                            //     DateFormat("dd'th' MMM, yyyy")
                            //         .format(item.createdAt);
                            return GestureDetector(
                              onTap: () {
                                context.pushNamed(
                                  AppRoute.invoicePreviewScreen.name,
                                  queryParams: {
                                    'invoiceId': item.id,
                                    'invoiceRef': item.invoiceReference,
                                    'subject': item.title,
                                  },
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: 20.w,
                                    right: 20.w,
                                    top: 20.h,
                                    bottom: 20.h),
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  borderRadius: BorderRadius.circular(16.r),
                                  border: Border.all(
                                    width: 1.w,
                                    color: AppColors.homeContainerBorderColor,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          item.invoiceType ==
                                                  InvoiceType.SERVICE.name
                                              ? AppIcon.invoiceServiceIcon
                                              : AppIcon.invoiceAcquistionIcon,
                                          width: 25.w,
                                          height: 25.h,
                                        ),
                                        XBox(10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 180.w,
                                              child: Text(
                                                capitalizeFirstLetter(
                                                    item.title),
                                                style: AppTextStyle
                                                    .satoshiFontText(
                                                  context,
                                                  AppColors.primaryTextColor,
                                                  14.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            YBox(3),
                                            Text(
                                              formattedDate,
                                              style:
                                                  AppTextStyle.satoshiFontText(
                                                context,
                                                AppColors.headerTextColor1,
                                                10.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          formatCurrency('${item.total}'),
                                          style: AppTextStyle.satoshiFontText(
                                            context,
                                            AppColors.primaryTextColor,
                                            14.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        YBox(3),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
                                              radius: 3.r,
                                              backgroundColor:
                                                  invoiceStatusColor(
                                                      item.approvalStatus),
                                            ),
                                            XBox(2),
                                            Text(
                                              statusText(item.approvalStatus),
                                              style:
                                                  AppTextStyle.satoshiFontText(
                                                context,
                                                invoiceStatusColor(
                                                    item.approvalStatus),
                                                10.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
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
