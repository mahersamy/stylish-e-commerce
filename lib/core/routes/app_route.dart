
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish/features/auth/logic/cubits/auth_cubit.dart';
import 'package:stylish/features/auth/presentions/screens/sign_up_screen.dart';
import 'package:stylish/features/home/presention/screens/home_layout.dart';

import '../../features/auth/presentions/screens/sign_in_screen.dart';
import '../../features/onboarding/logic/cubit/onboarding_cubit.dart';
import '../../features/onboarding/presention/screens/loading_screen.dart';
import '../../features/onboarding/presention/screens/onboarding_screen.dart';
import '../di/dependency_injection.dart';

class Routes {
  static const String initRoute = "/loadingScreen";

  static const String onboardingScreen = "/onboardingScreen";
  static const String signInScreen = "/signInScreen";
  static const String signUpScreen = "/signUpScreen";
  static const String homeLayout = "/homeLayout";



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
     case Routes.signInScreen:
        return MaterialPageRoute(builder: (_) =>
            const SignInScreen());
      case Routes.signUpScreen:
        return MaterialPageRoute(builder: (_) =>
            const SignUpScreen());
      case Routes.homeLayout:
        return MaterialPageRoute(builder: (_) => const HomeLayout());
    }
    return null;
  }

}



// class AppRoute2 {
//   Route? generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case Routes.initRoute:
//         return MaterialPageRoute(builder: (_) =>
//         const LoadingScreen());
//       case Routes.onboardingScreen:
//         return MaterialPageRoute(builder: (_) =>
//             BlocProvider(
//               create: (context) => getIt<OnboardingCubit>(),
//               child: const OnboardingScreen(),
//             ));
//       case Routes.signInScreen:
//         return MaterialPageRoute(builder: (_) =>
//             BlocProvider(
//               create: (context) => getIt<AuthCubit>(),
//               child: const SignInScreen(),
//             ));
//       case Routes.signUpScreen:
//         return MaterialPageRoute(builder: (_) =>
//             BlocProvider(
//               create: (context) => getIt<AuthCubit>(),
//               child: const SignUpScreen(),
//             ));
//     }
//     return null;
//   }
// }