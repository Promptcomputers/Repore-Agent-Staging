import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore_agent/lib.dart';

class WithdrawalScreen extends ConsumerStatefulWidget {
  const WithdrawalScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _WithdrawalScreenState();
}

class _WithdrawalScreenState extends ConsumerState<WithdrawalScreen> {
  final formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  final amountFocusNode = FocusNode();
  final bankIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(getUserBankDetails);
    List<GetBankDetailDatum> item =
        vm.maybeWhen(data: (e) => e.data, orElse: () => []);

    return LoadingSpinner(
      child: Scaffold(
        backgroundColor: AppColors.primarybgColor,
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            onTap: () => context.pop(),
            child: Image.asset(
              AppIcon.backArrowIcon2,
            ),
          ),
          title: Text(
            'Withdraw',
            style: AppTextStyle.josefinSansFont(
              context,
              AppColors.homeContainerBorderColor,
              20.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: AppColors.primaryColor,
          elevation: 0.0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: AppColors.primaryColor, // <-- SEE HERE
            statusBarIconBrightness:
                Brightness.light, //<-- For Android SEE HERE (dark icons)
            statusBarBrightness:
                Brightness.dark, //<-- For iOS SEE HERE (dark icons)
          ),
        ),
        body: SafeArea(
          child: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.only(
                  left: 20.w, right: 20.w, top: 50.h, bottom: 20.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const FormLabel(
                        text: 'Amount',
                      ),
                      YBox(6),
                      AppTextField(
                        controller: amountController,
                        hintText: 'Eg. \$100',
                        focusNode: amountFocusNode,
                        keyboardType: TextInputType.name,
                        validator: (value) => Validator.validateField(value,
                            errorMessage: 'amount  cannot be empty'),
                        onFieldSubmitted: (value) {
                          if (FormStringUtils.isNotEmpty(value)) {
                            amountFocusNode.requestFocus();
                          }
                        },
                      ),
                      YBox(20),
                      const FormLabel(
                        text: 'Withdraw to',
                      ),
                      YBox(6),
                      DropdownButtonFormField<GetBankDetailDatum>(
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 28.sp,
                          color: AppColors.headerTextColor1,
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a bank';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Select Bank",
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
                        // items: const [],
                        items: item.map((GetBankDetailDatum value) {
                          return DropdownMenuItem<GetBankDetailDatum>(
                            value: value,
                            child: Text(value.bankName),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            bankIdController.text = value!.id;
                          });
                        },
                      ),
                    ],
                  ),
                  AppButton(
                    buttonText: 'Withdraw',
                    onPressed: () {
                      showModalBottomSheet(
                        // backgroundColor: Colors.transparent,
                        barrierColor:
                            AppColors.primaryTextColor.withOpacity(1.0),
                        // shape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.vertical(
                        //     top: Radius.circular(20.0.sp),
                        //   ),
                        // ),
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => EnterPinWidget(
                          amount: amountController.text.trim(),
                          bankId: bankIdController.text.trim(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
