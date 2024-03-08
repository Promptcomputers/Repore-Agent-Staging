import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore_agent/lib.dart';

class AddProfileInfoBottomSheet extends ConsumerStatefulWidget {
  const AddProfileInfoBottomSheet({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddProfileInfoBottomSheetState();
}

class _AddProfileInfoBottomSheetState
    extends ConsumerState<AddProfileInfoBottomSheet> {
  final formKey = GlobalKey<FormState>();
  final addressController = TextEditingController();
  final addressFocusNode = FocusNode();
  final genderController = TextEditingController();
  final dobController = TextEditingController();
  final List<String> item = ['male', 'female'];
  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(updateProfileInfoProvider);

    ref.listen<AsyncValue>(updateProfileInfoProvider, (T, value) {
      if (value.hasValue) {
        showSuccessToast(context, 'Profile Info Added Successfuly');

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
                          'Profile info',
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
                      text: 'Address',
                    ),
                    YBox(6),
                    AppTextField(
                      controller: addressController,
                      hintText: '26059 Bianka Port',
                      focusNode: addressFocusNode,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,

                      // onFieldSubmitted: (value) {
                      //   if (FormStringUtils.isNotEmpty(value)) {
                      //     firstNameFocusNode.requestFocus(lastNameFocusNode);
                      //   }
                      // },
                    ),
                    YBox(20),
                    const FormLabel(
                      text: 'Gender',
                    ),
                    YBox(6),
                    DropdownButtonFormField<String>(
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 28.sp,
                        color: AppColors.headerTextColor1,
                      ),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select gender';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Select",
                        hintStyle: AppTextStyle.satoshiFontText(
                          context,
                          AppColors.headerTextColor1,
                          14.sp,
                        ),
                        border: const OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r),
                          borderSide: const BorderSide(
                              color: AppColors.textFormFieldBorderColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r),
                          borderSide: const BorderSide(
                              color: AppColors.textFormFieldBorderColor),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r),
                          borderSide:
                              const BorderSide(color: AppColors.redColor),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r),
                          borderSide:
                              const BorderSide(color: AppColors.redColor),
                        ),
                      ),
                      items: item.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(
                          () {
                            genderController.text = value!;
                          },
                        );
                      },
                    ),
                    YBox(20),
                    const FormLabel(
                      text: 'Date of Birth',
                    ),
                    YBox(6),
                    DateTimePicker(
                      dateMask: 'd/M/yyyy',
                      // autovalidate: true,
                      initialDate: DateTime(2000),
                      // firstDate: DateTime.now(),
                      // lastDate: DateTime.now(),
                      firstDate: DateTime(1976),
                      lastDate: DateTime(2000),
                      controller: dobController,
                      decoration: InputDecoration(
                        hintText: '00 - 00 - 0000',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r),
                          borderSide: const BorderSide(
                              color: AppColors.textFormFieldBorderColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r),
                          borderSide: BorderSide(
                              color: AppColors.textFormFieldBorderColor),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r),
                          borderSide:
                              const BorderSide(color: AppColors.redColor),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r),
                          borderSide:
                              const BorderSide(color: AppColors.redColor),
                        ),
                        labelStyle: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF86828D),
                        ),
                      ),
                      onChanged: (val) {
                        setState(() {});
                      },
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Date of birth is required';
                        }
                        return null;
                      },
                      onSaved: (val) => debugPrint(val),
                    ),
                    YBox(30),
                    AppButton(
                      buttonText: 'Save',
                      // isLoading: vm.isLoading,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          final userId = PreferenceManager.userId;
                          final userProfileReq = UpdateProfileReq(
                              company: '',
                              address: addressController.text.trim(),
                              city: '',
                              state: '',
                              zipcode: '',
                              gender: genderController.text.trim(),
                              dateOfBirth: dobController.text.trim(),

                              ///TODO: To remove or make it optional
                              phoneNo: '2149401881');
                          ref
                              .read(updateProfileInfoProvider.notifier)
                              .updateProfileInfo(
                                userId,
                                userProfileReq,
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
