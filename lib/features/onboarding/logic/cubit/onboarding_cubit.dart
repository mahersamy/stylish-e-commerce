import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_strings.dart';
import '../../data/models/onboarding_model.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());

  List<OnBoardingModel> listOfScreen=[
    OnBoardingModel(title: AppStrings.onBoardingTitle1, image: AppAssets.onboardingImage1),
    OnBoardingModel(title: AppStrings.onBoardingTitle2, image: AppAssets.onboardingImage2),
    OnBoardingModel(title: AppStrings.onBoardingTitle3, image: AppAssets.onboardingImage3),

  ];
  int currentIndex=0;
  PageController pageController = PageController();


  void changeIndex(int index){
    pageController.animateToPage(index,duration: const Duration(milliseconds: 500),curve: Curves.easeInOut);
    currentIndex=index;
    emit(OnboardingChanged());
  }

}
