import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore_agent/lib.dart';

class AddBankDetailsBottomSheet extends ConsumerStatefulWidget {
  const AddBankDetailsBottomSheet({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddBankDetailsBottomSheetState();
}

class _AddBankDetailsBottomSheetState
    extends ConsumerState<AddBankDetailsBottomSheet> {
  final formKey = GlobalKey<FormState>();
  final acctNoController = TextEditingController();
  final acctNoFocusNode = FocusNode();
  final routingNoController = TextEditingController();
  final routingNoFocusNode = FocusNode();
  final accountNameController = TextEditingController();
  final accountNameFocusNode = FocusNode();
  final ssnController = TextEditingController();
  final ssnFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(addBankDetailsProvider);
    ref.listen<AsyncValue>(addBankDetailsProvider, (T, value) {
      if (value.hasValue) {
        showSuccessToast(context, 'Bank Detail Added Successfully');

        ref.invalidate(getUserBankDetails);
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
                          'Bank details',
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
                      text: 'Account Number',
                    ),
                    YBox(6),
                    AppTextField(
                      controller: acctNoController,
                      hintText: '0123456789',
                      focusNode: acctNoFocusNode,
                      keyboardType: TextInputType.number,
                      validator: (value) => Validator.validateField(value,
                          errorMessage: 'Account number  cannot be empty'),
                      onFieldSubmitted: (value) {
                        if (FormStringUtils.isNotEmpty(value)) {
                          acctNoFocusNode.requestFocus();
                        }
                      },
                    ),
                    YBox(20),
                    const FormLabel(
                      text: 'Routing Number',
                    ),
                    YBox(6),
                    AppTextField(
                      controller: routingNoController,
                      hintText: '0123456789',
                      focusNode: routingNoFocusNode,
                      keyboardType: TextInputType.number,
                      validator: (value) => Validator.validateField(value,
                          errorMessage: 'Routing number  cannot be empty'),
                      onFieldSubmitted: (value) {
                        if (FormStringUtils.isNotEmpty(value)) {
                          routingNoFocusNode.requestFocus();
                        }
                      },
                    ),
                    YBox(20),
                    const FormLabel(
                      text: 'Account Name',
                    ),
                    YBox(6),
                    AppTextField(
                      controller: accountNameController,
                      hintText: 'John Doe',
                      focusNode: accountNameFocusNode,
                      keyboardType: TextInputType.name,
                      validator: (value) => Validator.validateField(value,
                          errorMessage: 'Account name  cannot be empty'),
                      onFieldSubmitted: (value) {
                        if (FormStringUtils.isNotEmpty(value)) {
                          routingNoFocusNode.requestFocus();
                        }
                      },
                    ),
                    YBox(20),
                    const FormLabel(
                      text: 'SSN (Last 4 digits)',
                    ),
                    YBox(6),
                    AppTextField(
                      controller: ssnController,
                      hintText: '0000',
                      focusNode: ssnFocusNode,
                      keyboardType: TextInputType.number,
                      validator: (value) => Validator.validateField(value,
                          errorMessage: 'Sssn  cannot be empty'),
                      onFieldSubmitted: (value) {
                        if (FormStringUtils.isNotEmpty(value)) {
                          ssnFocusNode.requestFocus();
                        }
                      },
                    ),
                    YBox(30),
                    AppButton(
                      buttonText: 'Save',
                      isLoading: vm.isLoading,
                      onPressed:
                          // vm.isLoading
                          // ? null
                          // :
                          () {
                        if (formKey.currentState!.validate()) {
                          ref
                              .read(addBankDetailsProvider.notifier)
                              .addBankDetail(
                                acctNoController.text.trim(),
                                routingNoController.text.trim(),
                                accountNameController.text.trim(),
                                false,
                                ssnController.text.trim(),
                              );

                          FocusManager.instance.primaryFocus?.unfocus();
                        }
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
