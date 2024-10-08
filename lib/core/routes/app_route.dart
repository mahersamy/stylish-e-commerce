import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish/features/auth/presentions/screens/sign_up_screen.dart';
import 'package:stylish/features/cart/presentions/screens/address_screen.dart';
import 'package:stylish/features/cart/presentions/screens/cart_screen.dart';
import 'package:stylish/features/cart/presentions/screens/new_address_screen.dart';
import 'package:stylish/features/cart/presentions/screens/pay_screen.dart';
import 'package:stylish/features/home/presention/screens/home_layout.dart';
import 'package:stylish/features/home/presention/screens/product_detail_screen.dart';
import 'package:stylish/features/settings/presention/screens/setting_screen.dart';

import '../ shared_model/cart_model.dart';
import '../../features/auth/presentions/screens/sign_in_screen.dart';
import '../../features/cart/presentions/screens/cheackout_screen.dart';
import '../../features/home/data/models/home_model.dart';
import '../../features/home/data/models/product_model.dart';
import '../../features/home/presention/screens/all_category_screen.dart';
import '../../features/home/presention/screens/category_screen.dart';
import '../../features/onboarding/logic/cubit/onboarding_cubit.dart';
import '../../features/onboarding/presention/screens/loading_screen.dart';
import '../../features/onboarding/presention/screens/onboarding_screen.dart';
import '../../features/search/presention/screens/search_screen.dart';
import '../../features/settings/presention/screens/account_setting_screen.dart';
import '../di/dependency_injection.dart';

class Routes {
  static const String initRoute = "/loadingScreen";

  static const String onboardingScreen = "/onboardingScreen";
  static const String signInScreen = "/signInScreen";
  static const String signUpScreen = "/signUpScreen";
  static const String homeLayout = "/homeLayout";
  static const String allCategoryScreen = "/AllCategoryScreen";
  static const String categoryScreen = "/categoryScreen";
  static const String productDetailScreen = "/productDetailScreen";
  static const String cartScreen = "/cartScreen";
  static const String checkoutScreen = "/checkoutScreen";
  static const String addressScreen = "/addressScreen";
  static const String newAddressScreen = "/newAddressScreen";
  static const String payScreen = "/payScreen";

  static const String searchScreen = "/searchScreen";
  static const String settingScreen = "/settingScreen";
  static const String accountSettingScreen = "/accountSettingScreen";






}

class AppRoute {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case Routes.initRoute:
        return MaterialPageRoute(builder: (_) => const LoadingScreen());

      case Routes.onboardingScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getIt<OnboardingCubit>(),
                  child: const OnboardingScreen(),
                ));
      case Routes.signInScreen:
        return MaterialPageRoute(builder: (_) => const SignInScreen());

      case Routes.signUpScreen:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());

      case Routes.homeLayout:
        return MaterialPageRoute(builder: (_) => const HomeLayout());

      case Routes.allCategoryScreen:
        final dynamic arguments = settings.arguments;
        final List<CategoryModel> categoryModel = arguments[0];
        return MaterialPageRoute(
            builder: (_) => AllCategoryScreen(
                  categoryModelList: categoryModel,
                ));

      case Routes.categoryScreen:
        final dynamic arguments = settings.arguments;
        final CategoryModel categoryModel = arguments[0];
        return MaterialPageRoute(
            builder: (_) => CategoryScreen(
                  categoryModel: categoryModel,
                ));

      case Routes.productDetailScreen:
        final dynamic arguments = settings.arguments;
        final ProductModel productModel = arguments[0];
        return MaterialPageRoute(
            builder: (_) => ProductDetailScreen(productModel: productModel));

      case Routes.cartScreen:
        final dynamic arguments = settings.arguments;
        final List<CartModel> cartList = arguments;
        return MaterialPageRoute(
            builder: (_) => CartScreen(cartList: cartList));

      case Routes.checkoutScreen:
        return MaterialPageRoute(
            builder: (_) => const CheckoutScreen());

      case Routes.addressScreen:
        return MaterialPageRoute(
            builder: (_) => const AddressScreen());

      case Routes.newAddressScreen:
        return MaterialPageRoute(
            builder: (_) => const NewAddressScreen());

      case Routes.payScreen:
        return MaterialPageRoute(
            builder: (_) =>  const PayScreen());

      case Routes.searchScreen:
        return MaterialPageRoute(
            builder: (_) =>  const SearchScreen());

      case Routes.settingScreen:
        return MaterialPageRoute(
            builder: (_) =>  const SettingScreen());


      case Routes.accountSettingScreen:
        return MaterialPageRoute(
            builder: (_) =>  const AccountSettingScreen()
        );

    }

    return null;
  }
}

