import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:repore_agent/lib.dart';

class AddBankDetailsScreen extends ConsumerStatefulWidget {
  const AddBankDetailsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddBankDetailsScreenState();
}

class _AddBankDetailsScreenState extends ConsumerState<AddBankDetailsScreen> {
  final formKey = GlobalKey<FormState>();
  final acctNoController = TextEditingController();
  final acctNoFocusNode = FocusNode();
  final routingNoController = TextEditingController();
  final routingNoFocusNode = FocusNode();
  final accountNameController = TextEditingController();
  final accountNameFocusNode = FocusNode();
  final ssnController = TextEditingController();
  final ssnFocusNode = FocusNode();

  // Stripe.instance.createToken(CreateTokenParams.bankAccount(params: BankAccountTokenParams(accountNumber: accountNumber, country: country, currency: currency),),);
  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(addBankDetailsProvider, (T, value) {
      if (value.hasValue) {
        showSuccessToast(context, 'Bank Detail Added Successfuly');
        context.loaderOverlay.hide();
        ref.invalidate(getUserBankDetails);
        context.pop();
      }
      if (value.hasError) {
        showErrorToast(context, value.error.toString());
        context.loaderOverlay.hide();
      }
    });
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: LoadingSpinner(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.primarybgColor,
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
              ),
            ),
            title: Text(
              'Add Bank Details',
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
            child: Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.only(
                    left: 20.w, right: 20.w, top: 50.h, bottom: 20.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const FormLabel(
                        //   text: 'Bank Name',
                        // ),
                        // YBox(6.h),
                        // DropdownButtonFormField<List>(
                        //   icon: Icon(
                        //     Icons.keyboard_arrow_down_rounded,
                        //     size: 28.sp,
                        //     color: AppColors.headerTextColor1,
                        //   ),
                        //   validator: (value) {
                        //     if (value == null) {
                        //       return 'Please select a bank';
                        //     }
                        //     return null;
                        //   },
                        //   decoration: InputDecoration(
                        //     hintText: "Select Bank",
                        //     hintStyle: AppTextStyle.satoshiFontText(
                        //       context,
                        //       AppColors.headerTextColor1,
                        //       14.sp,
                        //     ),
                        //     border: const OutlineInputBorder(),
                        //     enabledBorder: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(16.r),
                        //       borderSide: const BorderSide(
                        //           color: AppColors.textFormFieldBorderColor),
                        //     ),
                        //     focusedBorder: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(16.r),
                        //       borderSide: const BorderSide(
                        //           color: AppColors.textFormFieldBorderColor),
                        //     ),
                        //     focusedErrorBorder: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(16.r),
                        //       borderSide:
                        //           const BorderSide(color: AppColors.redColor),
                        //     ),
                        //     errorBorder: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(16.r),
                        //       borderSide:
                        //           const BorderSide(color: AppColors.redColor),
                        //     ),
                        //   ),
                        //   items: const [],
                        //   // item.map((ServiceTypeDatum value) {
                        //   //   return DropdownMenuItem<ServiceTypeDatum>(
                        //   //     value: value,
                        //   //     child: Text(value.name),
                        //   //   );
                        //   // }).toList(),
                        //   onChanged: (value) {
                        //     // setState(() {
                        //     //   serviceTypeIdController.text = value!.id;
                        //     // });
                        //   },
                        // ),
                        YBox(20.h),
                        const FormLabel(
                          text: 'Account Number',
                        ),
                        YBox(6.h),
                        AppTextField(
                          controller: acctNoController,
                          hintText: '0123456789',
                          focusNode: acctNoFocusNode,
                          keyboardType: TextInputType.number,
                          validator: (value) => Validator.validateField(value,
                              errorMessage: 'Account number  cannot be empty'),
                          onFieldSubmitted: (value) {
                            if (FormStringUtils.isNotEmpty(value)) {
                              acctNoFocusNode.requestFocus();
                            }
                          },
                        ),
                        YBox(20.h),
                        const FormLabel(
                          text: 'Routing Number',
                        ),
                        YBox(6.h),
                        AppTextField(
                          controller: routingNoController,
                          hintText: '0123456789',
                          focusNode: routingNoFocusNode,
                          keyboardType: TextInputType.number,
                          validator: (value) => Validator.validateField(value,
                              errorMessage: 'Routing number  cannot be empty'),
                          onFieldSubmitted: (value) {
                            if (FormStringUtils.isNotEmpty(value)) {
                              routingNoFocusNode.requestFocus();
                            }
                          },
                        ),
                        YBox(20.h),
                        const FormLabel(
                          text: 'Account Name',
                        ),
                        YBox(6.h),
                        AppTextField(
                          controller: accountNameController,
                          hintText: 'John Doe',
                          focusNode: accountNameFocusNode,
                          keyboardType: TextInputType.name,
                          validator: (value) => Validator.validateField(value,
                              errorMessage: 'Account name  cannot be empty'),
                          onFieldSubmitted: (value) {
                            if (FormStringUtils.isNotEmpty(value)) {
                              routingNoFocusNode.requestFocus();
                            }
                          },
                        ),
                        YBox(20.h),
                        const FormLabel(
                          text: 'SSN (Last 4 digits)',
                        ),
                        YBox(6.h),
                        AppTextField(
                          controller: ssnController,
                          hintText: '0000',
                          focusNode: ssnFocusNode,
                          keyboardType: TextInputType.number,
                          validator: (value) => Validator.validateField(value,
                              errorMessage: 'Sssn  cannot be empty'),
                          onFieldSubmitted: (value) {
                            if (FormStringUtils.isNotEmpty(value)) {
                              ssnFocusNode.requestFocus();
                            }
                          },
                        ),
                        // YBox(20.h),
                        // const FormLabel(
                        //   text: 'Account name holder',
                        // ),
                        // YBox(6.h),
                        // AppTextField(
                        //   controller: routingNoController,
                        //   // hintText: 'Eg. My cool ticket name',
                        //   focusNode: routingNoFocusNode,
                        //   keyboardType: TextInputType.name,
                        //   validator: (value) => Validator.validateField(value,
                        //       errorMessage: 'account  cannot be empty'),
                        //   onFieldSubmitted: (value) {
                        //     if (FormStringUtils.isNotEmpty(value)) {
                        //       routingNoFocusNode.requestFocus();
                        //     }
                        //   },
                        // ),
                      ],
                    ),
                    AppButton(
                      buttonText: 'Add bank details',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          ref
                              .read(addBankDetailsProvider.notifier)
                              .addBankDetail(
                                  acctNoController.text.trim(),
                                  routingNoController.text.trim(),
                                  accountNameController.text.trim(),
                                  false,
                                  ssnController.text.trim());
                          context.loaderOverlay.show();
                          FocusManager.instance.primaryFocus?.unfocus();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
