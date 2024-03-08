import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:repore_agent/lib.dart';

class AutoLoginScreen extends ConsumerStatefulWidget {
  final String email;
  final String firstName;
  const AutoLoginScreen({
    super.key,
    required this.email,
    required this.firstName,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AutoLoginScreenState();
}

class _AutoLoginScreenState extends ConsumerState<AutoLoginScreen> {
  final formKey = GlobalKey<FormState>();

  final passwordController = TextEditingController();
  final passwordFocusNode = FocusNode();
  bool password = false;

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(loginProvider);
    ref.listen<AsyncValue>(loginProvider, (T, value) {
      if (value.hasValue) {
        context.pushReplacementNamed(
          AppRoute.bottomNavBar.name,
        );

        context.loaderOverlay.hide();
      }
      if (value.hasError) {
        showErrorToast(context, value.error.toString());
        context.loaderOverlay.hide();
      }
    });
    return LoadingSpinner(
      loadingText: 'Logging in',
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          // resizeToAvoidBottomInset: false,
          appBar: AppBar(
            centerTitle: false,
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.whiteColor,
            elevation: 0.0,
            toolbarHeight: 0.0,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: AppColors.whiteColor, // <-- SEE HERE
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
                padding: EdgeInsets.only(
                    left: 20.w, right: 20.w, top: 50.h, bottom: 30.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(AppIcon.logoMark),
                        YBox(10),
                        Text(
                          'Hi ${capitalizeFirstLetter(widget.firstName)},',
                          style: AppTextStyle.josefinSansFont(
                            context,
                            AppColors.primaryTextColor,
                            24.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        YBox(10),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text:
                                'Not ${capitalizeFirstLetter(widget.firstName)}? ',
                            style: AppTextStyle.satoshiFontText(
                              context,
                              AppColors.headerTextColor1,
                              14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    context.pushReplacementNamed(
                                        AppRoute.login.name);
                                  },
                                text: 'Log In',
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
                        // RichText(
                        //   textAlign: TextAlign.center,
                        //   text: TextSpan(
                        //     text:
                        //         'Not ${capitalizeFirstLetter(widget.firstName)}? ',
                        //     style: AppTextStyle.satoshiFontText(
                        //       context,
                        //       AppColors.headerTextColor1,
                        //       14.sp,
                        //       fontWeight: FontWeight.w400,
                        //     ),
                        //     children: <TextSpan>[
                        //       TextSpan(
                        //         recognizer: TapGestureRecognizer()
                        //           ..onTap = () {
                        //             // PreferenceManager.clear();
                        //             // context.pushReplacementNamed(
                        //             //   AppRoute.register.name,
                        //             // );
                        //           },
                        //         text: 'Sign up',
                        //         style: AppTextStyle.satoshiFontText(
                        //           context,
                        //           AppColors.primaryColor2,
                        //           14.sp,
                        //           fontWeight: FontWeight.w700,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        YBox(30),
                        const FormLabel(
                          text: 'Password',
                        ),
                        YBox(6),
                        AppTextField(
                          hintText: '*******',
                          controller: passwordController,
                          obscureText: password ? false : true,
                          focusNode: passwordFocusNode,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
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
                        YBox(10),
                        GestureDetector(
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            // context.pushNamed(
                            //   AppRoute.forgotPassword.name,
                            // );
                          },
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              'Forgot password?',
                              style: AppTextStyle.satoshiFontText(
                                context,
                                AppColors.redColor,
                                16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    AppButton(
                      buttonText: 'Login',
                      onPressed: vm.isLoading
                          ? null
                          : () {
                              if (formKey.currentState!.validate()) {
                                FocusManager.instance.primaryFocus?.unfocus();
                                ref.read(loginProvider.notifier).login(
                                      widget.email.trim(),
                                      passwordController.text.trim(),
                                    );
                                context.loaderOverlay.show();
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
