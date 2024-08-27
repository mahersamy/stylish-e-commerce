import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/utils/app_colors.dart';

class SettingItem extends StatelessWidget {
  const SettingItem({super.key, this.onTap, required this.icon, required this.title});

  final VoidCallback? onTap;
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon,color: AppColors.mainColor,),
          SizedBox(
            width: 10.w,
          ),
          Text(title),
          const Spacer(),
          Icon(Icons.arrow_forward_ios,size: 20.w,),
        ],
      ),
    );
  }
}
