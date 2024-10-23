import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meshwar/core/theme/colors/colors.dart';
import 'package:meshwar/core/theme/fonts/fonts.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    super.key,
    required this.controller,
    required this.label,
    required this.validatorText,
    this.regexValidateText,
    this.obscureText = false,
    this.appRegex,
    this.suffixIcon,
    this.prefixIcon,
    this.textInputType,
    this.readOnly = false,
  });

  final TextEditingController controller;
  String? appRegex;
  bool obscureText;
  bool readOnly;
  final String label;
  Widget? prefixIcon;
  Widget? suffixIcon;
  TextInputType? textInputType;
  final String validatorText;
  String? regexValidateText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.00.r),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType,
        obscureText: obscureText,
        validator: (value) {
          // Check if the value is null or empty
          if (value == null || value.isEmpty) {
            return validatorText; // Return custom error message for empty input
          }
          // Perform regex validation
          final regex = RegExp(appRegex!);
          if (!regex.hasMatch(value)) {
            return regexValidateText; // Return custom error message for regex validation failure
          }
          return null; // Return null if validation passes
        },
        style: TextStyle(
          fontSize: 14.00.sp,
          fontFamily: FontNamesManager.regular,
          color: ColorsManager.mainAppColor,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            fontSize: 14.00.sp,
            fontFamily: FontNamesManager.bold,
            color: ColorsManager.mainAppColor,
          ),
          errorStyle: TextStyle(
            fontSize: 12.00.sp,
            color: ColorsManager.red,
            fontFamily: FontNamesManager.bold,
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 10.00.h,
            horizontal: 20.00.w,
          ),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.00.r),
            borderSide: BorderSide(
              color: ColorsManager.mainAppColor,
              width: 1.00.w,
            ),
          ),
        ),
        readOnly: readOnly,
      ),
    );
  }
}
