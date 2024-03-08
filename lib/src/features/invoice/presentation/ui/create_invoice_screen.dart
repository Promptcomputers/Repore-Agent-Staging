import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:repore_agent/lib.dart';

class CreateInvoiceScreen extends ConsumerStatefulWidget {
  final String ticketId;
  final String invoiceTitle;
  final String customerName;
  final String invoiceType;

  const CreateInvoiceScreen({
    super.key,
    required this.ticketId,
    required this.invoiceTitle,
    required this.customerName,
    required this.invoiceType,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateInvoiceScreenState();
}

class _CreateInvoiceScreenState extends ConsumerState<CreateInvoiceScreen> {
  List<dynamic> invoiceDetails = [];
  List<dynamic> serviceInvoiceDetails = [];
  final invoiceDetailsFormKey = GlobalKey<FormState>();
  final serviceInvoiceDetailsFormKey = GlobalKey<FormState>();
  final createInvoiceFormKey = GlobalKey<FormState>();
  final invoiceTitleController = TextEditingController();
  final dueDateController = TextEditingController();
  final noteController = TextEditingController();
  final descriptionController = TextEditingController();
  final workController = TextEditingController();
  final quantityController = TextEditingController();
  final hourController = TextEditingController();
  final durationController = TextEditingController();
  final priceController = TextEditingController();
  final totalHourController = TextEditingController();
  final totalController = TextEditingController();
  final invoiceTitleFocusNode = FocusNode();
  final dueDateFocusNode = FocusNode();
  final noteFocusNode = FocusNode();
  final descriptionFocusNode = FocusNode();
  final workFocusNode = FocusNode();
  final quantityFocusNode = FocusNode();
  final hourFocusNode = FocusNode();
  final priceFocusNode = FocusNode();
  final totalHourFocusNode = FocusNode();
  final totalFocusNode = FocusNode();

  bool isAddItemClicked = false;

  @override
  Widget build(BuildContext context) {
    ///TODO: The total is not uodating ion the UI, that is why i commented it out
    priceController.text.isEmpty
        ? '0'
        : '${int.parse(quantityController.text) * int.parse(priceController.text)}';
    log('totalController.text:${totalController.text}');
    // });
    ref.listen<AsyncValue>(createInvoiceProvider, (T, value) {
      if (value.hasValue) {
        showSuccessToast(context, "Created successfuly");
        invoiceDetails.clear();
        descriptionController.clear();
        quantityController.clear();
        priceController.clear();
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
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
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
              'Create Invoice',
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
          body: Form(
            key: createInvoiceFormKey,
            child: SafeArea(
                child: Stack(
              children: [
                ListView(
                  padding: EdgeInsets.only(
                      top: 20.h, left: 20.w, right: 20.w, bottom: 200.h),
                  children: [
                    const FormLabel(
                      text: 'Invoice Title',
                    ),
                    YBox(6),

                    ///Invoice Title
                    AppTextField(
                        controller: invoiceTitleController,
                        hintText: 'Product Invoice',
                        focusNode: invoiceTitleFocusNode,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        validator: (value) => Validator.validateField(value,
                            errorMessage: 'Invoice title is required')
                        // onFieldSubmitted: (value) {
                        //   if (FormStringUtils.isNotEmpty(value)) {
                        //     emailFocusNode.requestFocus();
                        //   }
                        // },
                        ),
                    YBox(20),

                    ///Issued Date and Due Date
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///Issued Date
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const FormLabel(
                              text: 'Issued date',
                            ),
                            YBox(6),
                            SizedBox(
                              width: 160.w,
                              child: DateTimePicker(
                                dateMask: 'd/M/yyyy',
                                readOnly: true,
                                initialValue: DateTime.now().toString(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.r),
                                    borderSide: const BorderSide(
                                        color:
                                            AppColors.textFormFieldBorderColor),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.r),
                                    borderSide: BorderSide(
                                        color:
                                            AppColors.textFormFieldBorderColor),
                                  ),
                                  labelStyle: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF86828D),
                                  ),
                                ),
                                onChanged: (val) => {debugPrint(val)},
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Select due date';
                                  }
                                  return null;
                                },
                                onSaved: (val) => debugPrint(val),
                              ),
                            ),
                          ],
                        ),

                        ///Due Date
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const FormLabel(
                              text: 'Due date',
                            ),
                            YBox(6),
                            SizedBox(
                              width: 160.w,
                              child: DateTimePicker(
                                dateMask: 'd/M/yyyy',
                                // autovalidate: true,
                                initialDate:
                                    DateTime.now().add(Duration(days: 1)),
                                firstDate:
                                    DateTime.now().add(Duration(days: 1)),
                                lastDate:
                                    DateTime.now().add(Duration(days: 180)),
                                controller: dueDateController,
                                decoration: InputDecoration(
                                  hintText: 'Due Date',
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.r),
                                    borderSide: const BorderSide(
                                        color:
                                            AppColors.textFormFieldBorderColor),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.r),
                                    borderSide: BorderSide(
                                        color:
                                            AppColors.textFormFieldBorderColor),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.r),
                                    borderSide: const BorderSide(
                                        color: AppColors.redColor),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.r),
                                    borderSide: const BorderSide(
                                        color: AppColors.redColor),
                                  ),
                                  labelStyle: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF86828D),
                                  ),
                                ),
                                onChanged: (val) {
                                  setState(() {});
                                },
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Due date is required';
                                  }
                                  return null;
                                },
                                onSaved: (val) => debugPrint(val),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    YBox(20),
                    Text(
                      'Invoice items',
                      style: AppTextStyle.josefinSansFont(
                        context,
                        AppColors.headerTextColor2,
                        16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Visibility(
                      visible: invoiceDetails.isNotEmpty ||
                          serviceInvoiceDetails.isNotEmpty,
                      child: YBox(10),
                    ),
                    Visibility(
                      visible: invoiceDetails.isNotEmpty ||
                          serviceInvoiceDetails.isNotEmpty,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 110.w,
                            child: Text(
                              widget.invoiceType == InvoiceType.ACQUISITION.name
                                  ? 'Description'
                                  : 'Work time',
                              style: AppTextStyle.satoshiFontText(
                                context,
                                AppColors.primaryTextColor,
                                14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            width: 60.w,
                            child: Text(
                              widget.invoiceType == InvoiceType.ACQUISITION.name
                                  ? 'Qty'
                                  : 'Hours',
                              style: AppTextStyle.satoshiFontText(
                                context,
                                AppColors.primaryTextColor,
                                14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            width: 60.w,
                            child: Text(
                              widget.invoiceType == InvoiceType.ACQUISITION.name
                                  ? 'Price'
                                  : 'Rate',
                              style: AppTextStyle.satoshiFontText(
                                context,
                                AppColors.primaryTextColor,
                                14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            width: 60.w,
                            child: Text(
                              'Total',
                              style: AppTextStyle.satoshiFontText(
                                context,
                                AppColors.primaryTextColor,
                                14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Spacer(),
                          SizedBox(),
                          Spacer(),
                          SizedBox(),
                          Spacer(),
                          SizedBox(),
                          Spacer(),
                          SizedBox(),
                          Spacer(),
                          SizedBox(),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: invoiceDetails.isNotEmpty ||
                          serviceInvoiceDetails.isNotEmpty,
                      child: YBox(5),
                    ),

                    ///Acquisation invoice list build
                    Visibility(
                      visible: invoiceDetails.isNotEmpty,
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: invoiceDetails.length,
                        separatorBuilder: (context, index) => YBox(5.h),
                        itemBuilder: (context, index) {
                          final invoiceItem = invoiceDetails[index];
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InvoiceItemDetailsWidget(
                                width: 100.w,
                                title: 'Description',
                                item: invoiceItem.description,
                              ),
                              Spacer(),
                              InvoiceItemDetailsWidget(
                                width: 60.w,
                                title: 'Qty',
                                item: invoiceItem.quantity.toString(),
                              ),
                              Spacer(),
                              InvoiceItemDetailsWidget(
                                width: 60.w,
                                title: 'Price',
                                item: formatCurrency(
                                    invoiceItem.price.toString()),
                              ),
                              Spacer(),
                              InvoiceItemDetailsWidget(
                                width: 60.w,
                                title: 'Total',
                                item: formatCurrency(
                                    '${invoiceItem.price * invoiceItem.quantity}'),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    invoiceDetails.removeAt(index);
                                  });
                                },
                                child: Icon(
                                  Icons.remove_circle_outline,
                                  color: AppColors.redColor,
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ),

                    ///Service invoice list build
                    Visibility(
                      visible: serviceInvoiceDetails.isNotEmpty,
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: serviceInvoiceDetails.length,
                        separatorBuilder: (context, index) => YBox(5.h),
                        itemBuilder: (context, index) {
                          final invoiceItem = serviceInvoiceDetails[index];
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InvoiceItemDetailsWidget(
                                width: 100.w,
                                title: 'Work',
                                item: invoiceItem.work,
                              ),
                              Spacer(),
                              InvoiceItemDetailsWidget(
                                width: 60.w,
                                title: 'Hours',
                                item: invoiceItem.hourly.toString(),
                              ),
                              Spacer(),
                              InvoiceItemDetailsWidget(
                                width: 60.w,
                                title: 'Rate',
                                item: formatCurrency(
                                    invoiceItem.totalHour.toString()),
                              ),
                              Spacer(),
                              InvoiceItemDetailsWidget(
                                width: 60.w,
                                title: 'Total',
                                item: formatCurrency(
                                    '${(invoiceItem.hourly / 60) * invoiceItem.totalHour}'),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    serviceInvoiceDetails.removeAt(index);
                                  });
                                },
                                child: Icon(
                                  Icons.remove_circle_outline,
                                  color: AppColors.redColor,
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ),
                    Visibility(visible: isAddItemClicked, child: YBox(20)),

                    ///Aq=cquisation or Service text form fields
                    Visibility(
                      visible: isAddItemClicked,
                      child: Form(
                        key: widget.invoiceType == InvoiceType.ACQUISITION.name
                            ? invoiceDetailsFormKey
                            : serviceInvoiceDetailsFormKey,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 100.w,
                              child: AppTextField(
                                controller: widget.invoiceType ==
                                        InvoiceType.ACQUISITION.name
                                    ? descriptionController
                                    : workController,
                                hintText: widget.invoiceType ==
                                        InvoiceType.ACQUISITION.name
                                    ? 'Description'
                                    : 'Work time',
                                focusNode: descriptionFocusNode,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                validator: (value) => Validator.validateField(
                                    value,
                                    errorMessage: ''),
                              ),
                            ),
                            Spacer(),

                            ///If invoice type is service, disable the text form field and show alert dialod where user can enter hours and minute for hours rate
                            SizedBox(
                              width: 80.w,
                              child: AppTextField(
                                // initialValue: '$hours:$mins',
                                readOnly: widget.invoiceType ==
                                        InvoiceType.SERVICE.name
                                    ? true
                                    : false,
                                onTap: widget.invoiceType ==
                                        InvoiceType.ACQUISITION.name
                                    ? null
                                    : () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            ///Hour controller coming from SelectHourAlertDialogWidget has been converted to mins
                                            return SelectHourAlertDialogWidget(
                                              hourController: hourController,
                                              totalDuration: durationController,
                                            );
                                          },
                                        ).then((value) {
                                          Console.print(
                                              'shpw dialog value $value');
                                          Console.print(
                                              'duration $durationController');
                                          Console.print(
                                              'hourController ${hourController.text}');
                                        });
                                      },
                                controller: widget.invoiceType ==
                                        InvoiceType.ACQUISITION.name
                                    ? quantityController
                                    : hourController,
                                hintText: widget.invoiceType ==
                                        InvoiceType.ACQUISITION.name
                                    ? 'Qty'
                                    : 'Hours',
                                focusNode: quantityFocusNode,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                validator: (value) => Validator.validateField(
                                    value,
                                    errorMessage: ''),
                              ),
                            ),
                            Spacer(),
                            SizedBox(
                              width: 80.w,
                              child: AppTextField(
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d+\.?\d{0,2}')),
                                ],
                                controller: widget.invoiceType ==
                                        InvoiceType.ACQUISITION.name
                                    ? priceController
                                    : totalHourController,
                                hintText: widget.invoiceType ==
                                        InvoiceType.ACQUISITION.name
                                    ? 'Price'
                                    : 'Rate',
                                focusNode: priceFocusNode,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                validator: (value) => Validator.validateField(
                                    value,
                                    errorMessage: ''),
                              ),
                            ),
                            Spacer(),
                            // SizedBox(
                            //   width: 60.w,
                            //   child: AppTextField(
                            //     controller: totalController,
                            //     hintText: 'Total',
                            //     focusNode: totalFocusNode,
                            //     keyboardType: TextInputType.number,
                            //     readOnly: true,
                            //     // enabled: false,
                            //     // textInputAction: TextInputAction.next,
                            //     // validator: (value) => Validator.validateField(
                            //     //     value,
                            //     //     errorMessage: ''),
                            //   ),
                            // ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                if (widget.invoiceType ==
                                        InvoiceType.ACQUISITION.name
                                    ? invoiceDetailsFormKey.currentState!
                                        .validate()
                                    : serviceInvoiceDetailsFormKey.currentState!
                                        .validate()) {
                                  setState(() {
                                    Console.print('i am here');
                                    widget.invoiceType ==
                                            InvoiceType.ACQUISITION.name
                                        ? invoiceDetails.add(
                                            Field(
                                              description: descriptionController
                                                  .text
                                                  .trim(),
                                              quantity: num.parse(
                                                  quantityController.text
                                                      .trim()),
                                              price: num.parse(
                                                priceController.text.trim(),
                                              ),
                                            ),
                                          )
                                        : serviceInvoiceDetails
                                            .add(ServiceField(
                                            work: workController.text.trim(),
                                            hourly: num.parse(
                                                durationController.text.trim()),
                                            totalHour: num.parse(
                                                totalHourController.text
                                                    .trim()),
                                          ));
                                    isAddItemClicked = false;
                                    descriptionController.clear();
                                    quantityController.clear();
                                    priceController.clear();
                                    workController.clear();
                                    hourController.clear();
                                    durationController.clear();
                                    totalController.clear();
                                    totalHourController.clear();
                                  });
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.only(top: 15.h),
                                child: Icon(
                                  Icons.add_circle_outline,
                                  color: AppColors.greenColor,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    YBox(10),
                    Visibility(
                      visible: !isAddItemClicked,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isAddItemClicked = true;
                          });
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.add,
                              color: AppColors.primaryColor2,
                            ),
                            XBox(5),
                            Text(
                              'New Item',
                              style: AppTextStyle.satoshiFontText(
                                context,
                                AppColors.primaryColor2,
                                14.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    YBox(20),
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
                          (invoiceDetails.isEmpty &&
                                  serviceInvoiceDetails.isEmpty)
                              ? formatCurrency('0')
                              : formatCurrency(
                                  "${subTotal(widget.invoiceType == InvoiceType.ACQUISITION.name ? invoiceDetails : serviceInvoiceDetails, widget.invoiceType)}"),
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
                          (invoiceDetails.isEmpty &&
                                  serviceInvoiceDetails.isEmpty)
                              ? formatCurrency('0')
                              : formatCurrency(
                                  "${tax(subTotal(widget.invoiceType == InvoiceType.ACQUISITION.name ? invoiceDetails : serviceInvoiceDetails, widget.invoiceType))}"),
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
                    //       invoiceDetails.isEmpty
                    //           ? formatCurrency('0')
                    //           : formatCurrency(
                    //               "${serviceCharge(subTotal(widget.invoiceType=='ACQUISITION'? invoiceDetails:serviceInvoiceDetails))}"),
                    //       style: AppTextStyle.satoshiFontText(
                    //         context,
                    //         AppColors.headerTextColor1,
                    //         12.sp,
                    //         fontWeight: FontWeight.w500,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    YBox(20),
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
                          // ACQUISITION}
                          Text(
                            (invoiceDetails.isEmpty &&
                                    serviceInvoiceDetails.isEmpty)
                                ? formatCurrency('0')
                                : formatCurrency(
                                    "${total(subTotal(widget.invoiceType == InvoiceType.ACQUISITION.name ? invoiceDetails : serviceInvoiceDetails, widget.invoiceType), tax(subTotal(widget.invoiceType == 'ACQUISITION' ? invoiceDetails : serviceInvoiceDetails, widget.invoiceType)), 0)}"),
                            // invoiceDetails.isEmpty
                            //     ? formatCurrency('0')
                            //     : formatCurrency(
                            //         "${total(subTotal(widget.invoiceType=='ACQUISITION'? invoiceDetails:serviceInvoiceDetails), tax(subTotal(widget.invoiceType=='ACQUISITION'? invoiceDetails:serviceInvoiceDetails)), serviceCharge(subTotal(widget.invoiceType=='ACQUISITION'? invoiceDetails:serviceInvoiceDetails)))}"),
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
                    const FormLabel(
                      text: 'Note',
                    ),
                    YBox(6),
                    AppTextField(
                      controller: noteController,
                      hintText: 'Some additional note for customer',
                      focusNode: noteFocusNode,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      maxLines: 5,
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 20.w, right: 20.w, bottom: 30.h, top: 15.h),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      border: Border.all(
                        color: AppColors.homeContainerBorderColor,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 150.w,
                          child: AppButton(
                            buttonText: 'Preview',
                            bgColor: AppColors.whiteColor,
                            borderColor: AppColors.textFormFieldBorderColor,
                            textColor: AppColors.primaryTextColor,
                            onPressed: () {
                              if (createInvoiceFormKey.currentState!
                                  .validate()) {
                                if (widget.invoiceType ==
                                        InvoiceType.ACQUISITION.name
                                    ? invoiceDetails.isEmpty
                                    : serviceInvoiceDetails.isEmpty) {
                                  showErrorToast(
                                      context, 'You need to add invoice item');
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return CreateInvoicePreviewScreen(
                                          ticketId: widget.ticketId,
                                          invoiceTitle: invoiceTitleController
                                              .text
                                              .trim(),
                                          // invoiceTitle: widget.invoiceTitle,
                                          dueDateController:
                                              dueDateController.text.trim(),
                                          note: noteController.text.trim(),
                                          invoiceDetails: invoiceDetails,
                                          customerName: widget.customerName,
                                          invoiceType: widget.invoiceType,
                                          serviceInvoiceDetails:
                                              serviceInvoiceDetails,
                                        );
                                      },
                                    ),
                                  );
                                }
                              }

                              // context.pushNamed(
                              //   AppRoute.createInvoicePreviewScreen.name,
                              //   queryParams: {
                              //     'ticketId': widget.ticketId,
                              //     'invoiceTitle': widget.invoiceTitle,
                              //     'customerName': widget.customerName,
                              //     'dueDateController':
                              //         dueDateController.text.trim(),
                              //     'note': noteController.text.trim(),
                              //     'invoiceDetails': invoiceDetails,
                              //   },
                              // );
                            },
                          ),
                        ),
                        SizedBox(
                          width: 150.w,
                          child: AppButton(
                            buttonText: 'Send',
                            bgColor: AppColors.primaryColor2,
                            borderColor: AppColors.primaryColor2,
                            onPressed: () {
                              if (createInvoiceFormKey.currentState!
                                  .validate()) {
                                if (widget.invoiceType ==
                                        InvoiceType.ACQUISITION.name
                                    ? invoiceDetails.isEmpty
                                    : serviceInvoiceDetails.isEmpty) {
                                  showErrorToast(
                                      context, 'You need to add invoice item');
                                } else {
                                  final createInvoiceReq = CreateInvoiceReq(
                                    ticket: widget.ticketId,
                                    title: invoiceTitleController.text.trim(),
                                    // title: widget.invoiceTitle,
                                    dueDate:
                                        DateTime.parse(dueDateController.text),
                                    notes: noteController.text.trim(),
                                    fields: widget.invoiceType ==
                                            InvoiceType.ACQUISITION.name
                                        ? invoiceDetails
                                        : serviceInvoiceDetails,
                                    type: widget.invoiceType,
                                  );
                                  ref
                                      .read(createInvoiceProvider.notifier)
                                      .createInvoice(
                                          createInvoiceReq: createInvoiceReq);
                                  context.loaderOverlay.show();
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}

class InvoiceItemDetailsWidget extends StatelessWidget {
  final String title;
  final String item;
  final double width;
  const InvoiceItemDetailsWidget({
    super.key,
    required this.width,
    required this.item,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.only(left: 5.w, top: 10.h, bottom: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          width: 1.w,
          color: AppColors.textFormFieldBorderColor,
        ),
      ),
      child: Text(
        item,
        style: AppTextStyle.interFontText(
          context,
          AppColors.headerTextColor1,
          16.sp,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
// class InvoiceItemDetailsWidget extends StatelessWidget {
//   final String title;
//   final String item;
//   final double width;
//   const InvoiceItemDetailsWidget({
//     super.key,
//     required this.width,
//     required this.item,
//     required this.title,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: AppTextStyle.satoshiFontText(
//             context,
//             AppColors.primaryTextColor,
//             14.sp,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         YBox(3.h),
//         Container(
//           width: width,
//           padding: EdgeInsets.only(left: 5.w, top: 10.h, bottom: 10.h),
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12.r),
//               border: Border.all(
//                 width: 1.w,
//                 color: AppColors.textFormFieldBorderColor,
//               )),
//           child: Text(
//             item,
//             style: AppTextStyle.interFontText(
//               context,
//               AppColors.headerTextColor1,
//               16.sp,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
