import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class TextStyles{
  static TextStyle? font54WhiteBold = TextStyle(
    fontSize: 54.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.neutral9,
  );
  static TextStyle? font30BlackBold = TextStyle(
    fontSize: 27.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.neutral1,
  );

  static TextStyle? body14px = TextStyle(fontSize: 14.sp,color: AppColors.neutral9);
  static TextStyle? body12px = TextStyle(fontSize: 12.sp,color: AppColors.mainColor);

}