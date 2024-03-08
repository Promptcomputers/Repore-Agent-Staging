import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:repore_agent/lib.dart';

class ConfirmCreatePinScreen extends ConsumerStatefulWidget {
  final String pin;
  const ConfirmCreatePinScreen({
    super.key,
    required this.pin,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ConfirmCreatePinScreenState();
}

class _ConfirmCreatePinScreenState
    extends ConsumerState<ConfirmCreatePinScreen> {
  final formKey = GlobalKey<FormState>();
  final otpController = TextEditingController();
  String otpCode = '';
  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(createPinProvider);
    ref.listen<AsyncValue>(createPinProvider, (T, value) {
      if (value.hasValue) {
        showSuccessToast(context, 'Pin Created Successfuly');

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
      backgroundColor: AppColors.whiteColor,
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.only(top: 100.h, bottom: 30.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Confirm Pin',
                    style: AppTextStyle.josefinSansFont(
                      context,
                      AppColors.primaryTextColor,
                      24.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Just to be extra sure',
                    style: AppTextStyle.satoshiFontText(
                      context,
                      AppColors.headerTextColor1,
                      14.sp,
                    ),
                  ),
                  YBox(20),
                  Padding(
                    padding: EdgeInsets.only(left: 60.w, right: 60.w),
                    child: PinCodeTextField(
                      errorTextSpace: 32.sp,

                      enableActiveFill: true,
                      // backgroundColor: AppColors.secondaryColor3,
                      obscureText: true,
                      appContext: context,
                      cursorColor: AppColors.buttonBgColor2,
                      controller: otpController,
                      length: 4,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter OTP';
                        }
                        if (value != widget.pin) {
                          return "OTP doesn't match";
                        }
                        return null;
                      },
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        inactiveColor: AppColors.notificationReadCardColor,
                        activeColor: AppColors.notificationReadCardColor,
                        selectedColor: AppColors.notificationReadCardColor,
                        selectedFillColor: AppColors.notificationReadCardColor,
                        borderRadius: BorderRadius.circular(8.r),
                        fieldHeight: 50.h,
                        fieldWidth: 50.w,
                        activeFillColor: AppColors.notificationReadCardColor,
                        inactiveFillColor: AppColors.notificationReadCardColor,
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
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.h, right: 20.h),
                child: AppButton(
                  buttonText: 'Save & Continue',
                  isLoading: vm.isLoading,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      ref.read(createPinProvider.notifier).createPin(otpCode);
                      // context.pushNamed(
                      //   AppRoute.confirmCreatePinScreen.name,
                      // );

                      FocusManager.instance.primaryFocus?.unfocus();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
