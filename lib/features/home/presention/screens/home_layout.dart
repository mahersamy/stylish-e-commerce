import 'package:flutter/material.dart';
import 'package:stylish/core/shared_widgets/bottom_nav_bar.dart';
import 'package:stylish/core/utils/app_assets.dart';
import 'package:stylish/features/home/presention/screens/home_screen.dart';




class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Image.asset( AppAssets.logo),),
      body:HomeScreen(),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
