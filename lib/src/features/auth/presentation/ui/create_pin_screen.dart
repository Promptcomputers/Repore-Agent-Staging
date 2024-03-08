import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:repore_agent/lib.dart';

class CreatePinScreen extends StatefulWidget {
  final String isFromComplete;
  const CreatePinScreen({required this.isFromComplete, super.key});

  @override
  State<CreatePinScreen> createState() => _CreatePinScreenState();
}

class _CreatePinScreenState extends State<CreatePinScreen> {
  final formKey = GlobalKey<FormState>();
  final otpController = TextEditingController();
  String otpCode = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.only(top: 100.h, bottom: 30.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  // GestureDetector(
                  //   // onTap: () => context.pop(),
                  //   child: Image.asset(AppIcon.backArrowIcon),
                  // ),
                  Text(
                    'Add Pin',
                    style: AppTextStyle.josefinSansFont(
                      context,
                      AppColors.primaryTextColor,
                      24.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'This is for security purpose',
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
                  buttonText: 'Submit',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.pushReplacementNamed(
                          AppRoute.confirmCreatePinScreen.name,
                          params: {"pin": otpCode});

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
