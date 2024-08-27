import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:stylish/features/auth/data/repository/auth_repo.dart';
import 'package:stylish/features/auth/logic/cubits/auth_cubit.dart';
import 'package:stylish/features/cart/data/repository/cart_repo.dart';
import 'package:stylish/features/cart/logic/cubits/cart_cubit.dart';
import 'package:stylish/features/home/data/repository/home_repo.dart';
import 'package:stylish/features/home/logic/cubits/home_cubit.dart';
import 'package:stylish/features/search/data/search_repo.dart';

import '../../features/onboarding/logic/cubit/onboarding_cubit.dart';
import '../../features/search/logic/cubits/search_cubit.dart';
import '../database/api/api_consumer.dart';
import '../database/api/dio_consumer.dart';
import '../database/cache/cache_helper.dart';

GetIt getIt = GetIt.instance;

Future<void> setupGetIt() async {

  //cubits
  getIt.registerLazySingleton<OnboardingCubit>(()=>OnboardingCubit());
  getIt.registerLazySingleton<AuthCubit>(()=>AuthCubit(getIt()));
  getIt.registerLazySingleton<HomeCubit>(()=>HomeCubit(getIt()));
  getIt.registerLazySingleton<CartCubit>(()=>CartCubit(getIt()));
  getIt.registerLazySingleton<SearchCubit>(()=>SearchCubit(getIt()));




  //repository
  getIt.registerLazySingleton<AuthRepo>(()=>AuthRepo());
  getIt.registerLazySingleton<HomeRepo>(()=>HomeRepo());
  getIt.registerLazySingleton<CartRepo>(()=>CartRepo());
  getIt.registerLazySingleton<SearchRepo>(()=>SearchRepo());



  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: getIt()));
  getIt.registerLazySingleton<CacheHelper>(() => CacheHelper());



}