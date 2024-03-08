import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:repore_agent/lib.dart';

///Staging login
///obaro@promptcomputers.io
/// @Tester10

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordController = TextEditingController();
  final passwordFocusNode = FocusNode();
  bool password = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(loginProvider);
    ref.listen<AsyncValue>(loginProvider, (T, value) {
      if (value.hasValue) {
        ///TODO: Check if user is logging for the first time, if yes direct to create pinscreen
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
                  Brightness.light, //<-- For iOS SEE HERE (dark icons)
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
                          'Log In',
                          style: AppTextStyle.josefinSansFont(
                            context,
                            AppColors.primaryTextColor,
                            24.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        // YBox(10.h),
                        // // Text(
                        // //   'Log In to see your progress',
                        // //   style: AppTextStyle.bodyText(
                        // //     context,
                        // //     AppColors.headerTextColor1,
                        // //     14.sp,
                        // //   ),
                        // // ),
                        // RichText(
                        //   textAlign: TextAlign.center,
                        //   text: TextSpan(
                        //     text: 'New user? ',
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
                          text: 'Email',
                        ),
                        YBox(6),
                        AppTextField(
                          controller: emailController,
                          hintText: 'isreaelbamidele@gmail.com',
                          focusNode: emailFocusNode,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: (value) => Validator.validateEmail(value),
                          // onFieldSubmitted: (value) {
                          //   if (FormStringUtils.isNotEmpty(value)) {
                          //     emailFocusNode.requestFocus();
                          //   }
                          // },
                        ),
                        YBox(20),
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
                        // YBox(10.h),
                        // GestureDetector(
                        //   onTap: () {
                        //     FocusManager.instance.primaryFocus?.unfocus();
                        //     // context.pushNamed(
                        //     //   AppRoute.forgotPassword.name,
                        //     // );
                        //   },
                        //   child: Align(
                        //     alignment: Alignment.topRight,
                        //     child: Text(
                        //       'Forgot password?',
                        //       style: AppTextStyle.satoshiFontText(
                        //         context,
                        //         AppColors.redColor,
                        //         16.sp,
                        //         fontWeight: FontWeight.w500,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    AppButton(
                      buttonText: 'Login',
                      // isLoading: vm.isLoading,
                      onPressed: vm.isLoading
                          ? null
                          : () {
                              if (formKey.currentState!.validate()) {
                                // context.pushNamed(
                                //   AppRoute.createPinScreen.name,
                                // );
                                ref.read(loginProvider.notifier).login(
                                      emailController.text.trim(),
                                      passwordController.text.trim(),
                                    );
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
