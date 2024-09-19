
import 'package:flutter/material.dart';
import 'package:stylish/core/utils/app_colors.dart';



class SearchTextField extends StatelessWidget {
   const SearchTextField({super.key, this.onFieldSubmitted, required this.controller});

  final TextEditingController controller;

   final void Function(String? string)? onFieldSubmitted; // Update the signature to match the expected type

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: onFieldSubmitted,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        hintText: "Search Product",
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.neutral4, width: 1.0),
            borderRadius: BorderRadius.circular(30.0),
          ),
        focusedBorder:  OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.mainColor, width: 1.0),
            borderRadius: BorderRadius.circular(30.0),
        ),



      )

    );
  }
}
