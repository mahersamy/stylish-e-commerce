import 'package:flutter/material.dart';
import 'package:stylish/core/utils/app_colors.dart';




class CustomCircular extends StatelessWidget {
  const CustomCircular({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      color: AppColors.mainColor,
    );
  }
}
