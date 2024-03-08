import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:repore_agent/lib.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final oldPasswordController = TextEditingController();
  final oldPasswordFocusNode = FocusNode();
  final newPasswordController = TextEditingController();
  final newPasswordFocusNode = FocusNode();
  final confirmNewPasswordController = TextEditingController();
  final confirmNewPasswordFocusNode = FocusNode();
  bool password = false;
  bool confirmPassword = false;
  bool confirmNewPassword = false;

  @override
  void dispose() {
    // oldPasswordController.dispose();
    // newPasswordController.dispose();
    // confirmNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              // child: Icon(
              //   Icons.arrow_back_ios,
              //   color: AppColors.whiteColor,
              // )
              child: Image.asset(
                AppIcon.backArrowIcon2,
              ),
            ),
            title: Text(
              'Change Password',
              style: AppTextStyle.josefinSansFont(
                context,
                AppColors.homeContainerBorderColor,
                20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            backgroundColor: AppColors.primaryColor,
            elevation: 0.0,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: AppColors.primaryColor, // <-- SEE HERE
              statusBarIconBrightness:
                  Brightness.dark, //<-- For Android SEE HERE (dark icons)
              statusBarBrightness:
                  Brightness.dark, //<-- For iOS SEE HERE (dark icons)
            ),
          ),
          body: SafeArea(
            child: Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 30.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const FormLabel(
                          text: 'Old Password',
                        ),
                        YBox(6),
                        AppTextField(
                          hintText: '*******',
                          controller: oldPasswordController,
                          obscureText: password ? false : true,
                          focusNode: oldPasswordFocusNode,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) =>
                              Validator.validatePassword(value),
                          textInputAction: TextInputAction.next,
                          // onFieldSubmitted: (value) {
                          //   if (FormStringUtils.isNotEmpty(value)) {
                          //     oldPasswordFocusNode.requestFocus();
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
                          text: 'New Password',
                        ),
                        YBox(6),
                        AppTextField(
                          hintText: '*******',
                          controller: newPasswordController,
                          obscureText: confirmPassword ? false : true,
                          focusNode: newPasswordFocusNode,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) =>
                              Validator.validatePassword(value),
                          textInputAction: TextInputAction.next,
                          // onFieldSubmitted: (value) {
                          //   if (FormStringUtils.isNotEmpty(value)) {
                          //     newPasswordFocusNode.requestFocus();
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
                        YBox(20),
                        const FormLabel(
                          text: 'Re-enter Password',
                        ),
                        YBox(6),
                        AppTextField(
                          hintText: '*******',
                          controller: confirmNewPasswordController,
                          obscureText: confirmNewPassword ? false : true,
                          focusNode: confirmNewPasswordFocusNode,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) =>
                              Validator.validateConfirmPassword(
                                  value, newPasswordController.text),
                          textInputAction: TextInputAction.done,
                          // onFieldSubmitted: (value) {
                          //   if (FormStringUtils.isNotEmpty(value)) {
                          //     confirmNewPasswordFocusNode.requestFocus();
                          //   }
                          // },
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                confirmNewPassword = !confirmNewPassword;
                              });
                            },
                            child: Icon(
                              confirmNewPassword
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
                          final userId = PreferenceManager.userId;
                          ref
                              .read(changePasswordProvider.notifier)
                              .changePassword(
                                oldPasswordController.text.trim(),
                                newPasswordController.text.trim(),
                                userId,
                              );
                          context.loaderOverlay.show();
                        }
                        // context.goNamed(
                        //   AppRoute.registerConfirm.name,
                        // );
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
