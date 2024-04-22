import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/helpers/extentions.dart';

import '../../../../core/routes/app_route.dart';
import '../../data/models/onboarding_model.dart';
import '../../logic/cubit/onboarding_cubit.dart';
import 'onboarding_button.dart';

class OnboardingWidget extends StatelessWidget {
  const OnboardingWidget({super.key, required this.onBoardingModel});

  final OnBoardingModel onBoardingModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          child: Image.asset(
            onBoardingModel.image,
            fit: BoxFit.fill,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 445.h,
              ),
              Text(
                onBoardingModel.title,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(
                height: 18.h,
              ),
              OnboardingButton(
                callbackAction: (){
                  if(BlocProvider.of<OnboardingCubit>(context).currentIndex!=2){
                    BlocProvider.of<OnboardingCubit>(context).changeIndex(BlocProvider.of<OnboardingCubit>(context).currentIndex+1);
                  }else{
                    context.pushReplacementNamed(Routes.loginScreen);
                  }
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
