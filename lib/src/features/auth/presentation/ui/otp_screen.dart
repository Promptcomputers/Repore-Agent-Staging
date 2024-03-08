import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:repore_agent/lib.dart';

class OtpScreen extends ConsumerStatefulWidget {
  final String email;
  final String id;
  const OtpScreen({required this.email, required this.id, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  final formKey = GlobalKey<FormState>();
  final otpController = TextEditingController();
  String otpCode = '';

  @override
  void dispose() {
    // otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final vm = ref.watch(verifyOtpProvider);
    // final resendOtpVm = ref.watch(forgotPasswordOtpProvider);
    // ref.listen<AsyncValue>(verifyOtpProvider, (T, value) {
    //   if (value.hasValue) {
    //     FocusManager.instance.primaryFocus?.unfocus();
    //     showSuccessToast(context, 'Success');
    //     context.loaderOverlay.hide();

    //     context.pushNamed(AppRoute.changePassword.name, params: {
    //       'id': widget.id,
    //     });
    //   }
    //   if (value.hasError) {
    //     context.loaderOverlay.hide();
    //     showErrorToast(context, value.error.toString());
    //   }
    // });
    // ref.listen<AsyncValue<SendOtpRes>>(forgotPasswordOtpProvider, (T, value) {
    //   if (value.hasValue) {
    //     FocusManager.instance.primaryFocus?.unfocus();
    //     showSuccessToast(context, "Otp Resend");
    //   }
    //   if (value.hasError) {
    //     showErrorToast(context, value.error.toString());
    //   }
    // });
    return LoadingSpinner(
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          body: SafeArea(
            child: Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.only(
                    left: 20.w, right: 20.w, top: 50.h, bottom: 30.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          // onTap: () => context.pop(),
                          child: Image.asset(AppIcon.backArrowIcon),
                        ),
                        YBox(5),
                        Text(
                          'OTP Verification',
                          style: AppTextStyle.josefinSansFont(
                            context,
                            AppColors.primaryTextColor,
                            24.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        YBox(10),
                        Text(
                          'Enter the email you Sign up on Repore with',
                          style: AppTextStyle.satoshiFontText(
                            context,
                            AppColors.headerTextColor1,
                            14.sp,
                          ),
                        ),
                        YBox(30),
                        PinCodeTextField(
                          errorTextSpace: 32.sp,

                          enableActiveFill: true,
                          // backgroundColor: AppColors.secondaryColor3,
                          obscureText: true,
                          appContext: context,
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
                            inactiveColor: AppColors.textFormFieldBorderColor,
                            activeColor: AppColors.textFormFieldBorderColor,
                            selectedColor: AppColors.textFormFieldBorderColor,
                            selectedFillColor: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(8.r),
                            fieldHeight: 50.h,
                            fieldWidth: 50.w,
                            activeFillColor: AppColors.whiteColor,
                            inactiveFillColor: AppColors.whiteColor,
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
                        YBox(9),
                        Align(
                          alignment: Alignment.center,
                          child:
                              //TODO:
                              // resendOtpVm.isLoading
                              //     ? CircularProgressIndicator.adaptive()
                              //     :
                              RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'Didn’t receive a code? ',
                              style: AppTextStyle.satoshiFontText(
                                context,
                                AppColors.headerTextColor1,
                                14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // ref
                                      //     .read(forgotPasswordOtpProvider
                                      //         .notifier)
                                      //     .forgotPasswordOtp(
                                      //       widget.email,
                                      //     );
                                    },
                                  text: ' Request again',
                                  style: AppTextStyle.satoshiFontText(
                                    context,
                                    AppColors.buttonBgColor,
                                    14.sp,
                                    fontWeight: FontWeight.w700,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    AppButton(
                        // isLoading: vm.isLoading,
                        buttonText: 'Save Changes',
                        onPressed: () {
                          // if (formKey.currentState!.validate()) {
                          if (otpController.text.isEmpty) {
                            showErrorToast(context, "Please enter OTP");
                          } else if (otpController.text.length < 4) {
                            showErrorToast(
                                context, "Please enter otp completely");
                          } else {
                            // ref.read(verifyOtpProvider.notifier).verifyOtp(
                            //       email: widget.email,
                            //       userId: widget.id,
                            //       otpCode: otpController.text.trim(),
                            //     );
                            // context.loaderOverlay.show();
                          }
                        }
                        // },
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
