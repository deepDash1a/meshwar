import 'package:flutter/material.dart';
import 'package:meshwar/core/routing/routes.dart';
import 'package:meshwar/core/shared/widgets/custom_text_button.dart';
import 'package:meshwar/core/shared/widgets/texts.dart';

class DoNotHaveAnAccount extends StatelessWidget {
  const DoNotHaveAnAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const BoldText16dark(text: 'ليس لديّ حساب !'),
        CustomTextButton(
          text: 'سجل الآن',
          function: () {
            Navigator.pushNamed(context, Routes.register);
          },
        ),
      ],
    );
  }
}
