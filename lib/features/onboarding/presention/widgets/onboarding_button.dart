import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';


class OnboardingButton extends StatelessWidget {
   const OnboardingButton({super.key, required this.callbackAction});
  final VoidCallback callbackAction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      width: 50.w,
      child: ElevatedButton(
        onPressed: callbackAction,
        style:ElevatedButton.styleFrom(
          backgroundColor: AppColors.neutral9,
          padding: const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.w),
          ),
        ),
        child:SvgPicture.asset(
          AppAssets.rightArrow,
        ),
      ),
    );
  }
}


//ButtonStyle(
//           backgroundColor: WidgetStateProperty.all(AppColors.neutral9),
//           padding: WidgetStateProperty.all(const EdgeInsets.all(0)),
//           shape: WidgetStateProperty.all(
//             RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(6.w),
//             ),
//           ),
//         )