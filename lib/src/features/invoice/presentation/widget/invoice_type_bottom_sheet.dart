import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:repore_agent/lib.dart';

class InvoiceTypeBottomSheet extends StatefulWidget {
  final String ticketId;
  final String invoiceTitle;
  final String customerName;
  const InvoiceTypeBottomSheet(
      {required this.ticketId,
      required this.invoiceTitle,
      required this.customerName,
      super.key});

  @override
  State<InvoiceTypeBottomSheet> createState() => _InvoiceTypeBottomSheetState();
}

// SERVICE
// ACQUISITION
enum InvoiceTypeEnum { SERVICE, ACQUISITION, none }

class _InvoiceTypeBottomSheetState extends State<InvoiceTypeBottomSheet> {
  InvoiceTypeEnum? _invoiceType = InvoiceTypeEnum.none;

  //function that handle when role is selected by tapping on the container
  _handleChange(InvoiceTypeEnum? value) {
    setState(() {
      _invoiceType = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
                left: 20.w, right: 20.w, top: 40.h, bottom: 40.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select Invoice Type',
                      style: AppTextStyle.satoshiFontText(
                        context,
                        AppColors.primaryColor,
                        18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Icon(
                        Icons.close,
                        color: AppColors.headerTextColor1,
                        size: 20.sp,
                      ),
                    )
                  ],
                ),
                YBox(50),
                GestureDetector(
                  onTap: () {
                    _handleChange(InvoiceTypeEnum.ACQUISITION);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _invoiceType == InvoiceTypeEnum.ACQUISITION
                            ? AppColors.primaryColor2
                            : AppColors.homeContainerBorderColor,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(5),
                      leading: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Image.asset(
                          AppIcon.materialIcon,
                          width: 20.w,
                          height: 20.h,
                        ),
                      ),
                      title: Transform.translate(
                        offset: const Offset(-8, 2),
                        child: Text(
                          'Materials',
                          style: AppTextStyle.interFontText(
                            context,
                            AppColors.headerTextColor1,
                            16.sp,
                          ),
                        ),
                      ),
                      trailing: Transform.translate(
                        offset: const Offset(-5, 2),
                        child: Radio(
                          activeColor: AppColors.primaryColor2,
                          focusColor: AppColors.primaryColor2,
                          value: InvoiceTypeEnum.ACQUISITION,
                          groupValue: _invoiceType,
                          onChanged: (value) {
                            _handleChange(InvoiceTypeEnum.ACQUISITION);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                YBox(20),
                GestureDetector(
                  onTap: () {
                    _handleChange(InvoiceTypeEnum.SERVICE);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _invoiceType == InvoiceTypeEnum.SERVICE
                            ? AppColors.primaryColor2
                            : AppColors.homeContainerBorderColor,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(5),
                      leading: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Image.asset(
                          AppIcon.serviceChargeIcon,
                          width: 20.w,
                          height: 20.h,
                        ),
                      ),
                      title: Transform.translate(
                        offset: const Offset(-10, 0),
                        child: Text(
                          'Service charge',
                          style: AppTextStyle.interFontText(
                            context,
                            AppColors.headerTextColor1,
                            16.sp,
                          ),
                        ),
                      ),
                      trailing: Transform.translate(
                        offset: const Offset(-8, 2),
                        child: Radio(
                          activeColor: AppColors.primaryColor2,
                          focusColor: AppColors.primaryColor2,
                          value: InvoiceTypeEnum.SERVICE,
                          groupValue: _invoiceType,
                          onChanged: (value) {
                            _handleChange(InvoiceTypeEnum.SERVICE);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                YBox(50),
                AppButton(
                  buttonText: 'Continue',
                  onPressed: _invoiceType!.name == 'none'
                      ? null
                      : () {
                          context.pushNamed(
                            AppRoute.createInvoiceScreen.name,
                            queryParams: {
                              'ticketId': widget.ticketId,
                              'invoiceTitle': widget.invoiceTitle,
                              'customerName': widget.customerName,
                              "invoiceType": _invoiceType!.name,
                            },
                          );
                          context.pop();
                        },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
