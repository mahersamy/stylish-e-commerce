import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../utils/text_style.dart';

class AppTheme {
  ThemeData lightTheme() {
    return ThemeData(
      primaryColor: AppColors.mainColor,
      textTheme: TextTheme(headlineLarge: TextStyles.font54WhiteBold,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(AppColors.mainColor),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.w),
            ),
          ),
        ),
      ),
    );
  }


  ThemeData darkTheme() {
    return ThemeData();
  }
}
