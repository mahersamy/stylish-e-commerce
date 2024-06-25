import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class TextStyles{
  static TextStyle? font54WhiteBold = TextStyle(
    fontSize: 54.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.neutral9,
  );
  static TextStyle? font27BlackBold = TextStyle(
    fontSize: 27.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.neutral1,
  );


  static TextStyle? font20BlackBold = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.neutral1,
  );

  static TextStyle? body14px = TextStyle(fontSize: 14.sp,color: AppColors.neutral1);
  static TextStyle? body12px = TextStyle(fontSize: 12.sp,color: AppColors.mainColor);
  static TextStyle? body8px = TextStyle(fontSize: 8.sp,color: AppColors.neutral9);


}