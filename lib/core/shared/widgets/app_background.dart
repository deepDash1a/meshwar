import 'package:flutter/material.dart';
import 'package:meshwar/core/theme/images/images.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            ImagesManager.background,
          ),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
