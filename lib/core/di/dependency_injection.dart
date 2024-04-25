import 'package:get_it/get_it.dart';
import 'package:stylish/features/auth/data/repository/auth_repo.dart';
import 'package:stylish/features/auth/logic/cubits/auth_cubit.dart';

import '../../features/onboarding/logic/cubit/onboarding_cubit.dart';

GetIt getIt = GetIt.instance;

Future<void> setupGetIt() async {

  //cubits
  getIt.registerLazySingleton<OnboardingCubit>(()=>OnboardingCubit());
  getIt.registerLazySingleton<AuthCubit>(()=>AuthCubit(getIt()));



  //repository
  getIt.registerLazySingleton<AuthRepo>(()=>AuthRepo());

}