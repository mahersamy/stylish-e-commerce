import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../utils/text_style.dart';

class AppTheme {
  ThemeData lightTheme() {
    return ThemeData(
      primaryColor: AppColors.mainColor,
      textTheme: TextTheme(
        headlineLarge: TextStyles.font54WhiteBold,
        headlineMedium: TextStyles.font30BlackBold,
        bodySmall: TextStyles.body12px,
        labelSmall: TextStyles.body14px,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          // padding:WidgetStateProperty.all(EdgeInsets.symmetric(vertical: 10.h,horizontal: 120.w)),
          backgroundColor: WidgetStateProperty.all(AppColors.mainColor),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.w),
            ),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyles.body14px!.copyWith(color: AppColors.neutral4),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.neutral4),
        ),
        border:const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.mainColor),
        ),
      ),
    );
  }

  ThemeData darkTheme() {
    return ThemeData();
  }
}
