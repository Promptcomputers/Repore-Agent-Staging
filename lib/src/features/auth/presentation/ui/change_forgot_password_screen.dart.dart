import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore_agent/lib.dart';

class ChangeForgotPasswordScreen extends ConsumerStatefulWidget {
  final String id;
  const ChangeForgotPasswordScreen({required this.id, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ChangeForgotPasswordScreenState();
}

class _ChangeForgotPasswordScreenState
    extends ConsumerState<ChangeForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final passwordFocusNode = FocusNode();
  final confirmPasswordController = TextEditingController();
  final confirmPasswordFocusNode = FocusNode();
  bool password = false;
  bool confirmPassword = false;

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ref.listen<AsyncValue>(changeForgotPasswordProvider, (T, value) {
    //   if (value.hasValue) {
    //     FocusManager.instance.primaryFocus?.unfocus();
    //     showSuccessToast(context, 'Password reset successfuly, please login');
    //     context.loaderOverlay.hide();
    //     context.pushReplacementNamed(
    //       AppRoute.login.name,
    //     );
    //   }
    //   if (value.hasError) {
    //     context.loaderOverlay.hide();
    //     showErrorToast(context, value.error.toString());
    //   }
    // });
    // final vm = ref.watch(changeForgotPasswordProvider);
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
                          'Reset Password',
                          style: AppTextStyle.josefinSansFont(
                            context,
                            AppColors.primaryTextColor,
                            24.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        YBox(10),
                        Text(
                          'Use a simple but clever password',
                          style: AppTextStyle.satoshiFontText(
                            context,
                            AppColors.headerTextColor1,
                            14.sp,
                          ),
                        ),
                        YBox(50),
                        const FormLabel(
                          text: 'New password',
                        ),
                        YBox(6),
                        AppTextField(
                          hintText: '*******',
                          controller: passwordController,
                          obscureText: password ? false : true,
                          focusNode: passwordFocusNode,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.next,
                          validator: (value) =>
                              Validator.validatePassword(value),
                          // onFieldSubmitted: (value) {
                          //   if (FormStringUtils.isNotEmpty(value)) {
                          //     passwordFocusNode.requestFocus();
                          //   }
                          // },
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                password = !password;
                              });
                            },
                            child: Icon(
                              password
                                  ? Icons.visibility_off
                                  : Icons.visibility_sharp,
                              color: AppColors.headerTextColor1,
                            ),
                          ),
                        ),
                        YBox(20),
                        const FormLabel(
                          text: 'Re type password',
                        ),
                        YBox(6),
                        AppTextField(
                          hintText: '*******',
                          controller: confirmPasswordController,
                          obscureText: confirmPassword ? false : true,
                          focusNode: confirmPasswordFocusNode,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) =>
                              Validator.validateConfirmPassword(
                                  value, passwordController.text),
                          textInputAction: TextInputAction.done,
                          // onFieldSubmitted: (value) {
                          //   if (FormStringUtils.isNotEmpty(value)) {
                          //     passwordFocusNode.requestFocus();
                          //   }
                          // },
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                confirmPassword = !confirmPassword;
                              });
                            },
                            child: Icon(
                              confirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility_sharp,
                              color: AppColors.headerTextColor1,
                            ),
                          ),
                        ),
                      ],
                    ),
                    AppButton(
                      buttonText: 'Save changes',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          // ref
                          //     .read(changeForgotPasswordProvider.notifier)
                          //     .forgotChangePassword(
                          //       newPassword:
                          //           passwordController.text.trim(),
                          //       userId: widget.id,
                          //     );
                          // context.loaderOverlay.show();
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
