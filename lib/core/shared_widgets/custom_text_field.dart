import 'package:flutter/material.dart';

import '../utils/app_colors.dart';



class CustomTextField extends StatelessWidget {
  final bool isPassword;
  final String hintText;
  final TextEditingController controller;
  final IconData? icon;
  final VoidCallback? suffixIconOnPressed;
  final TextInputType textInputType;
  final String? Function(String? value)? validation;

  const CustomTextField({super.key, required this.isPassword, required this.hintText, required this.controller, this.icon, this.suffixIconOnPressed, required this.textInputType, this.validation});




  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      validator: validation,
      keyboardType: textInputType,
      controller: controller,
      cursorColor: AppColors.mainColor,
      decoration: InputDecoration(
        focusColor: AppColors.mainColor,
        suffixIcon: IconButton(
          icon: Icon(
            icon,
            color: AppColors.mainColor,
          ),
          onPressed: suffixIconOnPressed,
        ),
        label: Text(hintText),
        enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
        focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
        errorBorder: Theme.of(context).inputDecorationTheme.errorBorder,
        hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
      ),
    );
  }
}
