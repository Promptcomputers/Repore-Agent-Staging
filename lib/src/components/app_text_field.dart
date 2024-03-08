import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:repore_agent/lib.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool obscureText;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? preffixIcon;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final int? maxLines;
  final InputBorder? enabledBorder;
  final InputBorder? border;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final bool enabled;
  final bool autofocus;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final bool? filled;
  final Color? filledColor;
  final Color? enabledBorderColor;
  final void Function()? onTap;
  final bool readOnly;
  final TextStyle? hintStyle;
  final TextInputAction? textInputAction;
  final void Function()? onEditingComplete;
  final String? initialValue;
  const AppTextField(
      {this.controller,
      this.focusNode,
      this.obscureText = false,
      this.onFieldSubmitted,
      this.validator,
      this.hintText,
      this.suffixIcon,
      this.preffixIcon,
      this.keyboardType,
      this.maxLines = 1,
      this.enabledBorder,
      this.border,
      this.focusedBorder,
      this.errorBorder,
      this.autofocus = false,
      this.enabled = true,
      this.inputFormatters,
      this.onChanged,
      this.filled,
      this.filledColor,
      this.enabledBorderColor,
      this.onTap,
      this.readOnly = false,
      this.hintStyle,
      this.textInputAction,
      this.onEditingComplete,
      this.initialValue,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      onTap: onTap,
      readOnly: readOnly,
      controller: controller,
      inputFormatters: inputFormatters,
      cursorColor: AppColors.buttonBgColor,
      focusNode: focusNode,
      enabled: enabled,
      autofocus: autofocus,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        filled: filled ?? false,
        fillColor: filledColor ?? Colors.transparent,
        hintText: hintText,
        hintStyle: hintStyle ??
            AppTextStyle.interFontText(
              context,
              AppColors.primaryTextColor2,
              14.sp,
              fontWeight: FontWeight.w400,
            ),
        suffixIcon: suffixIcon,
        prefixIcon: preffixIcon,
        border: border ?? const OutlineInputBorder(),
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide(
                  color:
                      enabledBorderColor ?? AppColors.textFormFieldBorderColor),
            ),
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: const BorderSide(color: AppColors.primaryColor2),
            ),
        focusedErrorBorder: focusedBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: const BorderSide(color: AppColors.redColor),
            ),
        errorBorder: errorBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: const BorderSide(color: AppColors.redColor),
            ),
      ),
    );
  }
}
