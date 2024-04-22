import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/helpers/extentions.dart';

import '../../../../core/routes/app_route.dart';
import '../../../../core/utils/app_colors.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
    context.pushReplacementNamed(Routes.onboardingScreen);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: AppColors.mainColor,
        ),
        Positioned(
            top: -117.h,
            right: -138.w,
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.primaryLighter2,
                shape: BoxShape.circle,
              ),
              width: 312.w,
              height: 313.h,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: SizedBox(
                  width: 312.w,
                  height: 313.h,
                ),
              ),
            )
        ),
        Positioned(
            top: 51.h,
            right: 136.w,
            child: Container(
              decoration:const  BoxDecoration(
                color: AppColors.primaryLighter,
                shape: BoxShape.circle,
              ),
              width: 312.w,
              height: 313.h,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: SizedBox(
                  width: 312.w,
                  height: 313.h,
                ),
              ),
            )
        ),
        Positioned(
            top: 549.h,
            right: -175.w,
            child: Container(
              decoration:const  BoxDecoration(
                color: AppColors.primaryDarker2,
                shape: BoxShape.circle,
              ),
              width: 312.w,
              height: 313.h,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: SizedBox(
                  width: 312.w,
                  height: 313.h,
                ),
              ),
            )
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 252.h,
            width: 252.w,
            decoration: BoxDecoration(
              color: AppColors.neutral9.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Container(
                height: 176.h,
                width: 176.w,
                decoration: BoxDecoration(
                  color: AppColors.neutral9.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    "S",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
