import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meshwar/core/shared/widgets/texts.dart';
import 'package:meshwar/core/theme/colors/colors.dart';

//ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.prefixIcon,
  });

  final String text;
  final Function onPressed;
  Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        onPressed();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.00.w),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              ColorsManager.mainAppColor, // Start color
              Color(0xff8B4000),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(
              15.r), // Match border radius for consistency
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 50.00.w,
            vertical: 10.00.h,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              prefixIcon == null
                  ? const SizedBox()
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.00.w),
                      child: prefixIcon,
                    ),
              BoldText18dark(
                text: text,
                color: ColorsManager.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
