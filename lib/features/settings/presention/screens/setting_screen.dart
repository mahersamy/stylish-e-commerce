import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/setting_item.dart';


class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings"),centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(25.0).w,
        child: Column(
          children: [
            Text("Maher samy ",style: Theme.of(context).textTheme.headlineMedium,),
            SizedBox(height: 5.h,),
            Text("Lq8oH@example.com"),
            SizedBox(height: 20.h,),



            SettingItem(icon: Icons.person_2_outlined, title: "Profile",onTap: (){},),
            SizedBox(height: 20.h,),

            SettingItem(icon: Icons.color_lens_outlined, title: "Theme",onTap: (){},),
            SizedBox(height: 20.h,),
            

            SettingItem(icon: Icons.logout, title: "Log out",onTap: (){},),
          ],
        ),
      ),

    );
  }
}
