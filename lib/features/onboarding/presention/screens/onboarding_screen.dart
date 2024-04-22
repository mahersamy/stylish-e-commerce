import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../logic/cubit/onboarding_cubit.dart';
import '../widgets/onboarding_widget.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        return Stack(
          children: [
            PageView.builder(
                onPageChanged: (value) {
                  BlocProvider.of<OnboardingCubit>(context).changeIndex(value);
                },
                controller:
                    BlocProvider.of<OnboardingCubit>(context).pageController,
                itemCount: BlocProvider.of<OnboardingCubit>(context)
                    .listOfScreen
                    .length,
                itemBuilder: (context, index) {
                  return OnboardingWidget(
                    onBoardingModel: BlocProvider.of<OnboardingCubit>(context)
                        .listOfScreen[index],
                  );
                }),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(right: 25.w, bottom: 35.h),
                child: SmoothPageIndicator(
                    controller: BlocProvider.of<OnboardingCubit>(context)
                        .pageController, // PageController
                    count: 3,
                    effect: SlideEffect(
                        spacing: 8.0,
                        radius: 4.0,
                        dotWidth:10,
                        dotHeight: 10,
                        paintStyle: PaintingStyle.stroke,
                        strokeWidth: 1.5,
                        dotColor: Colors.grey,
                        activeDotColor: Theme.of(context).primaryColor), // your preferred effect
                    onDotClicked: (index) {
                      BlocProvider.of<OnboardingCubit>(context)
                          .changeIndex(index);
                    }),
              ),
            )
          ],
        );
      },
    );
  }
}
