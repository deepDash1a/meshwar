import 'package:flutter/material.dart';
import 'package:meshwar/core/shared/widgets/custom_text.dart';
import 'package:meshwar/core/theme/colors/colors.dart'; // If you're using screen util

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? textColor;
  final TextStyle? textStyle;
  final double? horizontalPadding;
  final double? verticalPadding;

  const CustomTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textColor,
    this.textStyle,
    this.horizontalPadding,
    this.verticalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: textColor ?? ColorsManager.darkOrange,
        // Default text color
        textStyle: textStyle ??
            const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
      ),
      child: CustomText(
        text: text,
      ),
    );
  }
}
