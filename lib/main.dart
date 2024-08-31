import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/%20shared_model/cart_model.dart';
import 'package:stylish/features/cart/logic/cubits/cart_cubit.dart';
import 'package:stylish/features/home/logic/cubits/home_cubit.dart';

import 'core/di/dependency_injection.dart';
import 'core/routes/app_route.dart';
import 'core/theme/theme.dart';
import 'features/auth/logic/cubits/auth_cubit.dart';
import 'features/search/logic/cubits/search_cubit.dart';
import 'features/settings/logic/cubit/setting_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupGetIt();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await ScreenUtil.ensureScreenSize();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AuthCubit>()),
        BlocProvider(create: (context) => getIt<HomeCubit>()),
        BlocProvider(create: (context) => getIt<CartCubit>()),
        BlocProvider(create: (context) => getIt<SearchCubit>()),
        BlocProvider(create: (context) => getIt<SettingCubit>()),

      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AppRoute appRoute = AppRoute();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => MaterialApp(
        title: 'Stylish',
        theme: AppTheme().lightTheme(),
        darkTheme: AppTheme().darkTheme(),
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: appRoute.generateRoute,
        initialRoute: Routes.signInScreen,
      ),
    );
  }
}
