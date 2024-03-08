import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore_agent/lib.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final emailFocusNode = FocusNode();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //TODO: NO forgot password endpoint for agent forgot password
    // ref.listen<AsyncValue<SendOtpRes>>(forgotPasswordOtpProvider, (T, value) {
    //   if (value.hasValue) {
    //     FocusManager.instance.primaryFocus?.unfocus();
    //     context.loaderOverlay.hide();
    //     context.pushNamed(
    //       AppRoute.otpScreen.name,
    //       queryParams: {
    //         'email': emailController.text,
    //         'id': value.value!.data!.user!.id.toString()
    //       },
    //     );
    //   }
    //   if (value.hasError) {
    //     context.loaderOverlay.hide();
    //     showErrorToast(context, value.error.toString());
    //   }
    // });
    // final vm = ref.watch(forgotPasswordOtpProvider);
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
                          onTap: () => context.pop(),
                          child: Image.asset(AppIcon.backArrowIcon),
                        ),
                        YBox(5),
                        Text(
                          'Forgot password?',
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
                        YBox(50),
                        const FormLabel(
                          text: 'Email',
                        ),
                        YBox(6),
                        AppTextField(
                          controller: emailController,
                          hintText: 'isreaelbamidele@gmail.com',
                          focusNode: emailFocusNode,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) => Validator.validateEmail(value),
                          textInputAction: TextInputAction.done,
                          // onFieldSubmitted: (value) {
                          //   if (FormStringUtils.isNotEmpty(value)) {
                          //     emailFocusNode.requestFocus();
                          //   }
                          // },
                        ),
                      ],
                    ),
                    AppButton(
                      buttonText: 'Send OTP',
                      // isLoading: vm.isLoading,
                      bgColor: AppColors.primaryColor2,
                      onPressed: () {
                        // if (formKey.currentState!.validate()) {
                        //   ref
                        //       .read(forgotPasswordOtpProvider.notifier)
                        //       .forgotPasswordOtp(
                        //         emailController.text.trim(),
                        //       );
                        //   context.loaderOverlay.show();
                        // }
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
