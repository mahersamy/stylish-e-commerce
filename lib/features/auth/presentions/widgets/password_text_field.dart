import 'package:flutter/material.dart';
import 'package:stylish/core/shared_widgets/custom_text_field.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({super.key, required this.controller, required this.hintText, required this.validation});
  final TextEditingController controller;
  final String hintText;
  final String? Function(String? value)? validation;
  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {

  IconData icon = Icons.visibility_off;
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      isPassword: isVisible,
      hintText: widget.hintText,
      controller: widget.controller,
      textInputType: TextInputType.visiblePassword,
      icon: icon,
      suffixIconOnPressed: (){
        setState(() {
          if(icon == Icons.visibility_off){
            icon = Icons.visibility;
            isVisible = false;
          }else{
            icon = Icons.visibility_off;
            isVisible = true;
          }
        });
      },
      validation: widget.validation,

    );
  }
}
