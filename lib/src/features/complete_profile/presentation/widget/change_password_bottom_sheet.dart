import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore_agent/lib.dart';

class ChangePasswordBottomSheet extends ConsumerStatefulWidget {
  const ChangePasswordBottomSheet({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ChangePasswordBottomSheetState();
}

class _ChangePasswordBottomSheetState
    extends ConsumerState<ChangePasswordBottomSheet> {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final passwordFocusNode = FocusNode();
  final confirmPasswordController = TextEditingController();
  final confirmPasswordFocusNode = FocusNode();
  bool password = false;
  bool confirmPassword = false;
  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(changePasswordFirstTimeProvider);

    ref.listen<AsyncValue>(changePasswordFirstTimeProvider, (T, value) {
      if (value.hasValue) {
        showSuccessToast(context, 'Password Changed Successfuly');

        ref.invalidate(getUserDetailsProvider);
        context.pop();
        FocusManager.instance.primaryFocus?.unfocus();
      }
      if (value.hasError) {
        showErrorToast(context, value.error.toString());
        FocusManager.instance.primaryFocus?.unfocus();
      }
    });
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: 20.w, right: 20.w, top: 40.h, bottom: 60.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'New Password',
                          style: AppTextStyle.satoshiFontText(
                            context,
                            AppColors.headerTextColor2,
                            20.sp,
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
                    YBox(30),
                    const FormLabel(
                      text: 'New Password',
                    ),
                    YBox(6),
                    AppTextField(
                      hintText: '*******',
                      controller: passwordController,
                      obscureText: password ? false : true,
                      focusNode: passwordFocusNode,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) => Validator.validatePassword(value),
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
                      text: 'Retype Password',
                    ),
                    YBox(6),
                    AppTextField(
                      hintText: '*******',
                      controller: confirmPasswordController,
                      obscureText: confirmPassword ? false : true,
                      focusNode: confirmPasswordFocusNode,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) => Validator.validatePassword(value),
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
                    YBox(30),
                    AppButton(
                      buttonText: 'Save',
                      isLoading: vm.isLoading,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          final userId = PreferenceManager.userId;
                          ref
                              .read(changePasswordFirstTimeProvider.notifier)
                              .changePasswordFirstTime(
                                passwordController.text.trim(),
                                userId,
                              );
                        }
                        // context.goNamed(
                        //   AppRoute.registerConfirm.name,
                        // );
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
