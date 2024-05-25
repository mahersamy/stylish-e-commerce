import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish/core/shared_widgets/bottom_nav_bar.dart';
import 'package:stylish/core/utils/app_assets.dart';

import '../../logic/cubits/home_cubit.dart';


class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit,HomeState>(
      builder: (context, state) {
         return Scaffold(
           appBar: AppBar(title: Image.asset(AppAssets.logo),),
           body: BlocProvider
               .of<HomeCubit>(context)
               .screens[BlocProvider
               .of<HomeCubit>(context)
               .currentIndex],
           bottomNavigationBar:  state is HomeInitial? const CustomBottomNavBar(): const CustomBottomNavBar(),
         );

      },
    );
  }
}
