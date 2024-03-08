import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:repore_agent/lib.dart';

class EnterPinWidget extends ConsumerStatefulWidget {
  final String amount;
  final String bankId;
  const EnterPinWidget({required this.amount, required this.bankId, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EnterPinWidgetState();
}

class _EnterPinWidgetState extends ConsumerState<EnterPinWidget> {
  final formKey = GlobalKey<FormState>();
  final otpController = TextEditingController();
  String otpCode = '';
  @override
  Widget build(BuildContext context) {
    final withdrawlVm = ref.watch(withdrawalProvider);

    ref.listen<AsyncValue>(withdrawalProvider, (T, value) {
      if (value.hasValue) {
        ref.invalidate(getUserBankDetails);
        ref.invalidate(getAllTransactionProvider);
        ref.invalidate(getUserBalanceProvider);
        // showSuccessToast(context, 'Withdrawal Successfuly');
        context.pushReplacementNamed(AppRoute.withdrawalPendingScreen.name);
        // context.pop();
        // context.pop();
        ref.invalidate(getUserBankDetails);
      }
      if (value.hasError) {
        showErrorToast(context, value.error.toString());
      }
    });
    return Form(
      key: formKey,
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          color: AppColors.whiteColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: 20.w, right: 20.w, top: 40.h, bottom: 50.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(),
                        Text(
                          'Enter pin',
                          style: AppTextStyle.josefinSansFont(
                            context,
                            AppColors.primaryTextColor,
                            24.sp,
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
                    YBox(20),
                    Padding(
                      padding: EdgeInsets.only(left: 25.w, right: 25.w),
                      child: PinCodeTextField(
                        errorTextSpace: 32.sp,

                        enableActiveFill: true,
                        // backgroundColor: AppColors.secondaryColor3,
                        obscureText: true,
                        appContext: context,
                        controller: otpController,
                        length: 4,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter pin';
                          }
                          return null;
                        },
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          inactiveColor: AppColors.textFormFieldBorderColor,
                          activeColor: AppColors.textFormFieldBorderColor,
                          selectedColor: AppColors.textFormFieldBorderColor,
                          selectedFillColor: AppColors.textFormFieldBorderColor,
                          borderRadius: BorderRadius.circular(8.r),
                          fieldHeight: 50.h,
                          fieldWidth: 50.w,
                          activeFillColor: AppColors.textFormFieldBorderColor,
                          inactiveFillColor: AppColors.textFormFieldBorderColor,
                          fieldOuterPadding: const EdgeInsets.all(3),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          Console.print(value);
                          // pinValue = value;
                          // print(pinValue);
                          setState(() {
                            otpCode = value;
                          });
                        },
                      ),
                    ),
                    YBox(40),
                    AppButton(
                      buttonText: 'Continue',
                      isLoading: withdrawlVm.isLoading,
                      bgColor: AppColors.buttonBgColor2,
                      borderColor: AppColors.buttonBgColor2,
                      onPressed: () {
                        ref.read(withdrawalProvider.notifier).withdraw(
                              widget.amount,
                              widget.bankId,
                              otpController.text.trim(),
                            );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
