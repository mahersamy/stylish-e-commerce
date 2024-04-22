
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/onboarding/logic/cubit/onboarding_cubit.dart';
import '../../features/onboarding/presention/screens/loading_screen.dart';
import '../../features/onboarding/presention/screens/onboarding_screen.dart';
import '../di/dependency_injection.dart';

class Routes {
  static const String initRoute = "/loadingScreen";

  static const String onboardingScreen = "/onboardingScreen";
  static const String loginScreen = "/loginScreen";


}

class AppRoute {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initRoute:
        return MaterialPageRoute(builder: (_) =>
            const LoadingScreen());
      case Routes.onboardingScreen:
        return MaterialPageRoute(builder: (_) =>
            BlocProvider(
              create: (context) => getIt<OnboardingCubit>(),
              child: const OnboardingScreen(),
            ));
     // case Routes.loginScreen:
     //    return MaterialPageRoute(builder: (_) =>
     //        BlocProvider(
     //          create: (context) => getIt<OnboardingCubit>(),
     //          child: const SignInScreen(),
     //        ));
    }
    return null;
  }

}