import 'package:get_it/get_it.dart';

import '../../features/onboarding/logic/cubit/onboarding_cubit.dart';

GetIt getIt = GetIt.instance;

Future<void> setupGetIt() async {

  //cubits
  getIt.registerLazySingleton<OnboardingCubit>(()=>OnboardingCubit());
}