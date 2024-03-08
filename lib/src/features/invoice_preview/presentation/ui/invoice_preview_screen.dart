import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:repore_agent/lib.dart';
import 'package:share_plus/share_plus.dart';

class InvoicePreviewScreen extends ConsumerStatefulWidget {
  final String invoiceId;
  final String invoiceRef;
  final String subject;
  const InvoicePreviewScreen(
      {required this.invoiceId,
      required this.invoiceRef,
      required this.subject,
      super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _InvoicePreviewScreenState();
}

class _InvoicePreviewScreenState extends ConsumerState<InvoicePreviewScreen> {
  PdfColor pwWhiteColor = PdfColor.fromHex("ffffff");
  PdfColor pwHeaderTextColor2 = PdfColor.fromHex("1D2939");
  PdfColor pwTextColor = PdfColor.fromHex("344054");
  PdfColor pwTextColor2 = PdfColor.fromHex("1D2939");
  PdfColor pwTextColor3 = PdfColor.fromHex("667085");
  PdfColor pwBgColor = PdfColor.fromHex("EAECF0");
  PdfColor pwContainerColor = PdfColor.fromHex("475467");
  final pdf = pw.Document();
  File? pdfFile;

  final acquisitionHeader = ['Description', 'Price', 'Quantity', 'Total'];
  final serviceHeader = ['Work', 'Hours', 'Rate', 'Total'];

  ///Genereate invoice to be share
  generatePdf(InvoiceDetailsRes? invoice) async {
    ///Logo
    final reporeLogo = pw.MemoryImage(
      (await rootBundle.load(AppImages.logo)).buffer.asUint8List(),
    );
    String formattedDate =
        DateFormat("dd MMM, yyyy").format(invoice!.data.createdAt);
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            ///Logo
            pw.SizedBox(
              height: 100,
              width: 100,
              child: pw.Image(reporeLogo),
            ),
            pw.SizedBox(height: 10.h),

            pw.Text(
              'Invoice',
              style: pw.TextStyle(
                color: pwHeaderTextColor2,
                fontWeight: pw.FontWeight.bold,
                fontSize: 38.sp,
              ),
            ),
            pw.SizedBox(height: 40.h),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Issued on',
                      style: pw.TextStyle(
                        color: pwTextColor,
                        fontWeight: pw.FontWeight.normal,
                        fontSize: 12.sp,
                      ),
                    ),
                    pw.SizedBox(height: 5.h),
                    pw.Text(
                      formattedDate,
                      style: pw.TextStyle(
                        color: pwTextColor,
                        fontWeight: pw.FontWeight.normal,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Invoice ID ',
                      style: pw.TextStyle(
                        color: pwTextColor,
                        fontWeight: pw.FontWeight.normal,
                        fontSize: 12.sp,
                      ),
                    ),
                    pw.SizedBox(height: 5.h),
                    pw.Text(
                      invoice.data.invoiceReference.substring(0, 12),
                      style: pw.TextStyle(
                        color: pwTextColor2,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 40.h),
            pw.Text(
              'Invoice Items',
              style: pw.TextStyle(
                color: pwTextColor,
                fontWeight: pw.FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
            pw.SizedBox(height: 10.h),

            ///Invooice items
            pw.Table.fromTextArray(
              headers: invoice.data.type == 'SERVICE'
                  ? serviceHeader
                  : acquisitionHeader,
              border: null,
              headerDecoration: pw.BoxDecoration(
                color: pwBgColor,
              ),
              headerStyle: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
              ),
              cellHeight: 30,
              cellAlignments: {
                0: pw.Alignment.centerLeft,
                1: pw.Alignment.centerRight,
                2: pw.Alignment.centerRight,
                3: pw.Alignment.centerRight,
              },
              data: invoice.data.type == 'SERVICE'
                  ? invoice.data.serviceDetails.map((e) {
                      final total = e.hourlyRate * e.totalHour;
                      return [
                        capitalizeFirstLetter(e.work),
                        formatCurrency('${e.hourlyRate}'),
                        e.totalHour,
                        formatCurrency('$total'),
                      ];
                    }).toList()
                  : invoice.data.acquisitionDetails.map((e) {
                      final total = e.price * e.quantity;
                      return [
                        capitalizeFirstLetter(e.description),
                        formatCurrency('${e.price}'),
                        e.quantity,
                        formatCurrency('$total'),
                      ];
                    }).toList(),
            ),
            pw.Divider(),
            pw.SizedBox(height: 20.h),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  'Tax (10%)',
                  style: pw.TextStyle(
                    color: pwTextColor3,
                    fontWeight: pw.FontWeight.normal,
                    fontSize: 12.sp,
                  ),
                ),
                pw.SizedBox(height: 5.h),
                pw.Text(
                  formatCurrency('${invoice.data.taxCharge}'),
                  style: pw.TextStyle(
                    color: pwTextColor,
                    fontWeight: pw.FontWeight.normal,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 10.h),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  'Sub total',
                  style: pw.TextStyle(
                    color: pwTextColor3,
                    fontWeight: pw.FontWeight.normal,
                    fontSize: 12.sp,
                  ),
                ),
                pw.SizedBox(height: 5.h),
                pw.Text(
                  formatCurrency('${invoice.data.total}'),
                  style: pw.TextStyle(
                    color: pwTextColor,
                    fontWeight: pw.FontWeight.normal,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 20.h),
            pw.Container(
              padding: pw.EdgeInsets.only(
                  left: 10.w, top: 10.h, bottom: 10.h, right: 10.w),
              decoration: pw.BoxDecoration(
                color: pwContainerColor,
                borderRadius: pw.BorderRadius.circular(4.r),
              ),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Total',
                    style: pw.TextStyle(
                        color: pwBgColor,
                        fontWeight: pw.FontWeight.normal,
                        fontSize: 12.sp),
                  ),
                  pw.Text(
                    formatCurrency('${invoice.data.total}'),
                    style: pw.TextStyle(
                        color: pwBgColor,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 12.sp),
                  ),
                ],
              ),
            ),
          ];
        },
      ),
    );

    final output = await getTemporaryDirectory();
    log('output dir $output');
    pdfFile = File('${output.path}/Repore_${widget.invoiceRef}.pdf');

    ///When you share at first, and you don't leave the screen, you can share again
    await pdfFile!.writeAsBytes(await pdf.save());

    // OpenFile.open(pdfFile!.path);
    sharePdf(file: pdfFile);
  }

  void sharePdf({File? file}) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    Share.shareFiles([file!.path],
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(viewInvoiceProvider(widget.invoiceId));
    final cashOut = ref.watch(cashOutProvider);
    // ref.listen<AsyncValue>(updateInvoiceStatus, (T, value) {
    //   if (value.hasValue) {
    //     Navigator.of(context).pop();
    //     ref.invalidate(viewInvoiceProvider(widget.invoiceId));
    //     ref.invalidate(getAallInvoiceTicketProvider('widget.invoiceId'));
    //   }
    //   if (value.hasError) {
    //     Navigator.of(context).pop();
    //   }
    // });

    ref.listen<AsyncValue>(cashOutProvider, (T, value) {
      if (value.hasValue) {
        showSuccessToast(context, ' Success');

        ref.invalidate(viewInvoiceProvider(widget.invoiceId));
        ref.invalidate(getUserDetailsProvider);
        context.pop();
        FocusManager.instance.primaryFocus?.unfocus();
      }
      if (value.hasError) {
        showErrorToast(context, value.error.toString());
        FocusManager.instance.primaryFocus?.unfocus();
      }
    });
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
          capitalizeFirstLetter(widget.subject),
          style: AppTextStyle.josefinSansFont(
            context,
            AppColors.homeContainerBorderColor,
            20.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        // actions: [
        //   GestureDetector(
        //     onTap: () {
        //       generatePdf(vm.asData?.value);
        //     },
        //     child: Image.asset(AppIcon.shareIcon),
        //   )
        // ],
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
        child: vm.when(
          data: (value) {
            String formattedDate =
                DateFormat("dd MMM, yyyy").format(value.data.createdAt);
            String formattedDueDate =
                DateFormat("dd MMM, yyyy").format(value.data.dueDate);
            return Stack(
              children: [
                ListView(
                  padding: EdgeInsets.only(
                    top: 30.h,
                    bottom: 100.h,
                  ),
                  physics: AlwaysScrollableScrollPhysics(),
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20.w, right: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(AppImages.logo),
                          // YBox(20.h),
                          // Text(
                          //   value.data.invoiceReference.substring(0, 12),
                          //   style: AppTextStyle.satoshiFontText(
                          //     context,
                          //     AppColors.headerTextColor2,
                          //     15.sp,
                          //     fontWeight: FontWeight.w700,
                          //   ),
                          // ),
                          YBox(20),
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
                                    formattedDueDate,
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
                                    '${capitalizeFirstLetter(value.data.customer!.firstname)} ${capitalizeFirstLetter(value.data.customer!.lastname)}',
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
                                    '${capitalizeFirstLetter(value.data.author!.firstname)} ${capitalizeFirstLetter(value.data.author!.lastname)}',
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
                                    'Ref',
                                    style: AppTextStyle.satoshiFontText(
                                      context,
                                      AppColors.headerTextColor1,
                                      12.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    value.data.invoiceReference
                                        .substring(0, 12),
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
                                    'Status',
                                    style: AppTextStyle.satoshiFontText(
                                      context,
                                      AppColors.headerTextColor1,
                                      12.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 3.r,
                                        backgroundColor: invoiceStatusColor(
                                            value.data.approvalStatus),
                                      ),
                                      XBox(2),
                                      Text(
                                        statusText(value.data.approvalStatus),
                                        style: AppTextStyle.satoshiFontText(
                                          context,
                                          invoiceStatusColor(
                                              value.data.approvalStatus),
                                          12.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
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
                            // height: 500.h,
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              border: Border.all(
                                width: 1.w,
                                color: AppColors.notificationReadCardColor,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      AppColors.primaryColor.withOpacity(0.1),
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
                                    // border: Border.all(
                                    //   width: 1.w,
                                    //   color:
                                    //       AppColors.notificationReadCardColor,
                                    // ),
                                  ),
                                  child: Row(
                                    // mainAxisAlignment:
                                    //     MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 100.w,
                                        child: Text(
                                          value.data.type ==
                                                  InvoiceType.SERVICE.name
                                              ? 'Work'
                                              : 'Description',
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
                                          value.data.type ==
                                                  InvoiceType.SERVICE.name
                                              ? 'Hours'
                                              : 'Quantity',
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
                                          value.data.type ==
                                                  InvoiceType.SERVICE.name
                                              ? 'Rate'
                                              : 'Price',
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
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  separatorBuilder: (context, index) =>
                                      Divider(height: 20.h),
                                  itemCount: value.data.type ==
                                          InvoiceType.SERVICE.name
                                      ? value.data.serviceDetails.length
                                      : value.data.acquisitionDetails.length,
                                  itemBuilder: (context, index) {
                                    ///TODO: Refactor
                                    // ServiceDetails? serviceDetailsItem;
                                    // AcquisitionDetails? acquisitionDetailsItem;
                                    final item = value.data;
                                    // if (value.data.type == 'SERVICE') {
                                    //   serviceDetailsItem =
                                    //       item.serviceDetails[index];
                                    // } else {
                                    //   acquisitionDetailsItem =
                                    //       item.acquisitionDetails[index];
                                    // }

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
                                              capitalizeFirstLetter(item.type ==
                                                      InvoiceType.SERVICE.name
                                                  ? item.serviceDetails[index]
                                                      .work
                                                  : item
                                                      .acquisitionDetails[index]
                                                      .description),
                                              // capitalizeFirstLetter(
                                              //     item.type == 'SERVICE'
                                              //         ? serviceDetailsItem!.work
                                              //         : acquisitionDetailsItem!
                                              //             .description),
                                              style:
                                                  AppTextStyle.satoshiFontText(
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
                                              item.type ==
                                                      InvoiceType.SERVICE.name
                                                  ? item.serviceDetails[index]
                                                      .hourlyRate
                                                      .toString()
                                                  : item
                                                      .acquisitionDetails[index]
                                                      .quantity
                                                      .toString(),
                                              // item.type == 'SERVICE'
                                              //     ? serviceDetailsItem!
                                              //         .hourlyRate
                                              //         .toString()
                                              //     : acquisitionDetailsItem!
                                              //         .quantity
                                              //         .toString(),
                                              style:
                                                  AppTextStyle.satoshiFontText(
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
                                              formatCurrency(item.type ==
                                                      InvoiceType.SERVICE.name
                                                  ? '${item.serviceDetails[index].totalHour}'
                                                  : '${item.acquisitionDetails[index].price}'),
                                              // formatCurrency(item.type ==
                                              //         'SERVICE'
                                              //     ? '${serviceDetailsItem!.totalHour}'
                                              //     : '${acquisitionDetailsItem!.price}'),
                                              style:
                                                  AppTextStyle.satoshiFontText(
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
                                              formatCurrency(item.type ==
                                                      InvoiceType.SERVICE.name
                                                  ? '${item.serviceDetails[index].hourlyRate * item.serviceDetails[index].totalHour}'
                                                  : '${item.acquisitionDetails[index].price * item.acquisitionDetails[index].quantity}'),
                                              // formatCurrency(item.type ==
                                              //         'SERVICE'
                                              //     ? '${serviceDetailsItem!.hourlyRate * serviceDetailsItem.totalHour}'
                                              //     : '${acquisitionDetailsItem!.price * acquisitionDetailsItem.quantity}'),
                                              style:
                                                  AppTextStyle.satoshiFontText(
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
                                formatCurrency('${value.data.subTotal}'),
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
                                'Tax',
                                style: AppTextStyle.satoshiFontText(
                                  context,
                                  AppColors.headerTextColor1,
                                  12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                formatCurrency(
                                    '${value.data.taxCharge!.toStringAsFixed(2)}'),
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
                                'Service charge',
                                style: AppTextStyle.satoshiFontText(
                                  context,
                                  AppColors.headerTextColor1,
                                  12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                formatCurrency(
                                    value.data.serviceCharge.toString()),
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

                          Container(
                            padding: EdgeInsets.only(
                                left: 10.w,
                                top: 10.h,
                                bottom: 10.h,
                                right: 10.w),
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
                                  formatCurrency('${value.data.total}'),
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
                            visible: value.data.notes.isNotEmpty,
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
                            value.data.notes,
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

                /// If cashout is true don't or approvalStatus is either pending or reject
                // value.data.hasCashout == true ||
                //         value.data.approvalStatus == 'PENDING' ||
                //         value.data.approvalStatus == 'AWAITING' ||
                //         value.data.approvalStatus == 'REJECT'
                value.data.hasCashout == true ||
                        value.data.approvalStatus !=
                            InvoiceApprovalStatus.APPROVED.name
                    ? SizedBox()
                    : Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: EdgeInsets.only(left: 20.w, right: 20.w),
                          child: AppButton(
                            buttonText: 'Cash out',
                            isLoading: cashOut.isLoading,
                            onPressed: () {
                              ref
                                  .read(cashOutProvider.notifier)
                                  .cashout(value.data.id);
                            },
                          ),
                        ),
                      )
              ],
            );
          },
          error: (error, stackTrace) {
            return Text(
              error.toString(),
              style: AppTextStyle.satoshiFontText(
                context,
                AppColors.headerTextColor2,
                14.sp,
                fontWeight: FontWeight.w400,
              ),
            );
          },
          // error: (error, stackTrace) => const SizedBox(),
          loading: () => const AppCircularLoading(),
        ),
      ),
    );
  }
}
