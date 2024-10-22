import 'package:flutter/material.dart';
import 'package:meshwar/core/shared/widgets/custom_text_button.dart';
import 'package:meshwar/core/shared/widgets/texts.dart';

class AlreadyHaveAnAccountScreen extends StatelessWidget {
  const AlreadyHaveAnAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const BoldText16dark(text: ' لديّ حساب بالفعل!'),
        CustomTextButton(
          text: 'سجل الآن',
          function: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
