import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/helpers/extentions.dart';
import 'package:stylish/core/shared_widgets/custom_circular.dart';
import 'package:stylish/core/utils/app_colors.dart';

import '../../../../core/routes/app_route.dart';
import '../../logic/cubit/setting_cubit.dart';
import '../widgets/setting_item.dart';
import '../widgets/theme_button.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    BlocProvider.of<SettingCubit>(context).getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingCubit, SettingState>(
      listener: (context, state) {
        if (state is LogOut) {
          context.pushReplacementNamed(Routes.signInScreen);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Settings"),
            centerTitle: true,
            actions: const [ThemeButton()],
          ),
          body: ConditionalBuilder(
            condition: state is GetProfileSuccess || state is ChangeTheme,
            fallback: (context) => const Center(child: CustomCircular()),
            builder: (context) => Padding(
              padding: const EdgeInsets.all(25.0).w,
              child: Column(
                children: [
                  Text(
                    BlocProvider.of<SettingCubit>(context).userModel.name,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(BlocProvider.of<SettingCubit>(context).userModel.email),
                  SizedBox(
                    height: 20.h,
                  ),
                  SettingItem(
                    icon: Icons.person_2_outlined,
                    title: "Account Setting",
                    onTap: () {
                      context.pushNamed(Routes.accountSettingScreen);
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SettingItem(
                    icon: Icons.logout,
                    title: "Log out",
                    onTap: () {
                      BlocProvider.of<SettingCubit>(context).logout();
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
