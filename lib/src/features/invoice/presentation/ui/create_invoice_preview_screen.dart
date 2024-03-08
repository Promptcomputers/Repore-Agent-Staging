import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:repore_agent/lib.dart';

class CreateInvoicePreviewScreen extends ConsumerStatefulWidget {
  final String ticketId;
  final String invoiceTitle;
  final String dueDateController;
  final String note;
  final List<dynamic> invoiceDetails;
  final List<dynamic> serviceInvoiceDetails;
  final String customerName;
  final String invoiceType;
  const CreateInvoicePreviewScreen({
    super.key,
    required this.ticketId,
    required this.invoiceTitle,
    required this.dueDateController,
    required this.note,
    required this.invoiceDetails,
    required this.serviceInvoiceDetails,
    required this.customerName,
    required this.invoiceType,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateInvoicePreviewScreenState();
}

class _CreateInvoicePreviewScreenState
    extends ConsumerState<CreateInvoicePreviewScreen> {
  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat("dd MMM, yyyy").format(DateTime.now());
    ref.listen<AsyncValue>(createInvoiceProvider, (T, value) {
      if (value.hasValue) {
        showSuccessToast(context, "Created successfuly");

        ref.invalidate(getAallInvoiceTicketProvider);
        context.pushReplacementNamed(AppRoute.invoiceCreatedSuccessScreen.name,
            params: {'customerName': widget.customerName});

        context.loaderOverlay.hide();
      }
      if (value.hasError) {
        showErrorToast(context, value.error.toString());
        context.loaderOverlay.hide();
      }
    });
    return LoadingSpinner(
      child: Scaffold(
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
            'Preview',
            style: AppTextStyle.interFontText(
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
                Brightness.light, //<-- For Android SEE HERE (dark icons)
            statusBarBrightness:
                Brightness.dark, //<-- For iOS SEE HERE (dark icons)
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              ListView(
                padding: EdgeInsets.only(top: 30.h, bottom: 30.h),
                physics: AlwaysScrollableScrollPhysics(),
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Issued on',
                                  style: AppTextStyle.satoshiFontText(
                                    context,
                                    AppColors.headerTextColor1,
                                    12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  formattedDate,
                                  style: AppTextStyle.satoshiFontText(
                                    context,
                                    AppColors.primaryTextColor,
                                    14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Due on',
                                  style: AppTextStyle.satoshiFontText(
                                    context,
                                    AppColors.headerTextColor1,
                                    12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  widget.dueDateController,
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
                        YBox(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Receiver',
                                  style: AppTextStyle.satoshiFontText(
                                    context,
                                    AppColors.headerTextColor1,
                                    12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  '${capitalizeFirstLetter(widget.customerName)}',
                                  style: AppTextStyle.satoshiFontText(
                                    context,
                                    AppColors.primaryTextColor,
                                    14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Sender',
                                  style: AppTextStyle.satoshiFontText(
                                    context,
                                    AppColors.headerTextColor1,
                                    12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  '${capitalizeFirstLetter(PreferenceManager.firstName)} ${capitalizeFirstLetter(PreferenceManager.lastName)}',
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
                        YBox(30),
                        Text(
                          'Invoice Items',
                          style: AppTextStyle.satoshiFontText(
                            context,
                            AppColors.headerTextColor2,
                            14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        YBox(10),
                        Container(
                          padding: EdgeInsets.only(bottom: 20.h),
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            border: Border.all(
                              width: 1.w,
                              color: AppColors.notificationReadCardColor,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryColor.withOpacity(0.1),
                                blurRadius: 3.r,
                                // spreadRadius: 10.r,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    left: 20.w,
                                    top: 10.h,
                                    right: 20.h,
                                    bottom: 10.h),
                                decoration: const BoxDecoration(
                                  color: AppColors.homeContainerBorderColor,
                                ),
                                child: Row(
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 100.w,
                                      child: Text(
                                        widget.invoiceType == "ACQUISITION"
                                            ? 'Description'
                                            : 'Work',
                                        style: AppTextStyle.satoshiFontText(
                                          context,
                                          AppColors.headerTextColor2,
                                          12.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 70.w,
                                      child: Text(
                                        widget.invoiceType == "ACQUISITION"
                                            ? 'Quantity'
                                            : 'Hours',
                                        style: AppTextStyle.satoshiFontText(
                                          context,
                                          AppColors.headerTextColor2,
                                          12.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 60.w,
                                      child: Text(
                                        widget.invoiceType == "ACQUISITION"
                                            ? 'Price'
                                            : 'Rate',
                                        style: AppTextStyle.satoshiFontText(
                                          context,
                                          AppColors.headerTextColor2,
                                          12.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 60.w,
                                      child: Text(
                                        'Total',
                                        style: AppTextStyle.satoshiFontText(
                                          context,
                                          AppColors.headerTextColor2,
                                          12.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                separatorBuilder: (context, index) =>
                                    Divider(height: 20.h),
                                itemCount: widget.invoiceType == "ACQUISITION"
                                    ? widget.invoiceDetails.length
                                    : widget.serviceInvoiceDetails.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        top: 20.h, left: 20.w, right: 20.h),
                                    child: Row(
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 100.w,
                                          child: Text(
                                            capitalizeFirstLetter(
                                                widget.invoiceType == 'SERVICE'
                                                    ? widget
                                                        .serviceInvoiceDetails[
                                                            index]
                                                        .work
                                                    : widget
                                                        .invoiceDetails[index]
                                                        .description),
                                            // capitalizeFirstLetter(
                                            //     item.description),
                                            style: AppTextStyle.satoshiFontText(
                                              context,
                                              AppColors.headerTextColor2,
                                              12.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        // const Spacer(),
                                        SizedBox(
                                          width: 70.w,
                                          child: Text(
                                            widget.invoiceType == 'SERVICE'
                                                ? widget
                                                    .serviceInvoiceDetails[
                                                        index]
                                                    .hourly
                                                    .toString()
                                                : widget.invoiceDetails[index]
                                                    .quantity
                                                    .toString(),
                                            // item.quantity.toString(),
                                            style: AppTextStyle.satoshiFontText(
                                              context,
                                              AppColors.headerTextColor2,
                                              12.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        // const Spacer(),
                                        SizedBox(
                                          width: 60.w,
                                          child: Text(
                                            formatCurrency(widget.invoiceType ==
                                                    'SERVICE'
                                                ? '${widget.serviceInvoiceDetails[index].totalHour}'
                                                : '${widget.invoiceDetails[index].price}'),
                                            // formatCurrency('${item.price}'),
                                            style: AppTextStyle.satoshiFontText(
                                              context,
                                              AppColors.headerTextColor2,
                                              12.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        // const Spacer(),
                                        SizedBox(
                                          width: 60.w,
                                          child: Text(
                                            formatCurrency(widget.invoiceType ==
                                                    'SERVICE'
                                                ? '${widget.serviceInvoiceDetails[index].hourly * widget.serviceInvoiceDetails[index].totalHour}'
                                                : '${widget.invoiceDetails[index].price * widget.invoiceDetails[index].quantity}'),
                                            // formatCurrency(
                                            //     '${item.price * item.quantity}'),
                                            style: AppTextStyle.satoshiFontText(
                                              context,
                                              AppColors.headerTextColor2,
                                              12.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        YBox(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Sub total',
                              style: AppTextStyle.satoshiFontText(
                                context,
                                AppColors.headerTextColor1,
                                12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              formatCurrency(
                                  "${subTotal(widget.invoiceType == 'ACQUISITION' ? widget.invoiceDetails : widget.serviceInvoiceDetails, widget.invoiceType)}"),
                              style: AppTextStyle.satoshiFontText(
                                context,
                                AppColors.headerTextColor1,
                                12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        YBox(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tax(10%)',
                              style: AppTextStyle.satoshiFontText(
                                context,
                                AppColors.headerTextColor1,
                                12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              formatCurrency(
                                  "${tax(subTotal(widget.invoiceType == 'ACQUISITION' ? widget.invoiceDetails : widget.serviceInvoiceDetails, widget.invoiceType))}"),
                              style: AppTextStyle.satoshiFontText(
                                context,
                                AppColors.headerTextColor1,
                                12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        // YBox(10.h),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Text(
                        //       'Service charge(50%)',
                        //       style: AppTextStyle.satoshiFontText(
                        //         context,
                        //         AppColors.headerTextColor1,
                        //         12.sp,
                        //         fontWeight: FontWeight.w400,
                        //       ),
                        //     ),
                        //     Text(
                        //       formatCurrency(
                        //           "${serviceCharge(subTotal(widget.invoiceType == 'ACQUISITION' ? widget.invoiceDetails : widget.serviceInvoiceDetails, widget.invoiceType))}"),
                        //       style: AppTextStyle.satoshiFontText(
                        //         context,
                        //         AppColors.headerTextColor1,
                        //         12.sp,
                        //         fontWeight: FontWeight.w500,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        YBox(10),
                        Container(
                          padding: EdgeInsets.only(
                              left: 10.w, top: 10.h, bottom: 10.h, right: 10.w),
                          decoration: BoxDecoration(
                              color: AppColors.headerTextColor2,
                              borderRadius: BorderRadius.circular(4.r)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total',
                                style: AppTextStyle.satoshiFontText(
                                  context,
                                  AppColors.homeContainerBorderColor,
                                  12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                formatCurrency(
                                    "${total(subTotal(widget.invoiceType == 'ACQUISITION' ? widget.invoiceDetails : widget.serviceInvoiceDetails, widget.invoiceType), tax(subTotal(widget.invoiceType == 'ACQUISITION' ? widget.invoiceDetails : widget.serviceInvoiceDetails, widget.invoiceType)), 0)}"),
                                // "${total(subTotal(widget.invoiceType == 'ACQUISITION' ? widget.invoiceDetails : widget.serviceInvoiceDetails, widget.invoiceType), tax(subTotal(widget.invoiceType == 'ACQUISITION' ? widget.invoiceDetails : widget.serviceInvoiceDetails, widget.invoiceType)), serviceCharge(subTotal(widget.invoiceType == 'ACQUISITION' ? widget.invoiceDetails : widget.serviceInvoiceDetails, widget.invoiceType)))}"),
                                style: AppTextStyle.satoshiFontText(
                                  context,
                                  AppColors.homeContainerBorderColor,
                                  14.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        YBox(20),
                        Visibility(
                          visible: widget.note.isNotEmpty,
                          child: Text(
                            'Note',
                            style: AppTextStyle.satoshiFontText(
                              context,
                              AppColors.headerTextColor1,
                              12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        YBox(5),
                        Text(
                          widget.note,
                          style: AppTextStyle.satoshiFontText(
                            context,
                            AppColors.headerTextColor1,
                            14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.only(
                      left: 20.w, right: 20.w, bottom: 15.h, top: 15.h),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    border: Border.all(
                      color: AppColors.homeContainerBorderColor,
                    ),
                  ),
                  child: AppButton(
                    buttonText: 'Send',
                    bgColor: AppColors.primaryColor2,
                    borderColor: AppColors.primaryColor2,
                    onPressed: () {
                      final createInvoiceReq = CreateInvoiceReq(
                        ticket: widget.ticketId,
                        title: widget.invoiceTitle,
                        dueDate: DateTime.parse(widget.dueDateController),
                        notes: widget.note,
                        fields: widget.invoiceDetails,
                        type: widget.invoiceType,
                      );
                      ref
                          .read(createInvoiceProvider.notifier)
                          .createInvoice(createInvoiceReq: createInvoiceReq);
                      context.loaderOverlay.show();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
